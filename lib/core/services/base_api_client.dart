import "dart:io";
import 'package:flutter/foundation.dart';

import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;


/// The service responsible for networking requests
class BaseApiClient {
  static const _commonHeaders = {'Accept': 'application/json', 
    'Content-type': 'application/json'};
  static dynamic _httpClient;
  static dynamic _client;

  static get commonHeaders => _commonHeaders;
  static get client => _client;

  BaseApiClient() {
    if (kIsWeb) {
      if (_httpClient == null) {
        _httpClient = new http.Client();
      }
      _client = _httpClient;
    } else {
      if (_httpClient == null) {
        _httpClient = new HttpClient()
          ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      } 
      _client = new IOClient(_httpClient);
    }
  }
}