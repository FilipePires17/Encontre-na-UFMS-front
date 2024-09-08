import 'package:intl/intl.dart';

class AppConverter {
  static String? dateTimeFormatter(DateTime? time) {
    if (time == null) {
      return null;
    }
    return time == DateTime(1, 1, 1)
        ? null
        : DateFormat('dd/MM/yyyy - HH:mm').format(time);
  }

  static String dateFormatter(DateTime? time) {
    if (time == null) {
      return '';
    }
    return time == DateTime(1, 1, 1)
        ? ''
        : DateFormat('dd/MM/yyyy').format(time);
  }

  static String shortDateFormatter(DateTime? time) {
    if (time == null) {
      return '';
    }

    final shortForm =
        dateFormatter(time).substring(0, 6) + dateFormatter(time).substring(8);
    return time == DateTime(1, 1, 1) ? '' : shortForm;
  }

  static String timeFormatter(DateTime? time) {
    if (time == null) {
      return '';
    }
    return time == DateTime(1, 1, 1) ? '' : DateFormat('HH:mm').format(time);
  }
}
