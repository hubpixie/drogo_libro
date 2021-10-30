import 'dart:convert';

import 'package:drogo_libro/core/services/base_api_client.dart';
import 'package:drogo_libro/config/app_env.dart';

import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/enums/http_status.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';

/// The service responsible for networking requests
class MyWebApi {
  static final String _endpoint = AppEnv.apiBaseUrl ?? '';

  MyWebApi() {
    BaseApiClient();
  }

  Future<DataResult> getUserProfile(int userId) async {
    // Get user profile for id
    try {
      final response = await BaseApiClient.client.get(
        '$_endpoint/users/$userId',
        // headers: {HttpHeaders.authorizationHeader: BaseApiClient.commonHeaders['Authorization']},
      );

      // Convert and return
      if (response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if (response.body != null) {
        return DataResult<User>.success(
            response.statusCode, User.fromJson(json.decode(response.body)));
      } else {
        return DataResult<User>.success(response.statusCode, null);
      }
    } catch (error) {
      print("error = ${error.toString()}");
      return DataResult<User>.error(HttpStatus.otherError, error);
    }
  }

  Future<DataResult> getDrogoInfosForUser(int userId,
      {DrogoSearchParam? param}) async {
    // Get user posts for id
    var url = ('$_endpoint/drogo_infos?userId=$userId');
    if (param != null) {
      if (param.dispeningDate != null) {
        url += '&dispening_date=${param.dispeningDate}';
      } else if (param.drogoName != null) {
        url += '&drogo_name=${param.drogoName}';
      } else if (param.usage != null) {
        url += '&usage=${param.usage}';
      } else if (param.times != null) {
        url += '&times=${param.times}';
      } else if (param.medicalInstituteName != null) {
        url += '&medical_institute_name_like=${param.medicalInstituteName}';
      } else if (param.doctorName != null) {
        url += '&doctor_name_like=${param.doctorName}';
      }
    }

    try {
      final response = await BaseApiClient.client.get(
        url,
        // headers: {HttpHeaders.authorizationHeader: BaseApiClient.commonHeaders['Authorization']},
      );

      // set result to return
      //
      if (response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if (response.body != null) {
        var parsed = json.decode(response.body) as List<dynamic>;
        return DataResult<List<DrogoInfo>>.success(response.statusCode,
            parsed.map((element) => DrogoInfo.fromJson(element)).toList());
      } else {
        return DataResult<List<DrogoInfo>>.success(response.statusCode, null);
      }
    } catch (error) {
      return DataResult<List<DrogoInfo>>.error(HttpStatus.otherError, error);
    }
  }

  /// Get Foryou info (http/get)
  ///
  Future<DataResult> getForyouInfoForUser(int userId) async {
    // Get user posts for id
    final url = ('$_endpoint/foryou_infos?userId=$userId');

    try {
      final response = await BaseApiClient.client.get(
        url,
        //headers: {HttpHeaders.authorizationHeader: BaseApiClient.commonHeaders['Authorization']},
      );

      // set result to return
      //
      if (response.statusCode >= HttpStatus.badRequest) {
        return DataResult.error(response.statusCode, response.body);
      } else if (response.body != null) {
        final parsed = json.decode(response.body) as List<dynamic>;
        final ret =
            parsed.map((element) => ForyouInfo.fromJson(element)).toList();
        return DataResult<ForyouInfo>.success(
            response.statusCode, ret.isNotEmpty ? ret.first : null);
      } else {
        return DataResult<ForyouInfo>.success(response.statusCode, null);
      }
    } catch (error) {
      return DataResult<ForyouInfo>.error(HttpStatus.otherError, error);
    }
  }

  /// Create Foryou info (http/post)
  ///
  Future<DataResult> createForyouInfo(ForyouInfo body) async {
    // Get user posts for id
    final url = ('$_endpoint/foryou_infos');

    final response = await BaseApiClient.client.post(url,
        headers: BaseApiClient.commonHeaders, body: jsonEncode(body.toJson()));

    // set result to return
    //
    if (response.statusCode >= HttpStatus.badRequest) {
      return DataResult.error(response.statusCode, response.body);
    } else if (response.body != null) {
      final parsed = json.decode(response.body) as List<dynamic>;
      final ret =
          parsed.map((element) => ForyouInfo.fromJson(element)).toList();
      return DataResult<ForyouInfo>.success(
          response.statusCode, ret.isNotEmpty ? ret.first : null);
    } else {
      return DataResult<ForyouInfo>.success(response.statusCode, null);
    }
  }

  /// Update Foryou info (http/put)
  ///
  Future<DataResult> updateForyouInfo(ForyouInfo body) async {
    // Get user posts for id
    final url = ('$_endpoint/foryou_infos/${body.id}');

    final response = await BaseApiClient.client.put(url,
        headers: BaseApiClient.commonHeaders, body: jsonEncode(body.toJson()));

    // set result to return
    //
    if (response.statusCode >= HttpStatus.badRequest) {
      return DataResult.error(response.statusCode, response.body);
    } else if (response.body != null) {
      return DataResult<ForyouInfo>.success(
          response.statusCode, ForyouInfo.fromJson(json.decode(response.body)));
    } else {
      return DataResult<ForyouInfo>.success(response.statusCode, null);
    }
  }
}
