import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'web_api.dart';

class DrogoInfosService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  DataResult _drogoInfos;
  DataResult get drogoInfoList => _drogoInfos;

  Future getDrogoInfosForUser(int userId, 
    {DrogoSearchParam param}) async {
    _drogoInfos = await _api.getDrogoInfosForUser(userId, param: param);
  }

} 
