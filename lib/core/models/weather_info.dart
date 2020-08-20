import 'package:flutter/material.dart';
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
  String cityName;

  double windSpeed;
  double windDeg;

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
      this.cityName,
      this.windSpeed,
      this.windDeg,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.forecast});

  WeatherInfo.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'].first;

    id = weather['id'];
    time = json['dt'];
    description = weather['description'];
    iconCode = weather['icon'];
    main = weather['main'];
    cityName = json['name'];
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
  String getPrecipLabel() => WeatherUtil.getPrecipLabel(rain: this.rain, snow: this.snow);
  String getPrecipValue() => WeatherUtil.getPrecipValue(rain: this.rain, snow: this.snow);
  String getWindDirectionValue() => WeatherUtil.getWindDirectionValue(degree: this.windDeg);
  IconData getIconData() => WeatherUtil.getIconData(iconCode: this.iconCode);
}