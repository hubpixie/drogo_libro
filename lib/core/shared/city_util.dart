import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/core/models/city_info.dart';

class CityUtil {
  static final CityUtil _instance = CityUtil._internal();
  factory CityUtil() {
    return _instance;
  }
  CityUtil._internal();

  int _selectedFavoriteIndex;
  CityInfo _savedCity;
  List<CityInfo> _cityFavoriteList;
  List<CityInfo> _romajiCityList;
  List<CountryInfo> _countryNameList;

  int get selectedFavoriteIndex => _selectedFavoriteIndex;
  CityInfo get savedCity => _savedCity;
  List<CityInfo> get cityFavoriteList => _cityFavoriteList;
  List<CityInfo> get romajiCityList => _romajiCityList;
  List<CountryInfo> get countryNameList => _countryNameList;

  String getCityNameDesc({@required String name}) {
    CityInfo cinfo;
    try {
      cinfo =  _romajiCityList.firstWhere((element) => element.name == name);
    } catch(error) {
    }
    return cinfo != null ? cinfo.nameDesc.replaceAll(RegExp(r'都|府|県|市'), '') : name;
  }

  String getCountryNameDesc({@required String countryCode}) {
    CountryInfo cinfo;
    try {
      cinfo =  _countryNameList.firstWhere((element) => element.code == countryCode);
    } catch(error) {
    }
    return cinfo != null ? cinfo.jpName : countryCode;
  }

  Future<void>  readCityInfoFromPref({bool isDefault}) async {
    final prefs = await SharedPreferences.getInstance();
    // 保存したCityInfoを取得する
    int selectedCityIdx = prefs.getInt('selectedCity') ?? -1;
    if(selectedCityIdx < 0) {
      String cityjson = prefs.getString("city");
      if (cityjson != null) {
        final parsed = json.decode(cityjson);
        _savedCity = CityInfo.fromJson(parsed);
      }
    }else{
      String citiesjson = prefs.getString("cityFavoriteslist");
      if (citiesjson != null) {
        var parsed = json.decode(citiesjson) as List<dynamic>;
        _cityFavoriteList = parsed.map((element) => CityInfo.fromJson(element)).toList();
        _savedCity = selectedCityIdx < _cityFavoriteList.length ? _cityFavoriteList[selectedCityIdx] : _cityFavoriteList[0];
      }
    }
    _savedCity = (_savedCity == null && (isDefault ?? false)) ? CityInfo() : _savedCity;
  }

  Future<void>  readFavoriteData() async {
    final prefs = await SharedPreferences.getInstance();

    // 保存済みのリストを取得
    String citiesjson = prefs.getString("cityFavoriteslist");
    if (citiesjson != null) {
      var parsed = json.decode(citiesjson) as List<dynamic>;
      _cityFavoriteList = parsed.isNotEmpty ? parsed.map((element) => CityInfo.fromJson(element)).toList() : [];
    } else {
      _cityFavoriteList = [];
    }
    // 選択したインデックスを取得
    _selectedFavoriteIndex = prefs.getInt('selectedCity') ?? -1;
  }

  Future<void> saveCityInfoIntoPref({CityInfo cityValue}) async {
    final prefs = await SharedPreferences.getInstance();
    if(cityValue != null ) {

      // 指定したcityInfoを保存する
      if(!cityValue.isFavorite) {
        final savedJson = cityValue.toJson();
        prefs.setString("city", json.encode(savedJson));

        // パラメータをcityValueカレントCityにセット
        prefs.setInt("selectedCity", -1);
        return;
      }

      // 保存済みのリストを取得
      String citiesjson = prefs.getString("cityFavoriteslist");
      List<CityInfo> cityList;
      int foundIdx;

      if(citiesjson != null) {
        var parsed = json.decode(citiesjson) as List<dynamic>;
        cityList = parsed.map((element) => CityInfo.fromJson(element)).toList();
        foundIdx = cityList.indexWhere((element) =>
         (((element.name.isNotEmpty && element.name == cityValue.name)
          || (element.zip.isNotEmpty && element.zip == cityValue.zip))
          && (element.countryCode == cityValue.countryCode))
        );
      } else {
        cityList = [];
      }
      
      // 見つからない場合
      if((foundIdx ?? -1) < 0) {
        cityList.add(cityValue);
      }else{
        // 見つかった場合
        cityList[foundIdx] = cityValue;
      } 

      // 追加後のCityListをJson化し、保存する
      final savedJson = cityList.map((element) => element.toJson()).toList();
      prefs.setString("cityFavoriteslist", json.encode(savedJson));

      // パラメータをcityValueカレントCityにセット
      _selectedFavoriteIndex = (foundIdx ?? -1) < 0 ? cityList.length - 1 : foundIdx;
      prefs.setInt("selectedCity",  _selectedFavoriteIndex);
    } else {
        // 追加後のCityListをJson化し、保存する
        final savedJson = _cityFavoriteList.length > 0 ? 
          _cityFavoriteList.map((element) => element.toJson()).toList() :
          [];
        prefs.setString("cityFavoriteslist", json.encode(savedJson));
    }
  }

  Future<void> saveCityListIntoPref({List<CityInfo> cityList, CityInfo selectedItem}) async {
    final prefs = await SharedPreferences.getInstance();
    if(cityList != null ) {

      // 追加後のCityListをJson化し、保存する
      final savedJson = cityList.map((element) => element.toJson()).toList();
      prefs.setString("cityFavoriteslist", json.encode(savedJson));
      _cityFavoriteList = cityList;
      
      // パラメータをcityValueカレントCityにセット
      _selectedFavoriteIndex = cityList.indexWhere((element) =>
         (((element.name.isNotEmpty && element.name == selectedItem.name)
          || (element.zip.isNotEmpty && element.zip == selectedItem.zip))
          && (element.countryCode == selectedItem.countryCode))
        );
      prefs.setInt("selectedCity",  _selectedFavoriteIndex);
    }
  }

  Future<void>  saveFavoriteIndex({int index}) async {
    final prefs = await SharedPreferences.getInstance();
    if(index != null ) {
      // パラメータをcityValueカレントCityにセット
      prefs.setInt("selectedCity", index);
    }
  }

  Future<void> loadRomajiCityCsv() async {
    final myData = await rootBundle.loadString('assets/csv/romaji-chimei-all-u.csv');
    List<List<dynamic>> list = CsvToListConverter().convert(myData, fieldDelimiter: ',', eol: '\n');
      _romajiCityList = list.map((element) => CityInfo(
        name: element[3],
        nameDesc: element[0],
      )).toList();

  }

  Future<void> loadCountryNameCsv() async {
    final myData = await rootBundle.loadString('assets/csv/country_name_list.csv');
    List<List<dynamic>> list = CsvToListConverter().convert(myData, 
      fieldDelimiter: ',',
      eol: '\r\n').sublist(1);
      _countryNameList = list.map((element) => CountryInfo(
        id: int.parse(element[0].toString().trim()),
        code: element[1],
        enName: element[2],
        jpName: element[3],
        continent: element[4],
      )).toList();
  }

}