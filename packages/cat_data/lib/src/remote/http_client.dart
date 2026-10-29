import 'package:dio/dio.dart';

/// CUSTOM App HTTP 客户端
///
/// 基于 Dio 封装，配置基础 URL、超时和拦截器链。
/// 拦截器顺序：Mock（最高优先级）→ 日志 → 错误处理
class CatHttpClient {
  late final Dio dio;

  CatHttpClient({required List<Interceptor> interceptors}) {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.cat-mine.example.com/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // 按优先级顺序添加拦截器
    for (final interceptor in interceptors) {
      dio.interceptors.add(interceptor);
    }
  }

  /// GET 请求
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get<T>(path, queryParameters: queryParameters);
  }

  /// POST 请求
  Future<Response<T>> post<T>(String path, {dynamic data}) {
    return dio.post<T>(path, data: data);
  }

  /// PUT 请求
  Future<Response<T>> put<T>(String path, {dynamic data}) {
    return dio.put<T>(path, data: data);
  }

  /// DELETE 请求
  Future<Response<T>> delete<T>(String path) {
    return dio.delete<T>(path);
  }
}