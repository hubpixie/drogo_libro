import 'package:flutter/material.dart';

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
  static String getPrecipLabel({double rain, double snow}) {
    String ret = '';
    if(rain != null) {
      ret = '降水';
    } else if (snow != null) {
      ret = '降雪';
    }
    return ret;
  }

  static String getPrecipValue({double rain, double snow}) {
    String ret = '';
    if(rain != null) {
      ret = '$rain mm';
    } else if (snow != null) {
      ret = '$snow cm';
    }
    return ret;
  }

  static String getWindDirectionValue({double degree}) {
    double deg = (double value) {
      if(value == null) return 0;
      return value + 22.5 >= 360 ? value + 22.5 - 360 : value;
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

  static IconData getIconData({String iconCode}){
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

}