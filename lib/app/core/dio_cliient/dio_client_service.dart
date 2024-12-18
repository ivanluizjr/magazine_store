import 'package:magazine_store/app/core/dio_cliient/dio_response.dart';

abstract class IDioClientService {
  Future<DioResponse> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  });

  Future<DioResponse> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });

  Future<DioResponse> delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });

  Future<DioResponse> put(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
  });
}
