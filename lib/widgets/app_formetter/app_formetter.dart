import 'package:intl/intl.dart';

// ignore: non_constant_identifier_names
String formatTo_ddMMyyyy(dynamic input) {
  if (input == null) return '';

  DateTime dateTime;

  if (input is DateTime) {
    dateTime = input;
  } else if (input is int) {
    // assume millisecondsSinceEpoch
    dateTime = DateTime.fromMillisecondsSinceEpoch(input);
  } else if (input is String) {
    // try parse ISO or epoch string
    // first try DateTime.parse (ISO8601)
    try {
      dateTime = DateTime.parse(input);
    } catch (_) {
      // then try parsing int string (epoch millis)
      final millis = int.tryParse(input);
      if (millis != null) {
        dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
      } else {
        // fallback: try common formats manually (you can extend)
        return '';
      }
    }
  } else {
    return '';
  }

  final formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(dateTime);
}
