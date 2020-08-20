import 'package:flutter/material.dart';

import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';

import 'weather_web_api.dart';

class WeatherInfosService {
  WeatherWebApi _api = ServiceSetting.locator<WeatherWebApi>();
  
  DataResult _fetchedCityNameFromLocation;
  DataResult _fetchedWeatherInfo;
  DataResult _fetchedForecast;
  DataResult get fetchedCityNameFromLocation => _fetchedCityNameFromLocation;
  DataResult get fetchedWeatherInfo => _fetchedWeatherInfo;
  DataResult get fetchedForecast => _fetchedForecast;

  /// Get Cityname
  /// 
  Future getCityNameFromLocation(
      {double latitude, double longitude}) async {
    _fetchedCityNameFromLocation = await _api.getCityNameFromLocation(latitude: latitude, longitude: longitude);
  }

  /// Get weather info 
  /// 
  Future getWeatherData({@required String cityName}) async {
    _fetchedWeatherInfo = await _api.getWeatherData(cityName: cityName);
  }

  /// Get weather forecast
  /// 
  Future getForecast({@required String cityName}) async {
    _fetchedForecast = await _api.getForecast(cityName: cityName);
  }

} 
