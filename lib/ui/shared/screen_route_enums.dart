/// 遷移元画面クラス
enum ScreenRouteName {
  splash,  
  login,
  home,
  myTabs,
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
  // settings tab
  selectCity,     //地域設定
  passcode,   //パスコード表示画面
  changePasscodeSettings,     //パスコード表示設定画面
  editPasscode,           //パスコード編集画面
  presentWeeklyForecast,  //週間天気予報画面
  selectCityFavorite,     //お気に入り一覧（地域）
  selectCountry,     //国名コード一覧選択
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
      case ScreenRouteName.passcode:
        return 'passcode';
      case ScreenRouteName.changePasscodeSettings:
        return 'changePasscodeSettings';
      case ScreenRouteName.editPasscode:
        return 'editPasscode';
      case ScreenRouteName.presentWeeklyForecast:
        return 'presentWeeklyForecast';
      case ScreenRouteName.selectCityFavorite:
        return 'selectCityFavorite';
      case ScreenRouteName.selectCountry:
        return 'selectCountry';
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
