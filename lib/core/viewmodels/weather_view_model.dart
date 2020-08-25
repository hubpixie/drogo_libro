import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';

import 'package:drogo_libro/core/models/data_result.dart';
// import 'package:drogo_libro/core/models/weather_info.dart';
import 'package:drogo_libro/core/services/weather_infos_service.dart';

import 'base_view_model.dart';

class WeatherViewModel extends BaseViewModel {
  WeatherInfosService _weatherService = ServiceSetting.locator<WeatherInfosService>();
  
  DataResult get fetchedCityNameFromLocation => _weatherService.fetchedCityNameFromLocation;
  DataResult get fetchedWeatherInfo => _weatherService.fetchedWeatherInfo;
  DataResult get fetchedForecast => _weatherService.fetchedForecast;

  /// Get city name
  ///  
  Future getCityNameFromLocationuserId({double latitude, double longitude}) async {
    setState(ViewState.Busy);
    await _weatherService.getCityNameFromLocation(latitude: latitude, longitude: longitude);
    setState(ViewState.Idle);
  }

  /// Get weather info 
  /// 
  Future getWeatherData({String cityNameCd, String zipCd}) async {

    setState(ViewState.Busy);
    await _weatherService.getWeatherData(cityNameCd: cityNameCd, zipCd: zipCd);
    setState(ViewState.Idle);
  }

  /// Get weather forecast 
  /// 
  Future getForecast({String cityNameCd, String zipCd}) async {

    setState(ViewState.Busy);
    await _weatherService.getForecast(cityNameCd: cityNameCd, zipCd: zipCd);
    setState(ViewState.Idle);
  }

}