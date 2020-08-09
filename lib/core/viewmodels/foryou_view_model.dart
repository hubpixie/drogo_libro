import 'dart:async';

import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';

import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/core/services/foryou_infos_service.dart';

import 'base_view_model.dart';

class ForyouViewModel extends BaseViewModel {
  ForyouInfosService _foryouService = ServiceSetting.locator<ForyouInfosService>();
  
  DataResult get fetchedForyouInfo => _foryouService.fetchedForyouInfo;
  DataResult get updatedForyouInfo => _foryouService.updatedForyouInfo;

  /// get foryou info
  ///  
  Future getForyouInfo(int userId) async {
    setState(ViewState.Busy);
    await _foryouService.getForyouInfoForUser(userId);
    setState(ViewState.Idle);
  }

  /// update foryou info
  ///  
  Future updateForyouInfo(ForyouInfo body) async {

    setState(ViewState.Busy);
    if(body.id == null) {
      await _foryouService.createForyouInfo(body);
    } else {
      await _foryouService.updateForyouInfo(body);
    }
    setState(ViewState.Idle);
  }
}