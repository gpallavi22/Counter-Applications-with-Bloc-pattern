import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  final Future<String?> Function() getToken;
  DioInterceptor({required this.getToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("REQUEST[${options.method}] => PATH: ${options.path}");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("RESPONSE[${response.statusCode}] => DATA: ${response.data}");
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("ERROR[${err.response?.statusCode}] => ${err.message}");
    return handler.next(err);
  }
}
