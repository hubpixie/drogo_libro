import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/services/authentication_service.dart';
import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/services/firebse_analytics_service.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/screen_router.dart';

void main() {
  ServiceSetting.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      initialData: User.initial(),
      create: (context) =>
          ServiceSetting.locator<AuthenticationService>().userController.stream,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: ScreenRouteName.splash.name,
        onGenerateRoute: ScreenRouter.generateRoute,
        navigatorObservers: kIsWeb ? 
          [] : [ServiceSetting.locator<FirebaseAnalyticsService>().observer],
      ),
    );
  }
}
