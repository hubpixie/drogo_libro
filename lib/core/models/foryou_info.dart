import 'package:drogo_libro/core/enums/code_enums.dart';

class ForyouInfo{
  int id;
  int userId;
  BloodTypes bloodType;
  
  ForyouInfo({this.id, this.userId, this.bloodType});

  ForyouInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bloodType = CodeEnumsUtil.toAnyEnum(BloodTypes.values, json['blood_type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['blood_type'] = this.bloodType.index;
    return data;
  }

}