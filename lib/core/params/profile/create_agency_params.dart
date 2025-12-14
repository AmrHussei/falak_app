import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class CreateAgencyParams extends Equatable {
  final File agencyAttachment;
  final String agencyName;
  final String agencyNumber;
  final String agencyIssuedDate;
  final String agencyIdentityNumber;

  CreateAgencyParams({
    required this.agencyName,
    required this.agencyNumber,
    required this.agencyIssuedDate,
    required this.agencyAttachment,
    required this.agencyIdentityNumber,
  });

  @override
  List<Object?> get props => [
    agencyAttachment,
    agencyIssuedDate,
    agencyNumber,
    agencyIdentityNumber,
    agencyName,
  ];

  Future<FormData> toFormData() async {
    Future<MultipartFile> _createMultipartFile(File file) async {
      final String mimeType =
          lookupMimeType(file.path) ?? 'application/octet-stream';
      final List<String> mimeParts = mimeType.split('/');

      if (mimeParts.length != 2) {
        throw UnsupportedError('Invalid MIME type: $mimeType');
      }

      return await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType(mimeParts[0], mimeParts[1]),
      );
    }

    FormData formData = FormData.fromMap({
      'agencyName': agencyName,
      'agencyNumber': agencyNumber,
      'agencyIssuedDate': agencyIssuedDate,
      'identityNumber': agencyIdentityNumber,
      "agencyAttachment": await _createMultipartFile(agencyAttachment),
    });

    return formData;
  }
}
