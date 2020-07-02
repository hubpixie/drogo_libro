/// アナリティクス用送信元クラス
enum ScreenRouteName {
  splash,  
  login,
  home,
  myTabs,
  post,
}
extension ScreenRouteNameSummary on ScreenRouteName {

  String get name {
    switch (this) {
      case ScreenRouteName.splash:
        return 'splash';
      case ScreenRouteName.login:
        return 'login';
      case ScreenRouteName.myTabs:
        return 'myTabs';
      case ScreenRouteName.home:
        return '/';
      case ScreenRouteName.post:
        return 'post';
      default:
        return null;
    }
  }

  static ScreenRouteName fromString(String string) {
    return ScreenRouteName.values.firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case ScreenRouteName.home:
      case ScreenRouteName.login:
        return this.toString().split(".").last;
      default:
        return null;
    }
  }
}
