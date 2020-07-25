/// コード名称クラス
///  （飲み方）
enum DrogoUsages {
  beforeMeal,   //食前
  afterMeal,    //食後
  justBeforeMeal, //食直前
  justAfterMeal,  //食直後
  middleMeal,     //食間
  beforeSleep,    //就寝前
  eachHour,       //何時間ごと
  oneShot         //頓服
}
extension DrogoUsageDescripts on DrogoUsages {

  String get name {
    switch (this) {
      case DrogoUsages.beforeMeal:
        return '食前';
      case DrogoUsages.afterMeal:
        return '食後';
      case DrogoUsages.justBeforeMeal:
        return '食直前';
      case DrogoUsages.justAfterMeal:
        return '食直後';
      case DrogoUsages.middleMeal:
        return '食間';
      case DrogoUsages.beforeSleep:
        return '就寝前';
      case DrogoUsages.eachHour:
        return '〜時間ごと';
      case DrogoUsages.oneShot:
        return '頓服';
      default:
        return null;
    }
  }

  static DrogoUsages fromString(String string) {
    return DrogoUsages.values.firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case DrogoUsages.beforeMeal:
      case DrogoUsages.afterMeal:
      case DrogoUsages.justBeforeMeal:
      case DrogoUsages.justAfterMeal:
      case DrogoUsages.middleMeal:
      case DrogoUsages.beforeSleep:
      case DrogoUsages.eachHour:
      case DrogoUsages.oneShot:
        return this.toString().split(".").last;
      default:
        return null;
    }
  }
}
