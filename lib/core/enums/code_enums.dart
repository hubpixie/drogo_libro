/// コード名称クラス
///

///  （飲み方）
enum DrogoUsages {
  beforeMeal, //食前
  afterMeal, //食後
  justBeforeMeal, //食直前
  justAfterMeal, //食直後
  middleMeal, //食間
  beforeSleep, //就寝前
  eachHour, //何時間ごと
  oneShot //頓服
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
        return '';
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
        return '';
    }
  }
}

///  （血液型）
enum BloodTypes {
  a, //A型
  b, //B型
  ab, //AB型
  o, //O型
  rhPlus, //RH+型
  rhMinus, //RH-型
}

extension BloodTypeDescripts on BloodTypes {
  String get name {
    switch (this) {
      case BloodTypes.a:
        return 'A';
      case BloodTypes.b:
        return 'B';
      case BloodTypes.ab:
        return 'AB';
      case BloodTypes.o:
        return 'O';
      case BloodTypes.rhPlus:
        return 'Rh+';
      case BloodTypes.rhMinus:
        return 'Rh-';
      default:
        return '';
    }
  }

  static BloodTypes fromString(String string) {
    return BloodTypes.values.firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case BloodTypes.a:
      case BloodTypes.b:
      case BloodTypes.ab:
      case BloodTypes.o:
      case BloodTypes.rhPlus:
      case BloodTypes.rhMinus:
        return this.toString().split(".").last;
      default:
        return '';
    }
  }
}

///  （アレルギー）
enum AllergyTypes {
  milk, //牛乳
  egg, //卵
  pollinosis, //AB型
  etc, //O型
}

extension AllergyTypeDescripts on AllergyTypes {
  String get name {
    switch (this) {
      case AllergyTypes.milk:
        return '牛乳';
      case AllergyTypes.egg:
        return '卵';
      case AllergyTypes.pollinosis:
        return '花粉症';
      case AllergyTypes.etc:
        return 'その他';
      default:
        return '';
    }
  }

  static AllergyTypes fromString(String string) {
    return AllergyTypes.values.firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case AllergyTypes.milk:
      case AllergyTypes.egg:
      case AllergyTypes.pollinosis:
      case AllergyTypes.etc:
        return this.toString().split(".").last;
      default:
        return '';
    }
  }
}

///  （服用中のサプリメントなど）
enum SuplementTypes {
  vitaminK, //ビタミンK
  stJohnsWort, //セント・ジョーンズ・ワート
  gingyoLeafExtract, //イチョウ葉エキス
  etc, //その他
}

extension SuplementTypeDescripts on SuplementTypes {
  String get name {
    switch (this) {
      case SuplementTypes.vitaminK:
        return 'ビタミンK（納豆、青汁、クロレラなど）';
      case SuplementTypes.stJohnsWort:
        return 'セント・ジョーンズ・ワート';
      case SuplementTypes.gingyoLeafExtract:
        return 'イチョウ葉エキス';
      case SuplementTypes.etc:
        return 'その他';
      default:
        return '';
    }
  }

  static SuplementTypes fromString(String string) {
    return SuplementTypes.values
        .firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case SuplementTypes.vitaminK:
      case SuplementTypes.stJohnsWort:
      case SuplementTypes.gingyoLeafExtract:
      case SuplementTypes.etc:
        return this.toString().split(".").last;
      default:
        return '';
    }
  }
}

///  （主な既往歴）
enum MedicalHistoryTypes {
  hypertension, //高血圧
  hyperlipidemia, //高脂血症
  dm, //糖尿病
  gdu, //胃・十二指腸潰瘍
  kd, //腎臓病
  asthma, //喘息
  bph, //前立腺肥大
  ld, //肝臓病
  glaucoma, //緑内障
  hd, //心臓病
  etc, //その他
}

extension MedicalHistoryTypeDescripts on MedicalHistoryTypes {
  String get name {
    switch (this) {
      case MedicalHistoryTypes.hypertension:
        return '高血圧';
      case MedicalHistoryTypes.hyperlipidemia:
        return '高脂血症';
      case MedicalHistoryTypes.dm:
        return '糖尿病';
      case MedicalHistoryTypes.gdu:
        return '胃・十二指腸潰瘍';
      case MedicalHistoryTypes.kd:
        return '腎臓病';
      case MedicalHistoryTypes.asthma:
        return '喘息';
      case MedicalHistoryTypes.bph:
        return '前立腺肥大';
      case MedicalHistoryTypes.ld:
        return '肝臓病';
      case MedicalHistoryTypes.glaucoma:
        return '緑内障';
      case MedicalHistoryTypes.hd:
        return '心臓病';
      case MedicalHistoryTypes.etc:
        return 'その他';
      default:
        return '';
    }
  }

  static MedicalHistoryTypes fromString(String string) {
    return MedicalHistoryTypes.values
        .firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case MedicalHistoryTypes.hypertension:
      case MedicalHistoryTypes.hyperlipidemia:
      case MedicalHistoryTypes.dm:
      case MedicalHistoryTypes.gdu:
      case MedicalHistoryTypes.kd:
      case MedicalHistoryTypes.asthma:
      case MedicalHistoryTypes.bph:
      case MedicalHistoryTypes.ld:
      case MedicalHistoryTypes.glaucoma:
      case MedicalHistoryTypes.hd:
      case MedicalHistoryTypes.etc:
        return this.toString().split(".").last;
      default:
        return '';
    }
  }
}

/// (温度単位)
enum TemperatureUnit { kelvin, celsius, fahrenheit }

extension TemperatureUnitDescripts on TemperatureUnit {
  String get name {
    switch (this) {
      case TemperatureUnit.kelvin:
        return '°K';
      case TemperatureUnit.celsius:
        return '°C'; //
      case TemperatureUnit.fahrenheit:
        return '°F';
      default:
        return '';
    }
  }

  static TemperatureUnit fromString(String string) {
    return TemperatureUnit.values
        .firstWhere((element) => element.name == string);
  }

  String get stringClass {
    switch (this) {
      case TemperatureUnit.kelvin:
      case TemperatureUnit.celsius:
      case TemperatureUnit.fahrenheit:
        return this.toString().split(".").last;
      default:
        return '';
    }
  }
}

class CodeEnumsUtil {
  /// Convert a rawValue to enum value
  ///  - param [enumValues] : all enums of T
  ///  - param [rawValue] : an index value of enum
  static T? toAnyEnum<T>(List<T> enumValues, int rawValue) {
    T? ret;
    for (int idx = 0; idx < enumValues.length; idx++) {
      if (idx == rawValue) {
        ret = enumValues[idx];
        break;
      }
    }
    return ret;
  }
}
