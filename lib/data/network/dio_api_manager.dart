import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc_pattern/data/aes_helper.dart';
import 'package:bloc_pattern/data/network/dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioAPIManager {
  final Dio dio;

  DioAPIManager()
      : dio = Dio(
          BaseOptions(
            baseUrl: "https://api.example.com",
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        ) {
    dio.interceptors.add(
      DioInterceptor(getToken: () async {
        final prefs = await SharedPreferences.getInstance();
        return prefs.getString('access_token');
      }),
    );
  }

  /// ✅ GET API
  Future<dynamic> getAPICall({
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    int timeout = 30,
  }) async {
    try {
      dio.options.headers.addAll(headers ?? {});

      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
          sendTimeout: Duration(seconds: timeout),
          receiveTimeout: Duration(seconds: timeout),
        ),
      );

      dynamic decrypted;

      if (response.data is String) {
        decrypted = AESHelper.decryptData(response.data);
      }

      logAPICallDetails(
        response,
        decryptedResponse: decrypted,
      );

      return decrypted ?? response.data; // ✅ FIXED
    } on DioException catch (e) {
      _logError(e);
      return null;
    }
  }

  /// ✅ POST API
  Future<dynamic> postAPICall({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    int timeout = 60,
  }) async {
    try {
      dio.options.headers.addAll(headers ?? {});

      /// 🔐 Convert + Encrypt
      final jsonString = jsonEncode(body);
      final encryptedBody = AESHelper.encryptData(body);

      final response = await dio.post(
        url,
        data: {"payload": encryptedBody},
        queryParameters: queryParameters,
        options: Options(
          sendTimeout: Duration(seconds: timeout),
          receiveTimeout: Duration(seconds: timeout),
        ),
      );

      dynamic decrypted;

      if (response.data is String) {
        decrypted = AESHelper.decryptData(response.data);
      }

      logAPICallDetails(
        response,
        decryptedRequest: jsonDecode(jsonString),
        decryptedResponse: decrypted,
      );

      return decrypted ?? response.data;
    } on DioException catch (e) {
      _logError(e);
      return null;
    }
  }

  /// 🔴 ERROR LOG
  void _logError(DioException error) {
    if (!kDebugMode) return;

    log('\x1B[31m❌ ERROR => ${error.message}\x1B[0m');
    log('\x1B[31mURL => ${error.requestOptions.uri}\x1B[0m');
    log('\x1B[31mRESPONSE => ${error.response?.data}\x1B[0m');
  }

  /// 📡 LOG METHOD
  void logAPICallDetails(
    Response response, {
    dynamic decryptedRequest,
    dynamic decryptedResponse,
  }) {
    if (!kDebugMode) return;

    log('\x1B[90m<--------------------------- 📡 API CALL --------------------------->\x1B[0m');

    debugPrint('\x1B[34m🟦 Headers => \x1B[36m${response.requestOptions.headers}\x1B[0m');

    log('\x1B[35m🟪 Url => \x1B[95m${response.requestOptions.uri}\x1B[0m');

    log('\x1B[37m⚙️ Method => ${response.requestOptions.method}\x1B[0m');

    if (response.requestOptions.queryParameters.isNotEmpty) {
      log('\x1B[33m🟨 Query => ${response.requestOptions.queryParameters}\x1B[0m');
    }

    if (response.requestOptions.data != null) {
      log('\x1B[33m🟨 Encrypted Request => \x1B[93m${response.requestOptions.data}\x1B[0m');
    }

    if (decryptedRequest != null) {
      log('\x1B[36m🟦 Decrypted Request => \x1B[96m$decryptedRequest\x1B[0m');
    }

    log('\x1B[31m🟥 Raw Response => ${response.data}\x1B[0m');

    if (decryptedResponse != null) {
      log('\x1B[32m🟩 Decrypted Response => \x1B[92m$decryptedResponse\x1B[0m');
    }

    log('\x1B[37m📊 Status Code => ${response.statusCode}\x1B[0m');

    log('\x1B[90m<--------------------------- END --------------------------->\x1B[0m\n');
  }
}
