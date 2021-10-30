import 'package:flutter/foundation.dart';

import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/city_info.dart';

import 'weather_web_api.dart';

class WeatherInfosService {
  WeatherWebApi _api = ServiceSetting.locator<WeatherWebApi>();

  late DataResult _fetchedCityNameFromLocation;
  late DataResult _fetchedWeatherInfo;
  late DataResult _fetchedForecast;
  DataResult get fetchedCityNameFromLocation => _fetchedCityNameFromLocation;
  DataResult get fetchedWeatherInfo => _fetchedWeatherInfo;
  DataResult get fetchedForecast => _fetchedForecast;

  /// Get cityName
  ///
  Future getCityNameFromLocation(
      {double latitude = 0, double longitude = 0}) async {
    _fetchedCityNameFromLocation = await _api.getCityNameFromLocation(
        latitude: latitude, longitude: longitude);
  }

  /// Get weather info
  ///
  Future getWeatherData({@required CityInfo? cityParam}) async {
    if (cityParam != null) {
      _fetchedWeatherInfo = await _api.getWeatherData(cityParam: cityParam);
    }
  }

  /// Get weather forecast
  ///
  Future getForecast({@required CityInfo? cityParam}) async {
    if (cityParam != null) {
      _fetchedForecast = await _api.getForecast(cityParam: cityParam);
    }
  }
}
