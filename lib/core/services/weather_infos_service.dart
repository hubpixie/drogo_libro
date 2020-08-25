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

  /// Get cityName
  /// 
  Future getCityNameFromLocation(
      {double latitude, double longitude}) async {
    _fetchedCityNameFromLocation = await _api.getCityNameFromLocation(latitude: latitude, longitude: longitude);
  }

  /// Get weather info 
  /// 
  Future getWeatherData({String cityNameCd, String zipCd}) async {
    _fetchedWeatherInfo = await _api.getWeatherData(cityNameCd: cityNameCd, zipCd: zipCd);
  }

  /// Get weather forecast
  /// 
  Future getForecast({String cityNameCd, String zipCd}) async {
    _fetchedForecast = await _api.getForecast(cityNameCd: cityNameCd, zipCd: zipCd);
  }

} 
