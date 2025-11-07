import 'package:intl/intl.dart';

class DateHelpers {
  DateHelpers._();

  static String formatDate(DateTime date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  static String formatDisplayDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static DateTime parseDate(String date) {
    return DateTime.parse(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
           date.month == yesterday.month &&
           date.day == yesterday.day;
  }

  static String getRelativeDate(DateTime date) {
    if (isToday(date)) return 'Today';
    if (isYesterday(date)) return 'Yesterday';
    return formatDisplayDate(date);
  }
}
