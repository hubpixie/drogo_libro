import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'web_api.dart';

class DrogoInfosService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  List<DrogoInfo> _drogoInfos;
  List<DrogoInfo> get drogoInfoList => _drogoInfos;

  Future getDrogoInfosForUser(int userId) async {
    _drogoInfos = await _api.getDrogoInfosForUser(userId);
  }

} 
