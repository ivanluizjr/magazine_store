import 'package:dio/dio.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_client_service.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_failure.dart';
import 'package:magazine_store/app/core/dio_cliient/dio_response.dart';

class DioClientServiceImpl implements IDioClientService {
  final Dio dio;

  const DioClientServiceImpl({
    required this.dio,
  });

  @override
  Future<DioResponse> get(
    final String url, {
    final Map<String, dynamic>? headers,
    final Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
      );
      final data = response.data;

      if (data is Map && data.containsKey('error')) {
        throw const DioFailure(
          statusCode: 500,
        );
      }

      return DioResponse(
        response.data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (error) {
      throw DioFailure(
        statusCode: error.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<DioResponse> delete(
    final String url, {
    final Map<String, dynamic>? headers,
    final Map<String, dynamic>? queryParams,
    final Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.delete(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
        data: body,
      );

      final data = response.data;

      if (data is Map && data.containsKey('error')) {
        throw const DioFailure(
          statusCode: 500,
        );
      }
      return DioResponse(
        data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (error) {
      throw DioFailure(
        statusCode: error.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<DioResponse> post(
    final String url, {
    final Map<String, dynamic>? headers,
    final Map<String, dynamic>? queryParams,
    final Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.post(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
        data: body,
      );

      final data = response.data;

      if (data is Map && data.containsKey('error')) {
        throw const DioFailure(
          statusCode: 500,
        );
      }

      return DioResponse(
        data,
        statusCode: response.statusCode ?? 500,
        cookies: response.headers.map["set-cookie"] ?? [],
      );
    } on DioException catch (error) {
      throw DioFailure(
        statusCode: error.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<DioResponse> put(
    final String url, {
    final Map<String, dynamic>? headers,
    final Map<String, dynamic>? queryParams,
    final Map<String, dynamic>? body,
  }) async {
    try {
      final response = await dio.put(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
        ),
        data: body,
      );
      final data = response.data;

      if (data is Map && data.containsKey('error')) {
        throw const DioFailure(
          statusCode: 500,
        );
      }
      return DioResponse(
        data,
        statusCode: response.statusCode ?? 500,
      );
    } on DioException catch (error) {
      throw DioFailure(
        statusCode: error.response?.statusCode ?? 500,
      );
    }
  }
}
