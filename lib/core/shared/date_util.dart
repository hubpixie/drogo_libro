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
    return formatter.format(datetime); // DateからString
  }

  String getDateMDEStringWithTimestamp({int timestamp, int timezone}) {
    if(timestamp == null) return '';
    initializeDateFormatting("ja_JP");

    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(
                      (timestamp + timezone) * 1000, isUtc: true);

    var formatter = new DateFormat('M/d (E)', "ja_JP");
    return formatter.format(datetime); // DateからString
  }

  String getDateMDStringWithTimestamp({int timestamp, int timezone}) {
    if(timestamp == null) return '';
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(
                      (timestamp + timezone) * 1000, isUtc: true);

    var formatter = new DateFormat('M/d');
    return formatter.format(datetime); // DateからString
  }

  String getHMMString({int timestamp, int timezone}) {
    if(timestamp == null) return '';
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(
                      (timestamp + timezone) * 1000, isUtc: true);
    return DateFormat('H:mm').format(datetime);
  } 
}