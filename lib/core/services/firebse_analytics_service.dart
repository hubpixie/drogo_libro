import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

/// アナリティクスイベント
enum AnalyticsEvent {
  button,
}

enum AnalyticsRoute {
   home,
   login,
}
extension AnalyticsRouteInfo on AnalyticsRoute {

  String get screenName {
    switch (this) {
      case AnalyticsRoute.home:
        return '/';
      case AnalyticsRoute.login:
        return 'login';
      default:
        return null;
    }
  }

  String get screenClass {
    switch (this) {
      case AnalyticsRoute.home:
      case AnalyticsRoute.login:
        return this.toString().split(".")[1];
      default:
        return null;
    }
  }


}

/// アナリティクス
class FirebaseAnalyticsService {
  static FirebaseAnalytics _analytics;
  
  FirebaseAnalytics get analytics => _analytics;
  FirebaseAnalyticsObserver get observer {
    if (!kIsWeb) {
      if(_analytics == null) {
        _analytics = FirebaseAnalytics();
      }
      return FirebaseAnalyticsObserver(analytics: _analytics);
    } else {
      return null;
    }
  } 

  /// 画面遷移時に画面名を送信
  Future<void> sendViewEvent({@required AnalyticsRoute route}) async {
    if (kIsWeb) {return;}
    _analytics.setCurrentScreen(screenName: route.screenName, screenClassOverride: route.screenClass);
  }

  /// ボタンタップイベント送信
  Future<void> sendButtonEvent({@required String buttonName}) async {
    if (kIsWeb) {return;}
    sendEvent(
        event: AnalyticsEvent.button,
        parameterMap: {'buttonName': "$buttonName"});
  }

  /// イベントを送信する
  /// [event] AnalyticsEvent
  /// [parameterMap] パラメータMap
  Future<void> sendEvent(
      {@required AnalyticsEvent event,
      Map<String, dynamic> parameterMap}) async {
    final eventName = event.toString().split('.')[1];
    _analytics.logEvent(name: eventName, parameters: parameterMap);
  }
}
