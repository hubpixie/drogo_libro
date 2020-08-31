import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:drogo_libro/core/models/city_info.dart';

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
  String _cityName;
  String _zip;
  String _countryCd;
  TextEditingController _cityNameTextController;
  TextEditingController _countryCdTextController;
  _CityInputMode _cityMode;

  @override
  void initState() {
    setState(() {
      _cityName = widget.cityItem.name;
      _zip = widget.cityItem.zip;
      _countryCd = widget.cityItem.countryCode;

      _cityNameTextController = TextEditingController(
        text: _zip != null && _zip.isNotEmpty ? _zip : _cityName);
      _countryCdTextController = TextEditingController(text: _countryCd);

      _cityMode = _zip != null && _zip.isNotEmpty ? _CityInputMode.zip : _CityInputMode.cityName;
    });
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
        Navigator.of(context).pop([
          _cityMode == _CityInputMode.zip ? 
            '${_cityNameTextController.text},${_countryCdTextController.text ?? ''}' : '',
          _cityMode == _CityInputMode.cityName ?
            '${_cityNameTextController.text},${_countryCdTextController.text ?? ''}' : '',
        ]);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          title: Text(widget.title),
        ),
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
                  _cityNameTextController.text = _zip;
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
                  _cityNameTextController.text = _cityName;
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
          ],
        ),
        Row(
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.only(right: 0),
              child: FlatButton(
                onPressed: () => setState(() {
                _launchInBrowser('http://www.kc.tsukuba.ac.jp/ulismeta/metadata/standard/cntry_code.html');
                }),
                child: const Text('国名コード一覧', 
                  style: TextStyle(color: Colors.blueAccent),),
              )
            ,),
          ],
        ),
      ],
    );
  }

 Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}