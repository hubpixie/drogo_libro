import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:drogo_libro/core/models/post.dart';
import 'package:drogo_libro/ui/views/my_tabs_container.dart';
import 'package:drogo_libro/ui/views/login_view.dart';
import 'package:drogo_libro/ui/views/splash_view.dart';
import 'package:drogo_libro/ui/views/post_view.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';


class ScreenRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    ScreenRouteName sr = ScreenRouteNameSummary.fromString(settings.name);
    switch (sr) {
      case ScreenRouteName.myTabs:
        return MaterialPageRoute(builder: (_) => MyTabsContainer(), settings: settings);
      case ScreenRouteName.splash:
        return MaterialPageRoute(builder: (_) => SplashView(), settings: settings);
      case ScreenRouteName.login:
        return MaterialPageRoute(builder: (_) => LoginView(), settings: settings);
      case ScreenRouteName.post:
        var post = settings.arguments as Post;
        return MaterialPageRoute(builder: (_) => PostView(post: post), settings: settings);
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
