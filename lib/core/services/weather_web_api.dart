import 'dart:convert';
import "dart:io";
import 'package:meta/meta.dart';

import 'package:drogo_libro/config/app_env.dart';
import 'package:drogo_libro/core/services/base_api_client.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/enums/http_status.dart';
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
    print('fetching $url');
    final response = await BaseApiClient.client.get(url);
    if(response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
    } else if(response.body != null) {
      return DataResult<String>.success(response.statusCode, WeatherInfo.fromJson(json.decode(response.body)).cityName);
    } else {
      return DataResult<String>.success(response.statusCode, null);
    }
  }

  Future<DataResult> getWeatherData({@required String cityName}) async {
    final url = '$_endpoint/data/2.5/weather?q=$cityName&appid=$_apiKey';
    print('fetching $url');
    final response = await BaseApiClient.client.get(url);

    // Convert and return
    if(response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
    } else if(response.body != null) {
      return DataResult<WeatherInfo>.success(response.statusCode, WeatherInfo.fromJson(json.decode(response.body)));
    } else {
      return DataResult<WeatherInfo>.success(response.statusCode, null);
    }

  }

  Future<DataResult> getForecast({@required String cityName}) async {
    final url = '$_endpoint/data/2.5/forecast?q=$cityName&appid=$_apiKey';
    print('fetching $url');

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
