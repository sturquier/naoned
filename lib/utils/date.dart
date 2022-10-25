import 'package:intl/intl.dart';

DateTime getCurrentDate() {
  return DateTime.now();
}

DateTime getFirstDayOfTheYear() {
  final DateTime now = getCurrentDate();

  return DateTime(now.year);
}

DateTime getLastDayOfTheYear() {
  final DateTime now = getCurrentDate();

  return DateTime(now.year, 12, 31);
}

String formatDate(DateTime date, String format) {
  final DateFormat formatter = DateFormat(format);

  return formatter.format(date);
}
