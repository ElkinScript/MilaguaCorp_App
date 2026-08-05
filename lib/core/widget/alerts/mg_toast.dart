import 'package:flutter/material.dart';

enum MgToastType { success, warning, error }

/// Banner de estado (semaforización) reutilizable — se muestra arriba de la
/// pantalla y se oculta solo. Verde = correcto, amarillo = advertencia,
/// rojo = error.
///
/// ```dart
/// MgToast.success(context, 'Venta registrada correctamente');
/// MgToast.warning(context, 'Quedan pocas unidades en stock');
/// MgToast.error(context, 'No se pudo registrar la venta');
/// ```
class MgToast {
  MgToast._();

  static void success(BuildContext context, String message) =>
      show(context, message, type: MgToastType.success);

  static void warning(BuildContext context, String message) =>
      show(context, message, type: MgToastType.warning);

  static void error(BuildContext context, String message) =>
      show(context, message, type: MgToastType.error);

  static void show(
    BuildContext context,
    String message, {
    MgToastType type = MgToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _MgToastWidget(
        message: message,
        type: type,
        onDismiss: () {
          if (entry.mounted) entry.remove();
        },
      ),
    );
    overlay.insert(entry);
    Future.delayed(duration, () {
      if (entry.mounted) entry.remove();
    });
  }
}

class _MgToastWidget extends StatefulWidget {
  const _MgToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  final String message;
  final MgToastType type;
  final VoidCallback onDismiss;

  @override
  State<_MgToastWidget> createState() => _MgToastWidgetState();
}

class _MgToastWidgetState extends State<_MgToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  )..forward();

  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Tonos más oscuros que AppColors.success/warning/error — el texto e ícono
  // blanco necesita más contraste del que dan esos tonos claros por sí solos.
  (Color, IconData) get _style => switch (widget.type) {
        MgToastType.success => (const Color(0xFF15803D), Icons.check_circle),
        MgToastType.warning => (const Color(0xFFB45309), Icons.warning_amber_rounded),
        MgToastType.error => (const Color(0xFFDC2626), Icons.error),
      };

  @override
  Widget build(BuildContext context) {
    final (color, icon) = _style;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SlideTransition(
          position: _slide,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(14),
              color: color,
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  _controller.reverse().whenComplete(widget.onDismiss);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      Icon(icon, color: Colors.white, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
