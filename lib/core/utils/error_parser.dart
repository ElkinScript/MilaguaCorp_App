import 'package:dio/dio.dart';

String parseError(Object error) {
  if (error is DioException) return _parseDioError(error);
  return 'Ocurrió un error inesperado. Intenta de nuevo.';
}

String _parseDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'La conexión tardó demasiado. Verifica tu red e intenta de nuevo.';
    case DioExceptionType.connectionError:
      return 'Sin conexión a internet. Verifica tu WiFi o datos móviles.';
    case DioExceptionType.badCertificate:
      return 'No se pudo verificar la conexión segura con el servidor.';
    case DioExceptionType.cancel:
      return 'Solicitud cancelada.';
    case DioExceptionType.badResponse:
    case DioExceptionType.unknown:
      final data = error.response?.data;
      if (data is Map) {
        final raw = _extractDetail(data);
        if (raw != null) return _translate(raw);
      }
      if (error.response == null) {
        // Sin respuesta del servidor: no hay red o el servidor no está disponible.
        return 'Sin conexión a internet. Verifica tu WiFi o datos móviles.';
      }
      return 'Ocurrió un error inesperado. Intenta de nuevo.';
  }
}

String? _extractDetail(Map data) {
  if (data.containsKey('detail')) return _unwrap(data['detail']);
  if (data.containsKey('message')) return _unwrap(data['message']);
  if (data.containsKey('non_field_errors')) {
    return _unwrap(data['non_field_errors']);
  }
  if (data.isNotEmpty) return _unwrap(data.values.first);
  return null;
}

// DRF a veces envuelve el mensaje en una lista (ej. errores de validación de
// campo: {"campo": ["mensaje"]}) — sin esto, List.toString() deja corchetes
// literales en el texto mostrado al usuario.
String _unwrap(Object? value) {
  if (value is List && value.isNotEmpty) return value.first.toString();
  return value.toString();
}

// Mensajes conocidos del backend (DRF / SimpleJWT) traducidos al español.
const _kKnownMessages = <String, String>{
  'No active account found with the given credentials':
      'Usuario o contraseña incorrectos.',
  'This field is required.': 'Este campo es obligatorio.',
  'Given token not valid for any token type':
      'Tu sesión expiró. Vuelve a iniciar sesión.',
  'Token is invalid or expired': 'Tu sesión expiró. Vuelve a iniciar sesión.',
  'Authentication credentials were not provided.':
      'No se proporcionaron credenciales de acceso.',
  'You do not have permission to perform this action.':
      'No tienes permiso para realizar esta acción.',
};

String _translate(String raw) {
  if (_kKnownMessages.containsKey(raw)) return _kKnownMessages[raw]!;
  if (raw.startsWith('Request was throttled')) {
    return 'Demasiadas solicitudes. Espera un momento e intenta de nuevo.';
  }
  return raw;
}
