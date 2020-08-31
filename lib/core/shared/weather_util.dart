import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:drogo_libro/core/models/city_info.dart';

/// Exposes specific weather icons
/// https://openweathermap.org/weather-conditions
// hex values and ttf file from https://erikflowers.github.io/weather-icons/
class WeatherIcons {
  static const IconData clear_day = const _IconData(0xf00d);
  static const IconData clear_night = const _IconData(0xf02e);

  static const IconData few_clouds_day = const _IconData(0xf002);
  static const IconData few_clouds_night = const _IconData(0xf081);

  static const IconData clouds_day = const _IconData(0xf07d);
  static const IconData clouds_night = const _IconData(0xf080);

  static const IconData shower_rain_day = const _IconData(0xf009);
  static const IconData shower_rain_night = const _IconData(0xf029);

  static const IconData rain_day = const _IconData(0xf008);
  static const IconData rain_night = const _IconData(0xf028);

  static const IconData thunder_storm_day = const _IconData(0xf010);
  static const IconData thunder_storm_night = const _IconData(0xf03b);

  static const IconData snow_day = const _IconData(0xf00a);
  static const IconData snow_night = const _IconData(0xf02a);

  static const IconData mist_day = const _IconData(0xf003);
  static const IconData mist_night = const _IconData(0xf04a);
}

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}

enum _WindDirection {
  N,
  NE,
  E,
  SE,
  S,
  SW,
  W,
  NW
}

class WeatherUtil {
  static final WeatherUtil _instance = WeatherUtil._internal();
  factory WeatherUtil() {
    return _instance;
  }
  WeatherUtil._internal();

  List<CityInfo> _romajiCityList;
  List<CityInfo> get romajiCityList => _romajiCityList;

  String getPrecipLabel({double rain, double snow}) {
    String ret = '';
    if(rain != null) {
      ret = '降水';
    } else if (snow != null) {
      ret = '降雪';
    }
    return ret;
  }

  String getPrecipValue({double rain, double snow}) {
    String ret = '';
    if(rain != null) {
      ret = '$rain mm';
    } else if (snow != null) {
      ret = '$snow cm';
    }
    return ret;
  }

  String getWindDirectionValue({dynamic degree}) {
    double deg = (dynamic value) {
      if(value == null) return 0;
      return value + 22.5 >= 360 ? value + 22.5 - 360 : value + 22.5;
    }(degree);
    int directNum = (deg / 45).floor();
    _WindDirection direct = _WindDirection.values[directNum];
    switch (direct) {
      case _WindDirection.N:
        return '北';
      case _WindDirection.NE:
        return '北東';
      case _WindDirection.E:
        return '東';
      case _WindDirection.SE:
        return '南東';
      case _WindDirection.S:
        return '南';
      case _WindDirection.SW:
        return '南西';
      case _WindDirection.W:
        return '西';
      case _WindDirection.NW:
        return '北西';
      default:
        return '';
    }
  }

  String getWeatherDesc({int weatherId}) {
    switch(weatherId) {
      case 200: return '小雨と雷雨';
      case 201: return '雨と雷雨';
      case 202: return '大雨と雷雨';
      case 210: return '光雷雨';
      case 211: return '雷雨';
      case 212: return '重い雷雨';
      case 221: return 'ぼろぼろの雷雨';
      case 230: return '小雨と雷雨';
      case 231: return '霧雨と雷雨';
      case 232: return '重い霧雨と雷雨';
      case 300: return '光強度霧雨';
      case 301: return '霧雨';
      case 302: return '重い強度霧雨';
      case 310: return '光強度霧雨の雨';
      case 311: return '霧雨の雨';
      case 312: return '重い強度霧雨の雨';
      case 313: return 'にわかの雨と霧雨';
      case 314: return '重いにわかの雨と霧雨';
      case 321: return 'にわか霧雨';
      case 500: return '小雨';
      case 501: return '適度な雨';
      case 502: return '重い強度の雨';
      case 503: return '非常に激しい雨';
      case 504: return '極端な雨';
      case 511: return '雨氷';
      case 520: return '光強度のにわかの雨';
      case 521: return 'にわかの雨';
      case 522: return '重い強度にわかの雨';
      case 531: return '不規則なにわかの雨';
      case 600: return '小雪';
      case 601: return '雪';
      case 602: return '大雪';
      case 611: return 'みぞれ';
      case 612: return 'にわかみぞれ';
      case 615: return '光雨と雪';
      case 616: return '雨や雪';
      case 620: return '光のにわか雪';
      case 621: return 'にわか雪';
      case 622: return '重いにわか雪';
      case 701: return 'ミスト';
      case 711: return '煙';
      case 721: return 'ヘイズ';
      case 731: return '砂、ほこり旋回する';
      case 741: return '霧';
      case 751: return '砂';
      case 761: return 'ほこり';
      case 762: return '火山灰';
      case 771: return 'スコール';
      case 781: return '竜巻';
      case 800: return '晴れ';
      case 801: return '薄い雲';
      case 802: return '曇り';
      case 803: return '曇りがち';
      case 804: return '厚い雲'; 
      default: return ''; 
    }
  }

  IconData getIconData({String iconCode}){
    switch(iconCode){
      case '01d': return WeatherIcons.clear_day;
      case '01n': return WeatherIcons.clear_night;
      case '02d': return WeatherIcons.few_clouds_day;
      case '02n': return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d': return WeatherIcons.shower_rain_day;
      case '09n': return WeatherIcons.shower_rain_night;
      case '10d': return WeatherIcons.rain_day;
      case '10n': return WeatherIcons.rain_night;
      case '11d': return WeatherIcons.thunder_storm_day;
      case '11n': return WeatherIcons.thunder_storm_night;
      case '13d': return WeatherIcons.snow_day;
      case '13n': return WeatherIcons.snow_night;
      case '50d': return WeatherIcons.mist_day;
      case '50n': return WeatherIcons.mist_night;
      default: return WeatherIcons.clear_day;
    }
  }

  void loadRomajiCityCsv() async {
    final myData = await rootBundle.loadString('assets/csv/romaji-chimei-all-u.csv');
    List<List<dynamic>> list = CsvToListConverter().convert(myData, fieldDelimiter: ',', eol: '\n');
      _romajiCityList = list.map((element) => CityInfo(
        name: element[3],
        nameDesc: element[0],
      )).toList();
  }
}