import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: "https://jsonplaceholder.typicode.com",
              connectTimeout: Duration(seconds: 10),
              receiveTimeout: Duration(seconds: 10),
              headers: {"Content-Type": "application/json"},
            ),
          ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          return handler.next(response);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          return handler.next(error);
        },
      ),
    );
  }
  Dio get client => _dio;
}
