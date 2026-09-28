import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionEventsProvider = Provider<SessionEvents>((ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
});

/// Bus mínimo de eventos de sesión entre la capa HTTP y el feature de auth.
///
/// El cliente HTTP no puede depender del AuthController (el controller
/// depende del cliente HTTP a través del service), así que cuando el refresh
/// del token falla la capa HTTP sólo avisa por aquí y el AuthController —que
/// está suscrito— pasa el estado a no autenticado; el redirect de go_router
/// hace el resto (manda a /login).
class SessionEvents {
  final _expired = StreamController<void>.broadcast();

  Stream<void> get onExpired => _expired.stream;

  void notifyExpired() {
    if (!_expired.isClosed) _expired.add(null);
  }

  void dispose() => _expired.close();
}
