import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';

import 'web_api.dart';

class ForyouInfosService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  
  DataResult _fetchedForyouInfo;
  DataResult _updatedForyouInfo;
  DataResult get fetchedForyouInfo => _fetchedForyouInfo;
  DataResult get updatedForyouInfo => _updatedForyouInfo;

  /// Get foryou
  /// 
  Future getForyouInfoForUser(int userId) async {
    _fetchedForyouInfo = await _api.getForyouInfoForUser(userId);
  }

  /// Create foryou
  /// 
  Future createForyouInfo(ForyouInfo body) async {
    _updatedForyouInfo = await _api.createForyouInfo(body);
  }

  /// Update foryou
  /// 
  Future updateForyouInfo(ForyouInfo body) async {
    _updatedForyouInfo = await _api.updateForyouInfo(body);
  }

} 
