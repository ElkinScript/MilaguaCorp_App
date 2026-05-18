import 'package:dio/dio.dart';

String parseError(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map) {
      if (data.containsKey('detail')) return data['detail'].toString();
      if (data.containsKey('message')) return data['message'].toString();
      if (data.containsKey('non_field_errors')) {
        final v = data['non_field_errors'];
        if (v is List && v.isNotEmpty) return v.first.toString();
      }
      if (data.isNotEmpty) return data.values.first.toString();
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return 'Tiempo de conexión agotado. Verifica tu red.';
    }
    if (error.type == DioExceptionType.connectionError) {
      return 'Sin conexión. Verifica tu red.';
    }
  }
  return error.toString();
}
