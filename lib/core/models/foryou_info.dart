import 'package:drogo_libro/core/enums/code_enums.dart';

class ForyouInfo{
  int id;
  int userId;
  BloodTypes bloodType;
  List<bool> medicalHistoryTypeList;
  String medicalHdText;
  String medicalEtcText;
  List<bool> allergyHistoryTypeList;
  String allergyEtcText;
  
  ForyouInfo({this.id, this.userId, this.bloodType, 
    this.medicalHistoryTypeList, this.medicalHdText, this.medicalEtcText,
    this.allergyHistoryTypeList, this.allergyEtcText
    });

  ForyouInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bloodType = CodeEnumsUtil.toAnyEnum(BloodTypes.values, json['blood_type']);
    medicalHistoryTypeList = () {
      final dsList = json['medical_history_type_list'] as List;
      return dsList.map((element) => element != 0).toList();
    }();
    medicalHdText = json['medical_hd_text'];
    medicalEtcText = json['medical_etc_text'];
    allergyHistoryTypeList = () {
      final dsList = json['allergy_history_type_list'] as List;
      return dsList.map((element) => element != 0).toList();
    }();
    allergyEtcText = json['allergy_etc_text'];
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

    return data;
  }

}