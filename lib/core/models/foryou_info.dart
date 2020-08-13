import 'package:drogo_libro/core/enums/code_enums.dart';
class SideEffectInfo {
  static const int kListMxLength = 5;

  int id;
  String drogoName;
  String symptom;

  SideEffectInfo({this.id, this.drogoName, this.symptom});

  SideEffectInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    drogoName = json['drogo_name'];
    symptom = json['symptom'];
  }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['drogo_name'] = this.drogoName;
      data['symptom'] = this.symptom;
      return data;
    }
}
class ForyouInfo{
  int id;
  int userId;
  BloodTypes bloodType;
  List<bool> medicalHistoryTypeList;
  String medicalHdText;
  String medicalEtcText;
  List<bool> allergyHistoryTypeList;
  String allergyEtcText;
  List<bool> suplementTypeList;
  String suplementEtcText;
  List<SideEffectInfo> sideEffectList;
  
  ForyouInfo({this.id, this.userId, this.bloodType, 
    this.medicalHistoryTypeList, this.medicalHdText, this.medicalEtcText,
    this.allergyHistoryTypeList, this.allergyEtcText,
    this.suplementTypeList, this.suplementEtcText,
    this.sideEffectList
  });

  ForyouInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bloodType = CodeEnumsUtil.toAnyEnum(BloodTypes.values, json['blood_type']);
    medicalHistoryTypeList = () {
      final dsList = json['medical_history_type_list'] as List;
      return dsList != null ? dsList.map((element) => element != 0).toList() : <bool>[];
    }();
    medicalHdText = json['medical_hd_text'];
    medicalEtcText = json['medical_etc_text'];
    allergyHistoryTypeList = () {
      final dsList = json['allergy_history_type_list'] as List;
      return dsList != null ? dsList.map((element) => element != 0).toList() : <bool>[];
    }();
    allergyEtcText = json['allergy_etc_text'];
    suplementTypeList = () {
      final dsList = json['suplement_type_list'] as List;
      return dsList != null ? dsList.map((element) => element != 0).toList() : <bool>[];
    }();
    suplementEtcText = json['suplement_etc_text'];
    sideEffectList = () {
      var dsList = json['side_effect_list'] as List;
      if(dsList != null && dsList.isNotEmpty && dsList.length > SideEffectInfo.kListMxLength) {
        dsList = dsList.take(SideEffectInfo.kListMxLength).toList();
      }
      return dsList != null && dsList.isNotEmpty ? dsList.map((element) => SideEffectInfo.fromJson(element)).toList() : <SideEffectInfo>[];
    }();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['blood_type'] = this.bloodType.index;
    data['medical_history_type_list'] = this.medicalHistoryTypeList.map((element) => element ? 1 : 0).toList();
    data['medical_hd_text'] = this.medicalHdText;
    data['medical_etc_text'] = this.medicalEtcText;
    data['allergy_history_type_list'] = this.allergyHistoryTypeList.map((element) => element ? 1 : 0).toList();
    data['allergy_etc_text'] = this.allergyEtcText;
    data['suplement_type_list'] = this.suplementTypeList.map((element) => element ? 1 : 0).toList();
    data['suplement_etc_text'] = this.suplementEtcText;
    data['side_effect_list'] = this.sideEffectList.map((element) => element.toJson()).toList();
    
    return data;
  }

}