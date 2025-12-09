import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:open_file/open_file.dart' as file;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

import '../error/failure.dart';
import '../widgets/my_snackbar.dart';

Future<void> openLink(String? url) async {
  if (url == null) return;

  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> callPhoneNumber(String? phoneNumber) async {
  if (phoneNumber == null) return;

  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not call $phoneNumber';
  }
}

Future<void> openEmail({required String? email}) async {
  if (email == null) return;
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    // query: [
    //   if (subject != null) 'subject=${Uri.encodeComponent(subject)}',
    //   if (body != null) 'body=${Uri.encodeComponent(body)}',
    // ].join('&'),
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not open email client for $email';
  }
}

String getFileNameFromUrl(String url) {
  return url.split('/').last;
}

Future<Either<Failure, String>> downloadFile(
    String url,
    BuildContext context,
    ) async {
  if (url.isEmpty) {
    return Left(AppFailure(message: "الرابط فارغ"));
  }

  // Request permissions only on Android
  if (Platform.isAndroid) {
    PermissionStatus permissionStatus =
    await Permission.manageExternalStorage.status;
    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.manageExternalStorage.request();
    }

    if (!permissionStatus.isGranted) {
      permissionStatus = await Permission.storage.request();
    }

    if (!permissionStatus.isGranted && !permissionStatus.isLimited) {
      FloatingSnackBar.show(
        context,
        "يرجى منح صلاحية الوصول للتخزين من الإعدادات",
        isError: true,
      );
      await openAppSettings();
      return Left(AppFailure(message: "فشل التحميل"));
    }
  }

  Dio dio = Dio();

  try {
    String fileName = getFileNameFromUrl(url);

    // Get platform-specific directory
    String filePath;
    if (Platform.isAndroid) {
      filePath = "/storage/emulated/0/Download/$fileName";
    } else if (Platform.isIOS) {
      final directory = await getApplicationDocumentsDirectory();
      filePath = "${directory.path}/$fileName";
    } else {
      final directory = await getDownloadsDirectory();
      filePath = "${directory?.path ?? '.'}/$fileName";
    }

    await dio.download(
      url,
      filePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          double progress = (received / total) * 100;
          debugPrint("Download Progress: ${progress.toStringAsFixed(2)}%");
          FloatingSnackBar.show(
            context,
            "جاري التحميل",
            progress: progress,
            isError: false,
          );
        }
      },
    );

    // Media scan only on Android
    if (Platform.isAndroid) {
      await MediaScanner.loadMedia(path: filePath);
    }

    // Open the file after download
    final result = await file.OpenFile.open(filePath);

    if (result.type == file.ResultType.done) {
      return Right("تم فتح الملف: $filePath");
    } else {
      return Left(AppFailure(message: "فشل في فتح الملف: ${result.message}"));
    }
  } catch (e) {
    return Left(AppFailure(message: "فشل التحميل: $e"));
  }
}

