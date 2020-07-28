/// 遷移元画面クラス
enum ScreenRouteName {
  splash,  
  login,
  home,
  myTabs,
  passcode,
  listupDrogo,
  searchDrogo,
  addDrogoDetail,
  editDrogoDetail,
  editMyMemo,
  usingDrogo,
  showDrogoForgotHelp,
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
      case ScreenRouteName.passcode:
        return 'passcode';
      case ScreenRouteName.listupDrogo:
        return 'listupDrogo';
      case ScreenRouteName.searchDrogo:
        return 'searchDrogo';
      case ScreenRouteName.addDrogoDetail:
        return 'addDrogoDetail';
      case ScreenRouteName.editDrogoDetail:
        return 'editDrogoDetail';
      case ScreenRouteName.editMyMemo:
        return 'editMyMemo';
      case ScreenRouteName.usingDrogo:
        return 'usingDrogo';
      case ScreenRouteName.showDrogoForgotHelp:
        return 'showDrogoForgotHelp';
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
