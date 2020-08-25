import 'dart:convert';
import "dart:io";

import 'package:drogo_libro/config/app_env.dart';
import 'package:drogo_libro/core/services/base_api_client.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/enums/http_status.dart';
import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/models/weather_info.dart';

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class WeatherWebApi {
  static final String _endpoint = AppEnv.weatherApiBaseUrl;
  static final String _apiKey = AppEnv.weatherApiKey;


  Future<DataResult> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url =
        '$_endpoint/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$_apiKey';
    print('getCityNameFromLocation $url');

    try {
      final response = await BaseApiClient.client.get(url);
      if(response.statusCode >= HttpStatus.badRequest) {
          return DataResult.error(response.statusCode, response.body);
      } else if(response.body != null) {
        return DataResult<CityInfo>.success(response.statusCode, WeatherInfo.fromJson(json.decode(response.body)).city);
      } else {
        return DataResult<CityInfo>.success(response.statusCode, null);
      }
    } catch(error) {
      return DataResult<CityInfo>.error(HttpStatus.otherError, error);
    }
  }

  Future<DataResult> getWeatherData({String cityNameCd, String zipCd}) async {
    final url = cityNameCd != null && cityNameCd.isNotEmpty ?
     '$_endpoint/data/2.5/weather?q=$cityNameCd&appid=$_apiKey' :
     '$_endpoint/data/2.5/weather?zip=$zipCd&appid=$_apiKey'
     ;
    print('getWeatherData $url');

    try {
      final response = await BaseApiClient.client.get(url);

      // Convert and return
      if(response.statusCode >= HttpStatus.badRequest) {
          return DataResult.error(response.statusCode, response.body);
      } else if(response.body != null) {
        return DataResult<WeatherInfo>.success(response.statusCode, WeatherInfo.fromJson(json.decode(response.body), zipCd: zipCd));
      } else {
        return DataResult<WeatherInfo>.success(response.statusCode, null);
      }
    } catch(error) {
      return DataResult<WeatherInfo>.error(HttpStatus.otherError, error);
    }

  }

  Future<DataResult> getForecast({String cityNameCd, String zipCd}) async {
    final url = cityNameCd != null && cityNameCd.isNotEmpty ?
     '$_endpoint/data/2.5/weather?q=$cityNameCd&appid=$_apiKey' :
     '$_endpoint/data/2.5/weather?zip=$cityNameCd&appid=$_apiKey'
     ;

      try {
        final response = await BaseApiClient.client.get(url);
        // set result to return
        //
        if(response.statusCode >= HttpStatus.badRequest) {
          return DataResult.error(response.statusCode, response.body);
        } else if(response.body != null) {
          var parsed = json.decode(response.body) as List<dynamic>;
          var ret = parsed.map((element) => WeatherInfo.fromJson(element)).toList();
          return DataResult<List<WeatherInfo>>.success(response.statusCode, ret);
        } else {
          return DataResult<List<WeatherInfo>>.success(response.statusCode, null);
        }
      } catch(error) {
          return DataResult<List<WeatherInfo>>.error(HttpStatus.otherError, error);
      }

  }
}
