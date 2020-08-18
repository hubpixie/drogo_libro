import 'package:flutter/material.dart';

enum Flavor {
  web,
  develop,
  stagging,
  product,
}

class AppEnv {
  static Flavor _flavor;
  static String _apiBaseUrl;
  static String _apiKey;

  static Flavor get flavor => _flavor;
  static String get apiBaseUrl => _apiBaseUrl;
  static String get apiKey => _apiKey;
  
  static configure({@required Flavor flavor}) {
    _flavor = flavor;
    switch(_flavor) {
      case Flavor.web:
      case Flavor.develop:
        _apiBaseUrl = 'http://localhost:3000';
        _apiKey = '';
        break;
      case Flavor.stagging:
        _apiBaseUrl = 'http://localhost:3000';
        _apiKey = '';
        break;
      case Flavor.product:
        _apiBaseUrl = 'https://my-json-server.typicode.com/hubpixie/drogo_libro';
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
