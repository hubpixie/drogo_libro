import 'package:flutter/material.dart';

import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/shared/weather_util.dart';

enum TemperatureUnit {
  kelvin,
  celsius,
  fahrenheit
}

class Temperature{
  final double _kelvin;

  Temperature(this._kelvin) : assert(_kelvin != null);

  double get kelvin => _kelvin;

  double get celsius => _kelvin - 273.15;

  double get fahrenheit => _kelvin * (9/5) - 459.67;

  double as(TemperatureUnit unit) {
    switch(unit){
      case TemperatureUnit.kelvin:
        return this.kelvin;
        break;
      case TemperatureUnit.celsius:
        return this.celsius;
        break;
      case TemperatureUnit.fahrenheit:
        return this.fahrenheit;
        break;
    }
    return this.fahrenheit;
  }
}

class WeatherInfo {
  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;
  double rain; //mm
  double snow; //cm

  String description;
  String iconCode;
  String main;
  CityInfo city;

  double windSpeed;
  int windDeg;

  Temperature temperature;
  Temperature maxTemperature;
  Temperature minTemperature;

  List<WeatherInfo> forecast;

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
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast});

  WeatherInfo.fromJson(Map<String, dynamic> json, {String zipCd}) {
    final weather = json['weather'].first;
    id = weather['id'];
    time = json['dt'];
    description = weather['description'];
    iconCode = weather['icon'];
    main = weather['main'];
    city = CityInfo(
      id: json['id'], 
      name: json['name'], 
      nameDesc: () {
        CityInfo cinfo;
        try {
          String name = json['name'];
          cinfo =  WeatherUtil.shared.romajiCityList.firstWhere((element) => element.name == name);
        } catch(error) {
        }
        return cinfo != null ? cinfo.nameDesc.replaceAll(RegExp(r'都|府|市'), '') : json['name'];
      }(),
      zip: zipCd != null && zipCd.isNotEmpty ? zipCd.split(',').first : '',
      countryCode: json['sys']['country'],
    );
    temperature = Temperature(json['main']['temp']);
    maxTemperature = Temperature(json['main']['temp_max']);
    minTemperature = Temperature(json['main']['temp_min']);
    sunrise = json['sys']['sunrise'];
    sunset = json['sys']['sunset'];
    humidity = json['main']['humidity'];
    rain = json['rain'] != null ? json['rain']['3h'] : null;
    snow = json['snow'] != null ? json['snow']['3h'] : null;
    windSpeed = json['wind']['speed'];
    windDeg = json['wind']['deg'];
  }

  WeatherInfo.fromForecastJson(Map<String, dynamic> json) {
    forecast = () {
      final dsList = json['list'] as List;
      return dsList != null ? dsList.map((element) => 
      WeatherInfo(time: element['dt'], 
        temperature: Temperature(
          element['main']['temp'],
        ),
        iconCode: element['weather'][0]['icon']
        )
      ).toList() : <WeatherInfo>[];
    }();
  }
}

extension WeatherInfoEx on WeatherInfo {
  bool get hasPrecit => this.rain != null || this.snow != null;
  String getWeatherDesc() => WeatherUtil.shared.getWeatherDesc(weatherId: this.id);
  String getPrecipLabel() => WeatherUtil.shared.getPrecipLabel(rain: this.rain, snow: this.snow);
  String getPrecipValue() => WeatherUtil.shared.getPrecipValue(rain: this.rain, snow: this.snow);
  String getWindDirectionValue() => WeatherUtil.shared.getWindDirectionValue(degree: this.windDeg);
  IconData getIconData() => WeatherUtil.shared.getIconData(iconCode: this.iconCode);
}