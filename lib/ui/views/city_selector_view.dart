import 'package:drogo_libro/core/shared/city_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:drogo_libro/core/models/city_info.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

enum _CityInputMode {
  zip,
  cityName, // ローマ字表記
}

class CitySelectorView extends StatefulWidget {
  final String title;
  final CityInfo  cityItem;

  CitySelectorView({this.title, this.cityItem});

  @override
 _CitySelectorViewState createState() => _CitySelectorViewState();
}

class _CitySelectorViewState extends State<CitySelectorView> {
  CityInfo _cityItem;
  TextEditingController _cityNameTextController;
  TextEditingController _countryCdTextController;
  _CityInputMode _cityMode;
  String _countryNameDesc;

  @override
  void initState() {
    _cityItem = CityInfo(
      name: widget.cityItem.name,
      nameDesc: widget.cityItem.nameDesc,
      zip: widget.cityItem.zip,
      countryCode: widget.cityItem.countryCode,
      isFavorite: widget.cityItem.isFavorite
    );
    _countryNameDesc = CityUtil().getCountryNameDesc(countryCode: _cityItem.countryCode);

    _cityNameTextController = TextEditingController(
      text: _cityItem.zip != null && _cityItem.zip.isNotEmpty ? _cityItem.zip : _cityItem.name);
    _countryCdTextController = TextEditingController(text: _cityItem.countryCode);

    _cityMode = _cityItem.zip != null && _cityItem.zip.isNotEmpty ? _CityInputMode.zip : _CityInputMode.cityName;

    super.initState();
  }

  @override
  void dispose() {
    _cityNameTextController.dispose();
    _countryCdTextController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // キーボードを閉じる
        FocusScope.of(context).unfocus();
        Navigator.of(context).pop(
          CityInfo(
            zip:_cityMode == _CityInputMode.zip ? _cityNameTextController.text: '',
            name: _cityMode == _CityInputMode.cityName ? _cityNameTextController.text: '',
            countryCode: _countryCdTextController.text ?? 'JP',
            isFavorite: _cityItem.isFavorite
          )
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          title: Text(widget.title),
        ),
        resizeToAvoidBottomPadding: false,
        body: _buildInputContent(context),
      )
    );
 }

 Widget _buildInputContent(BuildContext context) {
    return  Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10),),
            Radio(
              value: _CityInputMode.zip,
              groupValue: _cityMode,
              onChanged: (_CityInputMode value) {
                FocusScope.of(context).unfocus();
                setState(() {
                  _cityMode = value;
                  _cityNameTextController.text = _cityItem.zip;
                });
              } ,
              
            ),
            Container(
              child: Text('郵便番号', 
                style: TextStyle(fontSize: 16.0,),
              ),
            ),
            Text(' '),
            Container(
              width: MediaQuery.of(context).size.width - 160,
              alignment: Alignment.bottomLeft,
              child: Text('国によってハイフン有無が違う',
                maxLines: null, 
                style: TextStyle(fontSize: 12.0, height: 0.9, color: Colors.black54,),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10),),
            Radio(
              value: _CityInputMode.cityName,
              groupValue: _cityMode,
              onChanged: (_CityInputMode value) {
                FocusScope.of(context).unfocus();
                setState(() {
                  _cityMode = value;
                  _cityNameTextController.text = _cityItem.name;
                });
              } 
            ),
            Container(
              child: Text('地名', 
                style: TextStyle(fontSize: 16.0,),
              ),
            ),
            Text(' '),
            Container(
              width: MediaQuery.of(context).size.width - 180,
              alignment: Alignment.bottomLeft,
              child: Text('ローマ字で入力',
                maxLines: null, 
                style: TextStyle(fontSize: 12.0, height: 0.9, color: Colors.black54),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.all(10),),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              margin: const EdgeInsets.only(left: 10.0),
              child: Text(" ※郵便番号・市/町/村名の入力は日本以外の場合も可能です。いずれも国名コードが必要です。\n例： New York,US",
                maxLines: null,
                style: TextStyle(fontSize: 12.0, height: 1.0, color: Colors.black54),),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20),),
            // 郵便番号 / 市町村
            Container(
              width: MediaQuery.of(context).size.width - 160,
              child: TextFormField(
                keyboardType: _cityMode == _CityInputMode.zip ? TextInputType.numberWithOptions(signed: true) : TextInputType.text,
                inputFormatters: _cityMode == _CityInputMode.zip ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'\d+|\-')),
                ] : null,
                // maxLines: null,
                controller: _cityNameTextController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: _cityMode == _CityInputMode.cityName ? 'Chiyodaーku': '123-3456')
              ),
            ),
            Text(' '),
            // 国名コード
            Container(
              width: 40,
              child: GestureDetector(
                onTap: () => _countryCodeTextDidChange(),
                child: AbsorbPointer(
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    // maxLines: null,
                    controller: _countryCdTextController,
                    maxLength: 2,
                    maxLengthEnforced: false,
                    autofocus: true,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'JP')
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 10),
              width: 110,
              child: Text(_countryNameDesc, 
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14.0
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(" ",
                style: TextStyle(fontSize: 16.0),),
            ),
            Checkbox(
              value: _cityItem.isFavorite,
              onChanged: (bool value) {
                setState(() {
                  _cityItem.isFavorite = value;
                });
              },
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Text('お気に入り登録', style: TextStyle(fontSize: 16.0),),
            ),
          ],
        )
      ],
    );
  }

void _countryCodeTextDidChange() {
    Navigator.pushNamed(context, 
      ScreenRouteName.selectCountry.name, 
      arguments: {'countryCode': _countryCdTextController.text}
    )
    .then((value) async {
      CountryInfo countryValue = value;
      if(countryValue != null) {
        setState(() {
          _countryCdTextController.text = countryValue.code;
          _countryNameDesc = countryValue.jpName;
        });
      }
    });
  }

}