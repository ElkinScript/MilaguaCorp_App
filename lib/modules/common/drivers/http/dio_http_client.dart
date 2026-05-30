import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/flavors/flavors_config.dart';
import '../storage/local_storage.dart';
import '../storage/local_storage_impl.dart';

final dioHttpClientProvider = Provider<DioHttpClient>(
  (ref) {
    final localDataSource = ref.watch(secureLocalDataSourceProvider);
    return DioHttpClient(localDataSource);
  },
);

class DioHttpClient {
  DioHttpClient(this.localDataSource);

  final LocalStorage localDataSource;
  Dio? _dio;

  /// Singleton Dio — interceptors y headers se configuran una sola vez.
  Dio call() => _dio ??= _createDio();

  Dio _createDio() {
    final dio = Dio()
      ..options.baseUrl = FlavorConfig.instance.baseUrl
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);

    // ── Interceptor de autenticación + headers comunes ──────────
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token =
              await localDataSource.getItem(AppStrings.keyTokenAccess);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Content-Type'] = 'application/json';
          options.headers['app-source'] = 'milaguacorp-app';
          options.baseUrl = FlavorConfig.instance.baseUrl;
          return handler.next(options);
        },
      ),
    );

    // ── Interceptor de logging (sólo en debug) ──────────────────
    // Imprime cada request / response / error con formato bonito
    // exactamente como hace Hey Support en su terminal.
    if (kDebugMode) {
      dio.interceptors.add(_PrettyLogInterceptor());
    }

    return dio;
  }
}

/// Interceptor de logs estilo Support.
/// Imprime: método, URL, headers, body, status code y data.
class _PrettyLogInterceptor extends Interceptor {
  static const _bar = '────────────────────────────────────────';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\n$_bar');
    debugPrint('➡️  REQUEST  ${options.method}  ${options.uri}');
    if (options.headers.isNotEmpty) {
      debugPrint('   Headers: ${_pretty(options.headers)}');
    }
    if (options.data != null) {
      debugPrint('   Body:    ${_pretty(options.data)}');
    }
    if (options.queryParameters.isNotEmpty) {
      debugPrint('   Query:   ${_pretty(options.queryParameters)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\n$_bar');
    debugPrint(
        '✅ RESPONSE ${response.statusCode}  ${response.requestOptions.method}  ${response.requestOptions.uri}');
    if (response.data != null) {
      debugPrint('   Data:    ${_pretty(response.data)}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\n$_bar');
    debugPrint(
        '❌ ERROR    ${err.response?.statusCode ?? '---'}  ${err.requestOptions.method}  ${err.requestOptions.uri}');
    debugPrint('   Type:    ${err.type}');
    debugPrint('   Message: ${err.message}');
    if (err.response?.data != null) {
      debugPrint('   Body:    ${_pretty(err.response?.data)}');
    }
    handler.next(err);
  }

  String _pretty(Object? data) {
    try {
      return const JsonEncoder.withIndent('  ').convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}
