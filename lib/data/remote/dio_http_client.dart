import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:earnipay_image_search/util/exceptions/exceptions.dart';
import 'package:injectable/injectable.dart';

typedef HttpLibraryMethod<T> = Future<Response<T>> Function();

const String clientId = String.fromEnvironment("ClientId", defaultValue: "");

class _DioService extends DioForNative {
  _DioService() : super() {
    options = BaseOptions(
      baseUrl: "https://api.unsplash.com/",
      connectTimeout: 60000,
      receiveTimeout: 60000,
      contentType: "application/json",
    );
    interceptors.addAll([_AppInterceptors()]);
  }
}

class _AppInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': 'Client-ID $clientId'});
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    return handler.next(error);
  }
}

@singleton
class DioHttpClient {
  late final Dio _client;

  DioHttpClient() {
    _client = _DioService();
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _mapException(
      () => _client.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }

  Future<Response<T>> _mapException<T>(HttpLibraryMethod<T> method) async {
    try {
      return await method();
    } on DioError catch (exception) {
      switch (exception.type) {
        case DioErrorType.cancel:
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.sendTimeout:
          throw ConnectionException(exception.type);
        case DioErrorType.response:
          final response = exception.response;
          int statusCode = response?.statusCode ?? 0;
          if (response == null || response is! Response<T>) {
            throw UnknownError(exception, StackTrace.current);
          }
          switch (statusCode) {
            case 400:
            case 401:
            case 403:
            case 404:
            case 409:
            case 429:
            case 406:
            case 422:
              throw ClientSideError(
                errorCode: response.statusCode,
                data: response.data,
              );
          }
          throw ServerSideError(
            errorCode: response.statusCode,
            data: response.data,
          );
        default:
          if (exception.error is ServerSideError ||
              exception.error is HandshakeException ||
              exception.error is SocketException ||
              exception.error is TimeoutException) {
            throw ConnectionException(exception.type);
          } else {
            throw UnknownError(exception, StackTrace.current);
          }
      }
    } catch (exception, stackTrace) {
      throw UnknownError(exception, stackTrace);
    }
  }
}
