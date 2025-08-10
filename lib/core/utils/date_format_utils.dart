import 'package:intl/intl.dart';

class DateFormatUtils {
  DateFormatUtils._();

  // Human-friendly date like "September 12, 2024"
  static String humanReadable(DateTime dateTime) {
    return DateFormat.yMMMMd().format(dateTime);
  }

  // Compact ISO-like date: "2024-09-12"
  static String isoCompact(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
