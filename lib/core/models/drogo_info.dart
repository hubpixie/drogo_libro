
class DrogoSummary {
  int id;
  String drogoName; //薬名
  int days; //何日分
  int unit; //単位
  int usage; //用法
  int times; //回数／日
  int amount; //使用量/回
  String notaBene; //注意事項

  DrogoSummary({this.id, this.drogoName, this.days, this.unit, this.usage, this.times, this.amount, this.notaBene});

  DrogoSummary.fromJson(Map<String, dynamic> json) {
    drogoName = json["drogo_name"];
    days = json["days"];
    unit = json["unit"];
    usage = json["usage"];
    times = json["times"];
    amount = json["amount"];
    notaBene = json["nota_bene"];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drogo_name'] = this.drogoName;
    data['days'] = this.days;
    data['unit'] = this.unit;
    data['usage'] = this.usage;
    data['times'] = this.times;
    data['amount'] = this.amount;
    data['nota_bene'] = this.notaBene;
    return data;
  }

}
class DrogoInfo {
  int id;
  int userId;
  String dispeningDate;
  String medicalInstituteName;
  String doctorName;
  List<DrogoSummary> drogoSummaryList;

  DrogoInfo({this.id, this.userId, this.dispeningDate, this.medicalInstituteName, this.doctorName, this.drogoSummaryList });

  DrogoInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    dispeningDate = json['dispening_date'];
    medicalInstituteName = json['medical_institute_name'];
    doctorName = json['doctor_name'];
    drogoSummaryList = () {
      final dsList = json['drogo_summary_list'] as List;
      return dsList.map((element) => DrogoSummary.fromJson(element)).toList();
    }();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['dispening_date'] = this.dispeningDate;
    data['medical_institute_name'] = this.medicalInstituteName;
    data['doctor_name'] = this.doctorName;
    data['drogo_summary_list'] = this.drogoSummaryList.map((element) => element.toJson()).toList();
    
    return data;
  }
}