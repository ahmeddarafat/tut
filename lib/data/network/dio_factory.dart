import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/app_prefs.dart';
import '../../app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// constants for this file
const String contentType = "content-type";
const String applicationJson = "application/json";
const String accept = "accept";
const String authorization = "authorization";
const String defaultLanguage = "language";

class DioFactory {
  final AppPrefs _appPrefs;
  DioFactory(this._appPrefs);

  late Dio _dio;

  Future<Dio> getDio() async {
    _dio = Dio();
    String language = _appPrefs.getAppLanguage();
    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constants.token,
      defaultLanguage: language
    };
    _dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      sendTimeout: Constants.apiTimeOut,
      receiveTimeout: Constants.apiTimeOut,
    );
    // kReleaseMode will be true if the app is at release mode
    // that check for security
    if (!kReleaseMode) {
      _dio.interceptors.add(
        // Pretty Dio logger is a Dio interceptor that logs network calls in a pretty, easy to read format.
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    return _dio;
  }
}
