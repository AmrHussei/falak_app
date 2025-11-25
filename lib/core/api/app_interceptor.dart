import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:falak/core/api/end_point.dart';

import '../network/socket/socket_service.dart';
import '../storage/flutter_secure_storage.dart';
import '../utils/app_strings.dart';
import '../utils/utils.dart';
import '../widgets/guest_dialog.dart';
import 'status_code.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    // If this is a POST request and KisAnonymous is true, show a guest dialog
    if (options.method.toUpperCase() == 'POST' &&
        GlobalVar.KisAnonymous == true) {
      debugPrint(
          'This is a POST request and KisAnonymous is true. Showing guest dialog.');
      showGuestDialog();
      return; // Stop the request
    }

    // Set base URL, response type, and other settings
    options
      ..getCacheOptions()
      ..baseUrl = EndPoint.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internetServerError;
      }
      ..sendTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60)
      ..headers = {
        AppStrings.contentType: AppStrings.applicationJson,
        'Accept': 'application/json',
      };
    final String? cookie =
        await SecureStorageServices().getCookie();
    if (cookie != null) {
    options.headers["Cookie"] =
        '$cookie'; //cookie;
    print('cashed coocke $cookie');
    }

    debugPrint('options.headers: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // if ((response.statusCode == 401)) {
    //   navigatorKey.currentState?.pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (_) => LoginScreen()),
    //     (route) => false,
    //   );
    // }
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    debugPrint('RESPONSE HEADERS: ${response.headers}');

    // List<String>? cookies = response.headers['set-cookie'];
    // print("response.headers['set-cookie'] ${response.headers['set-cookie']}");
    // if (cookies != null && cookies.isNotEmpty) {
    //   String? connectSid = cookies // cookies.first;
    //       .firstWhere(
    //         (cookie) => cookie.startsWith('connect.sid='),
    //         orElse: () => '',
    //       )
    //       .split(';')
    //       .firstWhere(
    //         (segment) => segment.trim().startsWith('connect.sid='),
    //         orElse: () => '',
    //       )
    //       .trim();
    if (response.headers['set-cookie'] != null) {
      await SecureStorageServices()
          .setCookie(cookie: response.headers['set-cookie']?.first);

      log('login cookie ${response.headers['set-cookie']!}');
      log('data ${response.data}');
      String? connectSid = await SecureStorageServices().getCookie();
      SocketService().token = connectSid;
      debugPrint('connect.sid saved: $connectSid');
      print('Now Start cashe coocke $connectSid');
    } else {
      SocketService().token = null;
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
