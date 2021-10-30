import 'package:flutter/material.dart';
import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/shared/weather_util.dart';
import 'package:drogo_libro/core/shared/city_util.dart';
import 'package:drogo_libro/core/shared/date_util.dart';

class Temperature {
  final double _kelvin;

  // ignore: unnecessary_null_comparison
  Temperature(this._kelvin) : assert(_kelvin != null);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9 / 5) - 459.67;

  double as(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.kelvin:
        return this.kelvin;
      case TemperatureUnit.celsius:
        return this.celsius;
      case TemperatureUnit.fahrenheit:
        return this.fahrenheit;
    }
  }
}

class WeatherInfo {
  int? id;
  int? time;
  int? sunrise;
  int? sunset;
  int? humidity;
  double? rain; //mm
  double? snow; //cm

  String? description;
  String? iconCode;
  String? main;
  CityInfo? city;

  double? windSpeed;
  double? windDeg;

  Temperature? feelsLike;
  Temperature? temperature;
  Temperature? maxTemperature;
  Temperature? minTemperature;
  Temperature? maxTemperatureOfForecast;
  Temperature? minTemperatureOfForecast;

  List<WeatherInfo>? forecast;

  WeatherInfo(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.rain,
      this.snow,
      this.description,
      this.iconCode,
      this.main,
      this.city,
      this.windSpeed,
      this.windDeg,
      this.feelsLike,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.maxTemperatureOfForecast,
      this.minTemperatureOfForecast,
      this.forecast});

  WeatherInfo.fromJson(Map<String, dynamic> json, {String zip = ''}) {
    final weather = json['weather'].first;
    id = weather['id'];
    time = json['dt'];
    description = weather['description'];
    iconCode = weather['icon'];
    main = weather['main'];
    city = CityInfo(
      id: json['id'],
      name: json['name'],
      nameDesc: CityUtil().getCityNameDesc(name: json['name']),
      zip: zip,
      countryCode: json['sys']['country'],
      timezone: json['timezone'],
    );
    feelsLike = Temperature(_toDouble(json['main']['feels_like']) ?? 0);
    temperature = Temperature(_toDouble(json['main']['temp']) ?? 0);
    maxTemperature = Temperature(_toDouble(json['main']['temp_max']) ?? 0);
    minTemperature = Temperature(_toDouble(json['main']['temp_min']) ?? 0);
    sunrise = json['sys']['sunrise'];
    sunset = json['sys']['sunset'];
    humidity = json['main']['humidity'];
    rain = json['rain'] != null ? _toDouble(json['rain']['3h']) : null;
    snow = json['snow'] != null ? _toDouble(json['snow']['3h']) : null;
    windSpeed = json['wind'] != null ? _toDouble(json['wind']['speed']) : null;
    windDeg = _toDouble(json['wind']['deg']);
  }

  WeatherInfo.fromForecastJson(Map<String, dynamic> json) {
    forecast = () {
      final dsList = json['list'] as List?;
      return dsList != null
          ? dsList
              .map((element) => WeatherInfo(
                  time: element['dt'],
                  temperature: Temperature(
                    element['main']['temp'],
                  ),
                  iconCode: element['weather'][0]['icon']))
              .toList()
          : <WeatherInfo>[];
    }();
  }
}

extension WeatherInfoEx on WeatherInfo {
  double? _toDouble(dynamic value) {
    double? ret;
    if (value == null) return null;
    if (value is double) {
      ret = value;
    } else if (value is int) {
      int n = value;
      ret = n.toDouble();
    }
    return ret;
  }

  bool get hasPrecit => this.rain != null || this.snow != null;
  String getSunsetFormattedString() => DateUtil().getHMMString(
      timestamp: this.sunset ?? 0, timezone: this.city?.timezone ?? 0);
  String getSunriseFormattedString() => DateUtil().getHMMString(
      timestamp: this.sunrise ?? 0, timezone: this.city?.timezone ?? 0);
  String getTimeFormattedString() => DateUtil().getHMMString(
      timestamp: this.time ?? 0, timezone: this.city?.timezone ?? 0);
  String getDataFormattedString() => DateUtil().getDateMDEStringWithTimestamp(
      timestamp: this.time ?? 0, timezone: this.city?.timezone ?? 0);
  String getWeatherDesc() =>
      WeatherUtil().getWeatherDesc(weatherId: this.id ?? 0);
  String getPrecipLabel() =>
      WeatherUtil().getPrecipLabel(rain: this.rain ?? 0, snow: this.snow ?? 0);
  String getPrecipValue() =>
      WeatherUtil().getPrecipValue(rain: this.rain ?? 0, snow: this.snow ?? 0);
  String getWindDirectionValue() =>
      WeatherUtil().getWindDirectionValue(degree: this.windDeg ?? 0);
  IconData getIconData() =>
      WeatherUtil().getIconData(iconCode: this.iconCode ?? '');
}
