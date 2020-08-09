import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';
import 'package:drogo_libro/core/services/drogo_infos_service.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'base_view_model.dart';

class DrogoViewModel extends BaseViewModel {
  DrogoInfosService _drogoService = ServiceSetting.locator<DrogoInfosService>();
  
  DataResult get fetchedDrogoInfos => _drogoService.fetchedDrogoInfos;

  Future getDrogoInfos(int userId, 
    {DrogoSearchParam param}) async {

    setState(ViewState.Busy);
    await _drogoService.getDrogoInfosForUser(userId,
      param: param);
    setState(ViewState.Idle);
  }
}