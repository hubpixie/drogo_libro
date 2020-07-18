
class DrogoSummary {
  String drogoName; //薬名
  int days; //何日分
  int unit; //単位
  int usage; //用法
  int times; //回数／日
  int amount; //使用量/回
  String notaBene; //注意事項

  DrogoSummary({this.drogoName, this.days, this.unit, this.usage, this.times, this.amount, this.notaBene});

  DrogoSummary.fromJson(Map<String, dynamic> json) {
    drogoName = json["drogoName"];
    days = json["days"];
    unit = json["unit"];
    usage = json["usage"];
    times = json["times"];
    amount = json["amount"];
    notaBene = json["notaBene"];
  }

   Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['drogoName'] = this.drogoName;
    data['days'] = this.days;
    data['unit'] = this.unit;
    data['usage'] = this.usage;
    data['times'] = this.times;
    data['amount'] = this.amount;
    data['notaBene'] = this.notaBene;
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
    userId = json['userId'];
    dispeningDate = json['dispeningDate'];
    medicalInstituteName = json['medicalInstituteName'];
    doctorName = json['doctorName'];
    final dsList = json['drogoSummaryList'] as List;
    drogoSummaryList = dsList.map((element) => DrogoSummary.fromJson(element)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['dispeningDate'] = this.dispeningDate;
    data['medicalInstituteName'] = this.medicalInstituteName;
    data['doctorName'] = this.doctorName;
    data['drogoSummaryList'] = this.drogoSummaryList;
    return data;
  }
}