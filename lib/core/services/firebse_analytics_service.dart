import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

/// アナリティクスイベント
enum AnalyticsEvent {
  button,
}

/// アナリティクス用送信元クラス
enum AnalyticsSender {
  home,
  login,
}

extension AnalyticsSenderSummary on AnalyticsSender {
  String? get screenName {
    switch (this) {
      case AnalyticsSender.home:
        return '/';
      case AnalyticsSender.login:
        return 'login';
      default:
        return null;
    }
  }

  String? get screenClass {
    switch (this) {
      case AnalyticsSender.home:
      case AnalyticsSender.login:
        return this.toString().split(".").last;
      default:
        return null;
    }
  }
}

/// アナリティクス
class FirebaseAnalyticsService {
  static FirebaseAnalytics? _analytics;

  FirebaseAnalytics? get analytics => _analytics;
  FirebaseAnalyticsObserver? get observer {
    if (!kIsWeb) {
      return FirebaseAnalyticsObserver(
          analytics: _analytics ?? FirebaseAnalytics());
    } else {
      return null;
    }
  }

  /// 画面遷移時に画面名を送信
  Future<void> sendViewEvent({@required AnalyticsSender? sender}) async {
    if (kIsWeb) {
      return;
    }
    if (sender != null) {
      _analytics?.setCurrentScreen(
          screenName: sender.screenName,
          screenClassOverride: sender.screenClass ?? '');
    }
  }

  /// ボタンタップイベント送信
  Future<void> sendButtonEvent({@required String? buttonName}) async {
    if (kIsWeb) {
      return;
    }
    sendEvent(
        event: AnalyticsEvent.button,
        parameterMap: {'buttonName': "$buttonName"});
  }

  /// イベントを送信する
  /// [event] AnalyticsEvent
  /// [parameterMap] パラメータMap
  Future<void> sendEvent(
      {@required AnalyticsEvent? event,
      Map<String, dynamic>? parameterMap}) async {
    final eventName = event.toString().split('.')[1];
    _analytics?.logEvent(name: eventName, parameters: parameterMap);
  }
}
