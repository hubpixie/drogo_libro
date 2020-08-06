import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';

import 'web_api.dart';

class ForyouInfosService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  
  DataResult _foryouInfo;
  DataResult _foryouInfoUpdated;
  DataResult get foryouInfo => _foryouInfo;
  DataResult get foryouInfoUpdated => _foryouInfoUpdated;

  /// Get foryou
  /// 
  Future getForyouInfoForUser(int userId) async {
    _foryouInfo = await _api.getForyouInfoForUser(userId);
  }

  /// Create foryou
  /// 
  Future createForyouInfo(ForyouInfo body) async {
    _foryouInfoUpdated = await _api.createForyouInfo(body);
  }

  /// Update foryou
  /// 
  Future updateForyouInfo(ForyouInfo body) async {
    _foryouInfoUpdated = await _api.updateForyouInfo(body);
  }

} 
