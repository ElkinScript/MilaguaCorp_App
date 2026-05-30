import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Logger centralizado de Milagua, copia el estilo del Support:
///  - PrettyPrinter para todos los logs
///  - Mensajes prefijados con la clase de origen y método
///  - Helpers para request / response / errores Dio / SQLite / storage
///
/// Solo emite en debug (`kDebugMode`).
final _logger = Logger(
  printer: SimpleLogPrinter(),
  level: Level.debug,
);

class SimpleLogPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level]!;
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    return [
      color('─' * 40),
      color('$emoji ${event.message}'),
    ];
  }
}

/// Helper genérico — equivalente al `errorLogger` original de Support.
void errorLogger({
  required String? message,
  required String functionName,
  required String fileName,
}) {
  if (kDebugMode) {
    _logger.e('ERROR: $message in $functionName on $fileName');
  }
}

/// Logger para eventos de depuración (init, request, response, storage, ...).
class DebugLogger {
  DebugLogger(this.className);
  final Type className;

  void init() => _logger.d('$className => init');

  void regular(String message, [String? methodName]) {
    var msg = '$className => $message';
    if (methodName != null) msg = '$msg in $methodName method';
    _logger.d(msg);
  }

  void methodInit(String method) =>
      _logger.d('$className => init $method method');

  void request(String methodName, [Object? payload]) {
    final encoder = const JsonEncoder.withIndent('     ');
    var msg = '$className => request in method $methodName';
    if (payload != null) msg = '$msg with payload:\n${encoder.convert(payload)}';
    _logger.d(msg);
  }

  void response(String methodName, [Object? data]) {
    final encoder = const JsonEncoder.withIndent('     ');
    var msg = '$className => response in method $methodName';
    if (data != null) msg = '$msg with data:\n${encoder.convert(data)}';
    _logger.d(msg);
  }

  void toLocalStorage(String methodName, [Object? data]) {
    final encoder = const JsonEncoder.withIndent('     ');
    var msg = '$className => updated local storage in $methodName';
    if (data != null) msg = '$msg with data:\n${encoder.convert(data)}';
    _logger.d(msg);
  }

  void fromLocalStorage(String methodName, [Object? data]) {
    final encoder = const JsonEncoder.withIndent('     ');
    var msg = '$className => read local storage in $methodName';
    if (data != null) msg = '$msg with data:\n${encoder.convert(data)}';
    _logger.d(msg);
  }
}

class InformationLogger {
  InformationLogger(this.className);
  final Type className;

  void regular(String message) => _logger.i('$className => $message');
  void success() => _logger.i('$className => Success');
}

class ErrorLogger {
  ErrorLogger(this.className);
  final Type className;

  void regular(dynamic message, [String? methodName]) {
    var msg = '$className => $message';
    if (methodName != null) msg = '$msg in $methodName method';
    _logger.e(msg);
  }

  void dio(DioException error, [String? methodName]) {
    final encoder = const JsonEncoder.withIndent('     ');
    var msg =
        '$className => ${error.message} ${encoder.convert(error.response?.data ?? '')}';
    if (methodName != null) msg = '$msg in $methodName method';
    _logger.e(msg);
  }

  void dioWithStackTrace(DioException error, [String? methodName]) {
    var msg = '$className => $error';
    if (methodName != null) msg = '$msg in $methodName method';
    _logger.e(msg);
  }
}
