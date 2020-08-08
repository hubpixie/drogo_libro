import 'dart:convert';
import "dart:io";
import 'package:flutter/foundation.dart';

import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

import 'package:drogo_libro/core/models/comment.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/post.dart';

import 'package:drogo_libro/core/enums/http_status.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';

/// The service responsible for networking requests
class WebApi {
  // static const _endpoint = 'https://jsonplaceholder.typicode.com';
  // static const _endpoint = 'http://macbook-air.local:3000';
  static const _endpoint = 'http://192.168.0.9:3000';
  static const _commonHeaders = {'Accept': 'application/json', 
    'Content-type': 'application/json'};
  
  static dynamic _httpClient;
  dynamic client;

  WebApi() {
    if (kIsWeb) {
      if (_httpClient == null) {
        _httpClient = new http.Client();
      }
      client = _httpClient;
    } else {
      if (_httpClient == null) {
        _httpClient = new HttpClient()
          ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      } 
      client = new IOClient(_httpClient);
    }
  }

  Future<DataResult> getUserProfile(int userId) async {
    // Get user profile for id
    var response = await client.get('$_endpoint/users/$userId');

    // Convert and return
    if(response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
    } else if(response.body != null) {
      return DataResult<User>.success(response.statusCode, User.fromJson(json.decode(response.body)));
    } else {
      return DataResult<User>.success(response.statusCode, null);
    }
  }

  Future<DataResult> getPostsForUser(int userId) async {
    // Get user posts for id
    var response = await client.get('$_endpoint/posts?userId=$userId');

      // set result to return
      //
      if(response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if(response.body != null) {
        var parsed = json.decode(response.body) as List<dynamic>;
        return DataResult<List<Post>>.success(response.statusCode, 
        parsed.map((element) => Post.fromJson(element)).toList());
      } else {
        return DataResult<List<Post>>.success(response.statusCode, null);
      }
  }

  Future<DataResult> getDrogoInfosForUser(int userId,
    {DrogoSearchParam param}) async {
      // Get user posts for id
      var url = ('$_endpoint/drogo_infos?userId=$userId');
      if(param != null) {
        if (param.dispeningDate != null) {
          url += '&dispening_date=${param.dispeningDate}';
        } else if(param.drogoName != null ) {
          url += '&drogo_name=${param.drogoName}';
        } else if(param.usage != null ) {
          url += '&usage=${param.usage}';
        } else if(param.times != null ) {
          url += '&times=${param.times}';
        } else if(param.medicalInstituteName != null ) {
          url += '&medical_institute_name_like=${param.medicalInstituteName}';
        } else if(param.doctorName != null ) {
          url += '&doctor_name_like=${param.doctorName}';
        }
      }
      var response = await client.get(url);

      // set result to return
      //
      if(response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if(response.body != null) {
        var parsed = json.decode(response.body) as List<dynamic>;
        return DataResult<List<DrogoInfo>>.success(response.statusCode, 
        parsed.map((element) => DrogoInfo.fromJson(element)).toList());
      } else {
        return DataResult<List<DrogoInfo>>.success(response.statusCode, null);
      }
  }
  
  /// Get Foryou info (http/get)
  /// 
  Future<DataResult> getForyouInfoForUser(int userId) async {
      // Get user posts for id
      var url = ('$_endpoint/foryou_infos?userId=$userId');

      try {
        var response = await client.get(url);
        // set result to return
        //
        if(response.statusCode >= HttpStatus.badRequest) {
          return DataResult.error(response.statusCode, response.body);
        } else if(response.body != null) {
          var parsed = json.decode(response.body) as List<dynamic>;
          var ret = parsed.map((element) => ForyouInfo.fromJson(element)).toList();
          return DataResult<ForyouInfo>.success(response.statusCode, ret.isNotEmpty ? ret.first : null);
        } else {
          return DataResult<ForyouInfo>.success(response.statusCode, null);
        }
      } catch(error) {
          return DataResult<ForyouInfo>.error(HttpStatus.otherError, error);
      }

  }

  /// Create Foryou info (http/post)
  /// 
  Future<DataResult> createForyouInfo(ForyouInfo body) async {
    // Get user posts for id
    var url = ('$_endpoint/foryou_infos');

    var response = await client.post(url, headers: _commonHeaders, body: jsonEncode(body.toJson()));

    // set result to return
    //
    if(response.statusCode >= HttpStatus.badRequest) {
      return DataResult.error(response.statusCode, response.body);
    } else if(response.body != null) {
      var parsed = json.decode(response.body) as List<dynamic>;
      var ret = parsed.map((element) => ForyouInfo.fromJson(element)).toList();
      return DataResult<ForyouInfo>.success(response.statusCode, ret.isNotEmpty ? ret.first : null);
    } else {
      return DataResult<ForyouInfo>.success(response.statusCode, null);
    }
  }

  /// Update Foryou info (http/put)
  /// 
   Future<DataResult> updateForyouInfo(ForyouInfo body) async {
    // Get user posts for id
    var url = ('$_endpoint/foryou_infos/${body.id}');

    var response = await client.put(url, headers: _commonHeaders, body: jsonEncode(body.toJson()));

    // set result to return
    //
    if(response.statusCode >= HttpStatus.badRequest) {
     return DataResult.error(response.statusCode, response.body);
    } else if(response.body != null) {
      return DataResult<ForyouInfo>.success(response.statusCode, ForyouInfo.fromJson(json.decode(response.body)));
    } else {
      return DataResult<ForyouInfo>.success(response.statusCode, null);
    }
  }

  Future<DataResult> getCommentsForPost(int postId) async {
    // Get comments for post
    var response = await client.get('$_endpoint/comments?postId=$postId');

      // set result to return
      //
      if(response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if(response.body != null) {
        var parsed = json.decode(response.body) as List<dynamic>;
        var ret = parsed.map((element) => Comment.fromJson(element)).toList();
        return DataResult<Comment>.success(response.statusCode, ret.isNotEmpty ? ret.first : null);
      } else {
        return DataResult<Comment>.success(response.statusCode, null);
      }
  }
}
