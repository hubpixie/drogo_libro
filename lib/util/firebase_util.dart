import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

/// アナリティクスイベント
enum AnalyticsEvent {
  button,
}

enum AnalyticsRoute {
   home,
}
extension AnalyticsRouteInfo on AnalyticsRoute {

  String get screenName {
    switch (this) {
      case AnalyticsRoute.home:
        return '/home';
      default:
        return null;
    }
  }

  String get screenClass {
    switch (this) {
      case AnalyticsRoute.home:
        return this.toString().split(".")[1];
      default:
        return null;
    }
  }


}

/// アナリティクス
class FirebaseUtil {
  FirebaseAnalytics _analytics;
  FirebaseAnalyticsObserver _observer;
  
  FirebaseAnalytics get analytics => FirebaseUtil.shared()._analytics;
  FirebaseAnalyticsObserver get observer => FirebaseUtil.shared()._observer;

  static FirebaseUtil _instance;
  static FirebaseUtil shared(){
    if (_instance == null) {
      _instance = new FirebaseUtil();
      if (!kIsWeb) {
        _instance._analytics = FirebaseAnalytics();
        _instance._observer = FirebaseAnalyticsObserver(analytics: _instance._analytics);
      }
    }
    return _instance;
  }


  /// 画面遷移時に画面名を送信
  Future<void> sendViewEvent({@required AnalyticsRoute route}) async {
    if (kIsWeb) {return;}
    analytics.setCurrentScreen(screenName: route.screenName, screenClassOverride: route.screenClass);
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
    analytics.logEvent(name: eventName, parameters: parameterMap);
  }
}
