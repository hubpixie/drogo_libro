import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';

import 'my_web_api.dart';

class ForyouInfosService {
  MyWebApi _api = ServiceSetting.locator<MyWebApi>();

  late DataResult _fetchedForyouInfo;
  late DataResult _updatedForyouInfo;
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
