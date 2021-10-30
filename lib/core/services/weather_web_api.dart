import 'dart:convert';
import 'package:flutter/foundation.dart';

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
      {double latitude = 0, double longitude = 0}) async {
    final url =
        '$_endpoint/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$_apiKey';
    print('getCityNameFromLocation $url');

    try {
      final response = await BaseApiClient.client.get(url);
      if (response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if (response.body != null) {
        return DataResult<CityInfo>.success(response.statusCode,
            WeatherInfo.fromJson(json.decode(response.body)).city);
      } else {
        return DataResult<CityInfo>.success(response.statusCode, null);
      }
    } catch (error) {
      return DataResult<CityInfo>.error(HttpStatus.otherError, error);
    }
  }

  Future<DataResult> getWeatherData({@required CityInfo? cityParam}) async {
    final url = cityParam?.zip != null
        ? '$_endpoint/data/2.5/weather?zip=${cityParam?.zip},${cityParam?.countryCode}&appid=$_apiKey'
        : '$_endpoint/data/2.5/weather?q=${cityParam?.name},${cityParam?.countryCode}&appid=$_apiKey';
    print('getWeatherData $url');

    try {
      final response = await BaseApiClient.client.get(url);

      // Convert and return
      if (response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if (response.body != null) {
        return DataResult<WeatherInfo>.success(
            response.statusCode,
            WeatherInfo.fromJson(json.decode(response.body),
                zip: cityParam?.zip ?? ''));
      } else {
        return DataResult<WeatherInfo>.success(response.statusCode, null);
      }
    } catch (error) {
      return DataResult<WeatherInfo>.error(HttpStatus.otherError, error);
    }
  }

  Future<DataResult> getForecast({@required CityInfo? cityParam}) async {
    final url = cityParam?.zip != null
        ? '$_endpoint/data/2.5/forecast?zip=${cityParam?.zip},${cityParam?.countryCode}&appid=$_apiKey'
        : '$_endpoint/data/2.5/forecast?q=${cityParam?.name},${cityParam?.countryCode}&appid=$_apiKey';
    print('getForecast $url');

    try {
      final response = await BaseApiClient.client.get(url);
      // set result to return
      //
      if (response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if (response.body != null) {
        var parsed = json.decode(response.body)['list'] as List<dynamic>;
        var ret =
            parsed.map((element) => WeatherInfo.fromJson(element)).toList();
        return DataResult<List<WeatherInfo>>.success(response.statusCode, ret);
      } else {
        return DataResult<List<WeatherInfo>>.success(response.statusCode, null);
      }
    } catch (error) {
      return DataResult<List<WeatherInfo>>.error(HttpStatus.otherError, error);
    }
  }
}
