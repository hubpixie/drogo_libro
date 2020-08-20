import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/services/authentication_service.dart';
import 'package:drogo_libro/core/viewmodels/base_view_model.dart';

import 'package:drogo_libro/config/service_setting.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = ServiceSetting.locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String userIdText) async {
    setState(ViewState.Busy);

    var userId = int.tryParse(userIdText);

    // Not a number
    if(userId == null) {
      errorMessage = 'Value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.login(userId);

    // Handle potential error here too. 

    setState(ViewState.Idle);
    return success;
  }
}
