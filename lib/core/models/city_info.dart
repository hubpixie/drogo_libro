class CityInfo {
  int id;
  String zip;
  String langCode;
  String name; //English name
  String nameDesc; // Name description with current locale.
  String countryCode;

  CityInfo({this.id, this.zip, this.langCode = 'ja', this.name, this.nameDesc, this.countryCode = 'JP'});
}