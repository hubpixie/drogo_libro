import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
class DateUtil {
  static String getDateMDEString({DateTime date}) {
    initializeDateFormatting("ja_JP");

    DateTime datetime = date == null ? DateTime.now() : date;

    var formatter = new DateFormat('M/d (E)', "ja_JP");
    var formatted = formatter.format(datetime); // DateからString
    return formatted;
  }
}