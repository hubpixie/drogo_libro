/// 遷移元画面クラス
enum ScreenRouteName {
  splash,  
  login,
  home,
  myTabs,
  passcode,
  // Myくすり
  listupDrogo,    //一覧
  searchDrogo,    //検索
  addDrogoDetail, //登録
  editDrogoDetail, //編集
  editMyMemo,     //気になったことを記録
  usingDrogo,     //薬の飲み方
  showDrogoForgotHelp, //飲み忘れた時
  // For you
  presentForyouAll,    //Foryou　全部みる
  usingForyou,    //記載方法
  editBloodType, //血液型
  editMedicalHistory,     //既往歴
  editAllergy,     //アレルギー
  editSuplements, //サプリメントなど
  editSideEffect, //副作用
  selectCity,     //地域設定
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
      case ScreenRouteName.presentForyouAll:
        return 'presentForyouAll';
      case ScreenRouteName.usingForyou:
        return 'usingForyou';
      case ScreenRouteName.editBloodType:
        return 'editBloodType';
      case ScreenRouteName.editMedicalHistory:
        return 'editMedicalHistory';
      case ScreenRouteName.editAllergy:
        return 'editAllergy';
      case ScreenRouteName.editSuplements:
        return 'editSuplements';
      case ScreenRouteName.editSideEffect:
        return 'editSideEffect';
      case ScreenRouteName.selectCity:
        return 'selectCity';
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
