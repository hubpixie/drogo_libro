import 'dart:async';

import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'my_web_api.dart';

class AuthenticationService {
  MyWebApi _api = ServiceSetting.locator<MyWebApi>();

  StreamController<User> userController = StreamController<User>();

  Future<bool> login(int userId) async {
    var fetchedUser = await _api.getUserProfile(userId);

    var hasUser = fetchedUser.hasData;
    if(hasUser) {
      userController.add(fetchedUser.result);
    }

    return hasUser;
  }
}