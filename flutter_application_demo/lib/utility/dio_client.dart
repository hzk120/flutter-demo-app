import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  final _baseUrl = 'https://localhost:7213/api/';
  late final Dio _dio;

  DioClient() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio => _dio;
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final prefs = SharedPreferences.getInstance();

    prefs.then((pref) {
      pref.getString("jwtToken") != null
          ? options.headers['Authorization'] =
              "Bearer ${pref.getString("jwtToken")}"
          : "";
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // switch (err.type) {
    //   case DioErrorType.connectTimeout:
    //   case DioErrorType.sendTimeout:
    //   case DioErrorType.receiveTimeout:
    //     throw DeadlineExceededException(err.requestOptions);
    //   case DioErrorType.response:
    //     switch (err.response?.statusCode) {
    //       case 400:
    //         throw BadRequestException(err.requestOptions);
    //       case 401:
    //         throw UnauthorizedException(err.requestOptions);
    //       case 404:
    //         throw NotFoundException(err.requestOptions);
    //       case 409:
    //         throw ConflictException(err.requestOptions);
    //       case 500:
    //         throw InternalServerErrorException(err.requestOptions);
    //     }
    //     break;
    //   case DioErrorType.cancel:
    //     break;
    //   case DioErrorType.other:
    //     throw NoInternetConnectionException(err.requestOptions);
    // }

    super.onError(err, handler);

    //return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
