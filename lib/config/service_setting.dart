import 'package:get_it/get_it.dart';

import 'package:drogo_libro/core/services/my_web_api.dart';
import 'package:drogo_libro/core/services/weather_web_api.dart';
import 'package:drogo_libro/core/services/drogo_infos_service.dart';
import 'package:drogo_libro/core/services/foryou_infos_service.dart';
import 'package:drogo_libro/core/services/weather_infos_service.dart';
import 'package:drogo_libro/core/services/authentication_service.dart';

import 'package:drogo_libro/core/viewmodels/drogo_view_model.dart';
import 'package:drogo_libro/core/viewmodels/foryou_view_model.dart';
import 'package:drogo_libro/core/viewmodels/weather_view_model.dart';
import 'package:drogo_libro/core/viewmodels/login_view_model.dart';
import "package:drogo_libro/core/services/firebse_analytics_service.dart";


class ServiceSetting {
  static GetIt locator = GetIt.instance;
  static void setup() {
    locator.registerLazySingleton(() => AuthenticationService());
    locator.registerLazySingleton(() => DrogoInfosService());
    locator.registerLazySingleton(() => ForyouInfosService());
    locator.registerLazySingleton(() => MyWebApi());
    locator.registerLazySingleton(() => WeatherWebApi());
    locator.registerLazySingleton(() => WeatherInfosService());

    locator.registerFactory(() => LoginViewModel());
    locator.registerFactory(() => DrogoViewModel());
    locator.registerFactory(() => ForyouViewModel());
    locator.registerFactory(() => WeatherViewModel());

    locator.registerFactory(() => FirebaseAnalyticsService());
  }
}

