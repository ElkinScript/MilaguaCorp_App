import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:milaguacorp/modules/common/drivers/storage/local_storage.dart';

/// LocalStorage en memoria (reemplaza flutter_secure_storage en tests).
class InMemoryStorage implements LocalStorage {
  InMemoryStorage([Map<String, String>? initial]) : data = {...?initial};

  final Map<String, String> data;
  int removeAllCalls = 0;

  @override
  Future<void> setItem(String key, String value) async => data[key] = value;

  @override
  Future<String?> getItem(String key) async => data[key];

  @override
  Future<void> removeItem(String key) async => data.remove(key);

  @override
  Future<void> removeAll() async {
    removeAllCalls++;
    data.clear();
  }

  @override
  Future<bool> containsItem(String key) async => data.containsKey(key);
}

/// Respuesta simulada del backend.
class FakeResponse {
  const FakeResponse(this.status, [this.body]);

  final int status;
  final Object? body;
}

typedef FakeHandler = FutureOr<FakeResponse> Function(RequestOptions options);

/// HttpClientAdapter falso: enruta cada request a [handler] y registra todo
/// lo que pasó por la "red".
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.handler);

  FakeHandler handler;
  final List<RequestOptions> requests = [];

  List<RequestOptions> requestsTo(String path) =>
      requests.where((r) => r.uri.path == path).toList();

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final res = await handler(options);
    return ResponseBody.fromString(
      res.body == null ? '' : jsonEncode(res.body),
      res.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String? bearerOf(RequestOptions options) {
  final header = options.headers['Authorization'];
  if (header is! String) return null;
  return header.replaceFirst('Bearer ', '');
}
