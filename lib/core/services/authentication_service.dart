import 'dart:async';

import 'package:drogo_libro/core/models/user.dart';

import '../../config/service_setting.dart';
import 'web_api.dart';

class AuthenticationService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser != null;
    if(hasUser) {
      userController.add(fetchedUser);
    }

    return hasUser;
  }
}