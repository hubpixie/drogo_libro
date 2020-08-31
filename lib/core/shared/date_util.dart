import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
class DateUtil {
  static final DateUtil _instance = DateUtil._internal();
  factory DateUtil() {
    return _instance;
  }
  DateUtil._internal();

  String getDateMDEString({DateTime date}) {
    initializeDateFormatting("ja_JP");

    DateTime datetime = date == null ? DateTime.now() : date;

    var formatter = new DateFormat('M/d (E)', "ja_JP");
    var formatted = formatter.format(datetime); // DateからString
    return formatted;
  }

  String getHMMString({int timestamp, int timezone}) {
    DateTime dt = DateTime.fromMillisecondsSinceEpoch(
                      (timestamp + timezone) * 1000, isUtc: true);
    return DateFormat('H:mm').format(dt);
  } 
}