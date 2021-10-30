import 'package:flutter/material.dart';

enum Flavor {
  web,
  develop,
  stagging,
  product,
}

class AppEnv {
  static Flavor? _flavor;
  static String? _apiBaseUrl;
  static String? _apiKey;

  static Flavor? get flavor => _flavor;
  static String? get apiBaseUrl => _apiBaseUrl;
  static String? get apiKey => _apiKey;
  static String get weatherApiBaseUrl => 'http://api.openweathermap.org';
  static String get weatherApiKey => '2f8796eefe67558dc205b09dd336d022';

  static configure({@required Flavor? flavor}) {
    _flavor = flavor;
    switch (_flavor) {
      case Flavor.web:
      case Flavor.develop:
        _apiBaseUrl = 'http://localhost:3000';
        _apiKey = '';
        break;
      case Flavor.stagging:
        _apiBaseUrl = 'http://192.168.0.2:3000';
        _apiKey = '';
        break;
      case Flavor.product:
        _apiBaseUrl =
            'https://my-json-server.typicode.com/hubpixie/drogo_libro';
        _apiKey = '';
        break;
      default:
        _apiBaseUrl = '';
        _apiKey = '';
        break;
    }
  }

  static String getString() {
    switch (_flavor) {
      case Flavor.web:
        return "WEB";
      case Flavor.develop:
        return "DEVELOP";
      case Flavor.stagging:
        return "STAGING";
      case Flavor.product:
        return "RELEASE";
      default:
        return "UNKNOWN";
    }
  }
}
