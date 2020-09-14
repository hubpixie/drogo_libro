import 'package:flutter/foundation.dart';

import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';

import 'package:drogo_libro/core/services/weather_infos_service.dart';
import 'package:drogo_libro/core/shared/date_util.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/shared/city_util.dart';
import 'package:drogo_libro/core/models/weather_info.dart';

import 'base_view_model.dart';

class WeatherViewModel extends BaseViewModel {
  WeatherInfosService _weatherService = ServiceSetting.locator<WeatherInfosService>();
  List<WeatherInfo>  _hourlyForecastData;
  List<WeatherInfo>  _weeklyForecastData;

  DataResult get fetchedCityNameFromLocation => _weatherService.fetchedCityNameFromLocation;
  DataResult get fetchedWeatherInfo => _weatherService.fetchedWeatherInfo;
  DataResult get fetchedForecast => _weatherService.fetchedForecast;

  List<WeatherInfo> get hourlyForecastData => _hourlyForecastData;
  List<WeatherInfo> get weeklyForecastData => _weeklyForecastData;

  List<WeatherInfo> _makeHourlyForecastData() {
    WeatherInfo todayWeather = _weatherService.fetchedWeatherInfo.result;
    if(_weatherService.fetchedForecast != null )  {
       List<WeatherInfo> data = _weatherService.fetchedForecast.result;
       if(data != null && data.length >= 8) {
         List<WeatherInfo> ret = data.take(9).toList();
         for(int idx = 0; idx < ret.length ; idx++) {
           ret[idx].city = todayWeather.city;
         }
         return ret;
       } else {
         return <WeatherInfo> [];
       }
      }else {
       return <WeatherInfo> [];
     }
  }

List<WeatherInfo> _makeWeeklyForecastData() {
    WeatherInfo todayWeather = _weatherService.fetchedWeatherInfo.result;

    if(_weatherService.fetchedForecast != null )  {
      List<WeatherInfo> data = _weatherService.fetchedForecast.result;
      List<WeatherInfo> ret = <WeatherInfo>[];
      double maxTempForecast;
      double minTempForecast;

      if(data != null && data.length > 0) {
        List<String> addedKeys = [];
        String lastDateKey = DateUtil().getDateMDStringWithTimestamp(timestamp: data.last.time, timezone: todayWeather.city.timezone);
        // 表示日数分の日付キーを作成しておく
        for(int i = 1; ; i ++) {
          String dateKey = DateUtil().getDateMDStringWithTimestamp(timestamp: todayWeather.time + i * 24 * 3600, timezone: todayWeather.city.timezone);
          if(dateKey.compareTo(lastDateKey) > 0) break;
          addedKeys.add(dateKey);
        }

        // 日毎の気温データを取得
        for(int i = 0; i < addedKeys.length; i ++) {
          final subData = data.where((element) {
            String dateKey = DateUtil().getDateMDStringWithTimestamp(timestamp: element.time, timezone: todayWeather.city.timezone);
            return dateKey == addedKeys[i];
          });
          //　最高気温、最低気温
          maxTempForecast = subData.map((e) => e.maxTemperature.kelvin).reduce((curr, next) => curr > next? curr: next);
          minTempForecast = subData.map((e) => e.minTemperature.kelvin).reduce((curr, next) => curr < next? curr: next);
          ret.add(subData.first);
          ret[ret.length - 1].maxTemperatureOfForecast = Temperature(maxTempForecast);
          ret[ret.length - 1].minTemperatureOfForecast = Temperature(minTempForecast);
          // City Info
          ret[ret.length - 1].city = todayWeather.city;
        }
        return ret;
      } else {
        return <WeatherInfo> [];
      }
    }else {
      return <WeatherInfo> [];
    }
  }

  /// Get city name
  ///  
  Future getCityNameFromLocationuserId({double latitude, double longitude}) async {
    setState(ViewState.Busy);
    await _weatherService.getCityNameFromLocation(latitude: latitude, longitude: longitude);
    setState(ViewState.Idle);
  }

  /// Get weather info 
  /// 
  Future getWeatherData({@required CityInfo cityParam, bool forecastEnabled = false}) async {

    setState(ViewState.Busy);
    await _weatherService.getWeatherData(cityParam: cityParam);
    WeatherInfo todayWeather = _weatherService.fetchedWeatherInfo.result;
    if(_weatherService.fetchedWeatherInfo.hasData) {
      CityInfo cityValue = CityInfo(
        zip: cityParam.zip,
        name: todayWeather.city.name,
        nameDesc: todayWeather.city.nameDesc,
        isFavorite: cityParam.isFavorite,
        countryCode: cityParam.countryCode,
      );
      await CityUtil().saveCityInfoIntoPref(cityValue: cityValue);
    }
    // 予報データ取得
    if(forecastEnabled) {
      await _weatherService.getForecast(cityParam: cityParam);
      // 当日の予報データ編集
      _hourlyForecastData = _makeHourlyForecastData();
      // 当日の予報データ編集
      _weeklyForecastData = _makeWeeklyForecastData();
    }
  
    setState(ViewState.Idle);
  }

  /// Get weather forecast 
  /// 
  Future getForecast({@required CityInfo cityParam}) async {

    setState(ViewState.Busy);
    await _weatherService.getForecast(cityParam: cityParam);
    setState(ViewState.Idle);
  }

}

