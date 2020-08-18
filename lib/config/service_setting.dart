import 'package:get_it/get_it.dart';

import 'package:drogo_libro/core/services/web_api.dart';
import 'package:drogo_libro/core/services/posts_service.dart';
import 'package:drogo_libro/core/services/drogo_infos_service.dart';
import 'package:drogo_libro/core/services/foryou_infos_service.dart';
import 'package:drogo_libro/core/services/authentication_service.dart';
import 'package:drogo_libro/core/viewmodels/like_button_model.dart';

import 'package:drogo_libro/core/viewmodels/home_model.dart';
import 'package:drogo_libro/core/viewmodels/comments_model.dart';
import 'package:drogo_libro/core/viewmodels/drogo_view_model.dart';
import 'package:drogo_libro/core/viewmodels/foryou_view_model.dart';
import 'package:drogo_libro/core/viewmodels/login_model.dart';
import "package:drogo_libro/core/services/firebse_analytics_service.dart";


class ServiceSetting {
  static GetIt locator = GetIt.instance;
  static void setup() {
    locator.registerLazySingleton(() => AuthenticationService());
    locator.registerLazySingleton(() => PostsService());
    locator.registerLazySingleton(() => DrogoInfosService());
    locator.registerLazySingleton(() => ForyouInfosService());
    locator.registerLazySingleton(() => WebApi());

    locator.registerFactory(() => LoginModel());
    locator.registerFactory(() => HomeModel());
    locator.registerFactory(() => LikeButtonModel());
    locator.registerFactory(() => DrogoViewModel());
    locator.registerFactory(() => ForyouViewModel());
    locator.registerFactory(() => CommentsModel());

    locator.registerFactory(() => FirebaseAnalyticsService());
  }
}

