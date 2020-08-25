import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/views/my_tabs_container.dart';
import 'package:drogo_libro/ui/views/login_view.dart';
import 'package:drogo_libro/ui/views/splash_view.dart';
import 'package:drogo_libro/ui/views/passcode_view.dart';
import 'package:drogo_libro/ui/views/drogo_list_view.dart';
import 'package:drogo_libro/ui/views/drogo_search_view.dart';
import 'package:drogo_libro/ui/views/drogo_detail_view.dart';
import 'package:drogo_libro/ui/views/foryou_present_view.dart';
import 'package:drogo_libro/ui/views/foryou_edit_container.dart';
import 'package:drogo_libro/ui/views/city_selector_view.dart';

class ScreenRouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    ScreenRouteName sr = ScreenRouteNameSummary.fromString(settings.name);
    switch (sr) {
      case ScreenRouteName.myTabs:
        return MaterialPageRoute(builder: (_) => MyTabsContainer(), settings: settings);
      case ScreenRouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashView(), settings: settings);
      case ScreenRouteName.login:
        return MaterialPageRoute(builder: (_) => LoginView(), settings: settings);
      case ScreenRouteName.passcode:
        return MaterialPageRoute(builder: (_) => PasscodeView(title: 'Passcode Lock Screen'), settings: settings);
      case ScreenRouteName.listupDrogo:
        return MaterialPageRoute(builder: (_) => DrogoListView(title: 'おくすり一覧'), settings: settings);
      case ScreenRouteName.searchDrogo:
        return MaterialPageRoute(builder: (_) => DrogoSearchView(title: 'おくすり検索'), settings: settings);
      case ScreenRouteName.addDrogoDetail:
      case ScreenRouteName.editDrogoDetail:
          final Map<String, dynamic> arg = settings.arguments;
        return MaterialPageRoute(builder: (_) => DrogoDetailView(drogoItem: arg != null ? arg["drogoItem"] : null), 
          settings: settings);
      case ScreenRouteName.editMyMemo:
        return MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(backgroundColor: Color(0xFF64B7DA), title: Text('気になったことを記録する'),), 
            body: Container()));
      case ScreenRouteName.usingDrogo:
        return MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(backgroundColor: Color(0xFF64B7DA), title: Text('おくすりの飲み方について'),), 
            body: Container()));
      case ScreenRouteName.showDrogoForgotHelp:
        return MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(backgroundColor: Color(0xFF64B7DA), title: Text('おくすりを飲み忘れたら'),), 
            body: Container()));
      case ScreenRouteName.presentForyouAll:
        return MaterialPageRoute(builder: (_) => ForyouPresentView(title: 'For you一覧'), settings: settings);
      case ScreenRouteName.usingForyou:
        return MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(backgroundColor: Color(0xFF64B7DA), title: Text('記載方法について'),), 
            body: Container()));
      case ScreenRouteName.editBloodType:
        return MaterialPageRoute(builder: (_) => ForyouEditContainer(title: '血液型', routeName: ScreenRouteName.editBloodType, ), settings: settings);
      case ScreenRouteName.editMedicalHistory:
        return MaterialPageRoute(builder: (_) => ForyouEditContainer(title: '既往歴',routeName: ScreenRouteName.editMedicalHistory,), settings: settings);
      case ScreenRouteName.editAllergy:
        return MaterialPageRoute(builder: (_) => ForyouEditContainer(title: 'アレルギー', routeName: ScreenRouteName.editAllergy,), settings: settings);
      case ScreenRouteName.editSuplements:
        return MaterialPageRoute(builder: (_) => ForyouEditContainer(title: 'サプリメントなど', routeName: ScreenRouteName.editSuplements,), settings: settings);
      case ScreenRouteName.editSideEffect:
        return MaterialPageRoute(builder: (_) => ForyouEditContainer(title: '副作用', routeName: ScreenRouteName.editSideEffect,), settings: settings);
      case ScreenRouteName.selectCity:
        return MaterialPageRoute(builder: (_) => CitySelectorView(title: '地域設定', 
        cityItem: settings.arguments,), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
