import 'package:flutter/material.dart';

Color getTypeColor(String? key) {
  // final colorFromAnsi = _getColorFromAnsi();
  // if (colorFromAnsi != null) return logsColors.colorFromAnsi;

  if (key == null) return Colors.grey;
  return typeColors[key] ?? Colors.grey;
}

const typeColors = {
  /// Base logs section
  "error": Color.fromARGB(255, 239, 83, 80),
  "critical": Color.fromARGB(255, 198, 40, 40),
  "info": Color.fromARGB(255, 66, 165, 245),
  "debug": Color.fromARGB(255, 158, 158, 158),
  "verbose": Color.fromARGB(255, 189, 189, 189),
  "warning": Color.fromARGB(255, 239, 108, 0),
  "exception": Color.fromARGB(255, 239, 83, 80),
  "good": Color.fromARGB(255, 120, 230, 129),

  /// Http section
  "http-error": Color.fromARGB(255, 239, 83, 80),
  "http-request": Color(0xFFF602C1),
  "http-response": Color(0xFF26FF3C),

  /// Bloc section
  "bloc-event": Color(0xFF63FAFE),
  "bloc-transition": Color(0xFF56FEA8),
  "bloc-close": Color(0xFFFF005F),
  "bloc-create": Color.fromARGB(255, 120, 230, 129),

  /// Flutter section
  "route": Color(0xFFAF5FFF),
};
