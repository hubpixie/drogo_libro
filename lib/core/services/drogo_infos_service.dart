import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'web_api.dart';

class DrogoInfosService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  DataResult _fetchedDrogoInfos;
  DataResult get fetchedDrogoInfos => _fetchedDrogoInfos;

  Future getDrogoInfosForUser(int userId, 
    {DrogoSearchParam param}) async {
    _fetchedDrogoInfos = await _api.getDrogoInfosForUser(userId, param: param);
  }

} 
