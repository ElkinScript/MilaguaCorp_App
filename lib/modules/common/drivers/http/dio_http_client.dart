import 'package:dio/dio.dart';
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

  /// Returns the singleton [Dio] instance, creating it on first call.
  Dio call() => _dio ??= _createDio();

  Dio _createDio() {
    final dio = Dio()
      ..options.baseUrl = FlavorConfig.instance.baseUrl
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);

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

    return dio;
  }
}
