import 'package:dio/dio.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.response:
      final code = error.response?.statusCode;
      final message = error.response?.statusMessage;
      if (code != null && message != null) {
        return Failure(code, message);
      } else {
        return DataSource.unknown.getFailure();
      }
    case DioErrorType.connectTimeout:
      return DataSource.connectTimeout.getFailure();

    case DioErrorType.sendTimeout:
      return DataSource.sendTimeout.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.recieveTimeout.getFailure();

    case DioErrorType.cancel:
      return DataSource.cancel.getFailure();

    case DioErrorType.other:
      return DataSource.unknown.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  recieveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorised:
        return Failure(ResponseCode.unauthorised, ResponseMessage.unauthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.recieveTimeout:
        return Failure(
            ResponseCode.recieveTimeout, ResponseMessage.recieveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      default:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ResponseCode {
  /// external status code
  static const int success = 200; // success with data
  static const int noContent = 201; // success without data

  static const int badRequest = 400;
  static const int unauthorised = 401; // user is not authorised
  static const int forbidden = 403;
  static const int notFound = 404;

  static const int internalServerError = 500; // crash in server side

  /// local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int recieveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String success = "success"; // success with data
  static const String noContent =
      "success"; // success with no data (no content)
  static const String badRequest =
      "Bad request, Try again later"; // failure, API rejected request
  static const String unauthorised =
      "User is unauthorised, Try again later"; // failure, user is not authorised
  static const String forbidden =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String notFound =
      "not found, Try again later"; //  failure, API rejected request
  static const String internalServerError =
      "Some thing went wrong, Try again later"; // failure, crash in server side

  // local status code
  static const String connectTimeout = "Time out error, Try again later";
  static const String cancel = "Request was cancelled, Try again later";
  static const String recieveTimeout = "Time out error, Try again later";
  static const String sendTimeout = "Time out error, Try again later";
  static const String cacheError = "Cache error, Try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
  static const String unknown = "Some thing went wrong, Try again later";
}

class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}