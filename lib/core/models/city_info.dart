import 'package:drogo_libro/core/shared/city_util.dart';

class CityInfo {
  int id;
  String zip;
  String langCode;
  String name; //English name
  String nameDesc; // Name description with current locale.
  String countryCode;
  int timezone;
  bool isFavorite;

  CityInfo({this.id, this.zip = '', this.langCode = 'ja', this.name='Tokyo', this.nameDesc, this.countryCode = 'JP', this.timezone, this.isFavorite = false});

  CityInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zip = json['zip'];
    langCode = json['lang_code'];
    name = json['name'];
    nameDesc = json['name_desc'];
    countryCode = json['country_code'];
    timezone = json['timezone'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zip'] = this.zip;
    data['lang_code'] = this.langCode;
    data['name'] = this.name;
    data['name_desc'] = this.nameDesc == null || this.nameDesc.isEmpty ? 
      CityUtil().getCityNameDesc(name: this.name) : this.nameDesc;
    data['country_code'] = this.countryCode;
    data['timezone'] = this.timezone;
    data['is_favorite'] = this.isFavorite;

    return data;
  }
}

class CountryInfo {
  int id;
  String code;
  String enName; //English name
  String jpName;
  String continent; //i.e, Asia, America, Africa.

  CountryInfo({this.id, this.code, this.enName, this.jpName, this.continent});
}