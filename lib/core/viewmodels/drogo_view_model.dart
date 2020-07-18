import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/core/services/drogo_infos_service.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'base_view_model.dart';

class DrogoViewModel extends BaseViewModel {
  DrogoInfosService _drogoService = ServiceSetting.locator<DrogoInfosService>();
  
  List<DrogoInfo> get drogoInfoList => _drogoService.drogoInfoList;

  Future getDrogoInfoList(int userId) async {
    setState(ViewState.Busy);
    await _drogoService.getDrogoInfosForUser(userId);
    setState(ViewState.Idle);
  }
}