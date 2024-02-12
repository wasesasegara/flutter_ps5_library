import 'package:date_format/date_format.dart';

String oneYearRangeFormattedDate({DateTime? dateEnd}) {
  final List<String> dateFormat = [yyyy, '-', mm, '-', dd];
  final DateTime aDateEnd = dateEnd ?? DateTime.now();
  final String formattedDateEnd = formatDate(aDateEnd, dateFormat);
  final String formattedDateStart = formatDate(
    aDateEnd.subtract(const Duration(days: 365)),
    dateFormat,
  );
  return '$formattedDateStart,$formattedDateEnd';
}
