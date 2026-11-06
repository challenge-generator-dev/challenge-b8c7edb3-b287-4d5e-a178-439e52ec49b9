package pedidos_app.core.network;

import 'package:dio/dio.dart';
import 'package:pedidos_app/core/constants/api_constants.dart';
import 'package:pedidos_app/core/errors/exceptions.dart';

class ApiClient {
  final Dio _dio;
  final String _baseUrl;
  final int _connectTimeout;
  final int _receiveTimeout;

  ApiClient({
    Dio? dio,
    String? baseUrl,
    int? connectTimeout,
    int? receiveTimeout,
  })  : _dio = dio ?? Dio(),
        _baseUrl = baseUrl ?? ApiConstants.baseUrl,
        _connectTimeout = connectTimeout ?? ApiConstants.connectTimeout,
        _receiveTimeout = receiveTimeout ?? ApiConstants.receiveTimeout {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: Duration(milliseconds: _connectTimeout),
      receiveTimeout: Duration(milliseconds: _receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.addAll([
      _LoggingInterceptor(),
      _ErrorInterceptor(),
    ]);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await _dio.get(url);
      return _parseListResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> getOrderById(String id) async {
    try {
      final url = ApiConstants.buildOrderByIdUrl(id);
      final response = await _dio.get(url);
      return _parseMapResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.ordersEndpoint);
      final response = await _dio.post(url, data: orderData);
      return _parseMapResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final url = ApiConstants.buildUrl(ApiConstants.productsEndpoint);
      final response = await _dio.get(url);
      return _parseListResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  List<Map<String, dynamic>> _parseListResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
      throw ParseException(
        message: 'Expected list response but got ${data.runtimeType}',
        source: data,
      );
    }
    throw ServerException(
      message: 'Unexpected status code: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }

  Map<String, dynamic> _parseMapResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return data;
      }
      throw ParseException(
        message: 'Expected map response but got ${data.runtimeType}',
        source: data,
      );
    }
    throw ServerException(
      message: 'Unexpected status code: ${response.statusCode}',
      statusCode: response.statusCode,
    );
  }

  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout. Please check your internet connection.',
          underlyingError: error.message,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network settings.',
          underlyingError: error.message,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        String message = 'Server error occurred';
        String? errorCode;

        if (data is Map<String, dynamic>) {
          message = data['message'] ?? data['error'] ?? message;
          errorCode = data['code'] ?? data['errorCode'];
        }

        if (statusCode == 401 || statusCode == 403) {
          return AuthenticationException(message: message);
        }

        return ServerException(
          message: message,
          statusCode: statusCode,
          errorCode: errorCode,
        );
      case DioExceptionType.cancel:
        return ServerException(
          message: 'Request was cancelled',
          statusCode: null,
        );
      default:
        return NetworkException(
          message: 'An unexpected network error occurred',
          underlyingError: error.message,
        );
    }
  }

  Dio get dio => _dio;
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ REQUEST: ${options.method} ${options.path}');
    print('│ Base URL: ${options.baseUrl}');
    if (options.queryParameters.isNotEmpty) {
      print('│ Query Params: ${options.queryParameters}');
    }
    if (options.data != null) {
      print('│ Body: ${options.data}');
    }
    print('└─────────────────────────────────────────────────────────────');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ RESPONSE: ${response.statusCode} ${response.requestOptions.path}');
    print('│ Data: ${response.data}');
    print('└─────────────────────────────────────────────────────────────');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('┌─────────────────────────────────────────────────────────────');
    print('│ ERROR: ${err.type}');
    print('│ Message: ${err.message}');
    if (err.response != null) {
      print('│ Status Code: ${err.response?.statusCode}');
      print('│ Response Data: ${err.response?.data}');
    }
    print('└─────────────────────────────────────────────────────────────');
    handler.next(err);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 429) {
      print('Rate limit exceeded. Consider adding retry logic.');
    }
    handler.next(err);
  }
}