import 'package:drogo_libro/core/shared/string_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/city_info.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/views/weather_present_banner.dart';
import 'package:drogo_libro/ui/widgets/expandable_list_widget.dart';



class SettingsMenu  extends StatefulWidget {
  final   GlobalKey<WeatherPresentBannerState> weatherBannerKey;

  SettingsMenu({this.weatherBannerKey});

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu> {
   PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '1.0.0',
    buildNumber: 'Unknown',
  );
  TemperatureUnit _temprtUnit;

  String _cityNameCd;
  String _zipCd;

  @override
  void initState() {
    // アプリ情報取得インスタンスの初期化
    _initPackageInfo();

    // アプリ設定取得
    _readPrefsData();

    // その他の初期化
    _temprtUnit = TemperatureUnit.celsius;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
       // child: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              // 天気表示設定
              _buildSectionHeader(context, headTitle: '天気表示設定'),
              _buildRowInSection(context, '温度単位(°F)', 
                rowBorderDecoration: _buildBoxDecoration(start: true),
                children: <Widget>[
                  Spacer(flex: 2,),
                  Switch(
                    value: _temprtUnit == TemperatureUnit.fahrenheit,
                    onChanged: (value) {
                      setState(() {
                        _savePrefsData(
                          temprtUnit: value ? TemperatureUnit.fahrenheit : TemperatureUnit.celsius);
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green, 
                  ),
                ],
              ),
              _buildDivider(),
              _buildRowInSection(context, '地域変更', 
                rowBorderDecoration: _buildBoxDecoration(end: true),
                children: <Widget>[
                  _buildRowIndicator(),
                ],
                onTap: () async {
                  await _readPrefsData();
                  Navigator.pushNamed(context, 
                    ScreenRouteName.selectCity.name, 
                    arguments: CityInfo(
                      name: _cityNameCd != null && _cityNameCd.isNotEmpty ? _cityNameCd.split(',').first: 'Tokyo',
                      zip: _zipCd != null && _zipCd.isNotEmpty ? _zipCd.split(',').first: '',
                      countryCode: () {
                        if(_cityNameCd != null && _cityNameCd.isNotEmpty) return  _cityNameCd.split(',').last;
                        else if (_zipCd != null && _zipCd.isNotEmpty) return _zipCd.split(',').last;
                        else return 'JP';
                      }()) )
                  .then((value) async {
                    List<String> cityValue = value;
                    if(cityValue != null && cityValue.length > 1) {
                      _savePrefsData(cityValue: cityValue);
                    }
                  });
                },
              ),
              // おくすり手帳関連
              _buildSectionHeader(context, headTitle: 'おくすり手帳関連'),
              _buildRowInSection(context, 'くすりのしおり', 
                rowBorderDecoration: _buildBoxDecoration(start: true),
                children: <Widget>[
                  _buildRowIndicator(),
                ],
                onTap: () => setState(() {
                    _launchInBrowser('https://www.rad-ar.or.jp/siori/kensaku.cgi');
                  }),
              ),
              _buildDivider(),
              _buildRowInSection(context, 'プロフィール入力', 
                rowBorderDecoration: _buildBoxDecoration(end: true),
              ),
              // アプリ情報
              _buildSectionHeader(context, headTitle: 'アプリ情報'),
              _buildRowInSection(context, 'バージョン', 
                rowBorderDecoration: _buildBoxDecoration(start: true),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: Text( _packageInfo.version,
                    ),
                  ),
                ],
              ),
              _buildDivider(),
              _buildRowInSection(context, '利用規約', ),
              _buildDivider(),
              _buildExpandableRowInSection('セキュリティ設定', 2,
                children: <Widget>[
                  _buildDivider(),
                  _buildRowInSection(context, '  パスコード表示設定', 
                    children: <Widget>[
                      _buildRowIndicator(),
                    ],
                    onTap: () {
                      Navigator.pushNamed(context, 
                        ScreenRouteName.changePasscodeSettings.name);
                     }
                  ),
                  _buildDivider(),
                  _buildRowInSection(context, '  パスコード変更', 
                    children: <Widget>[
                      _buildRowIndicator(),
                    ],
                    onTap: () async {
                      await StringUtil().readEncrptedData();
                      // パスコード設定ずみの場合、パスコード確認を行う
                      String pcd = StringUtil().encryptedPcode ?? '';
                      if(pcd.isNotEmpty) {
                        Navigator.pushNamed(context, ScreenRouteName.passcode.name).then((value) {
                          final bool auth = value ?? false;
                          if(auth) {
                            Navigator.pushNamed(context, ScreenRouteName.editPasscode.name, arguments: {'pcd': pcd});
                          }
                        });
                      } else {
                      // パスコード未設定の場合、直接パスコード設定画面へいく
                        Navigator.pushNamed(context, ScreenRouteName.editPasscode.name);
                      }
                    }
                  ),                    
                ]
              ),
              _buildDivider(),
              _buildRowInSection(context, 'フィードバック', 
                rowBorderDecoration: _buildBoxDecoration(end: true),
                children: <Widget>[
                _buildRowIndicator(),
                ],
                onTap: () => launch(_feedbackrEmail.toString()),
              ),
            ],
       //   ),
      ));
    }


  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
  
  Widget _buildSectionHeader(BuildContext context, {String headTitle}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        headTitle,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.blueGrey,
      height: 1,
    );
  }

  Widget _buildRowIndicator() {
    return Container(
        width: 15,
        height: 15,
        margin: EdgeInsets.only(right: 10),
        alignment: Alignment.bottomCenter,
        child: Icon(Icons.arrow_forward_ios, 
          color: Colors.black26, size: 15.0),
      );
  }

  Widget _buildRowTitleWidget(String title) {
    return Text(
        title,
        style: TextStyle(
            color: Colors.blueGrey, fontSize: 16.0),
      );
  }

  Widget _buildRowContent(BuildContext context, String title,
    {List<Widget> children,
    void Function() onTap}) {
    // row content
    List<Widget> list = <Widget>[
    ];
    Widget titleWidget = _buildRowTitleWidget(title);

    list.add(titleWidget);
    if(children != null) {
      list.addAll(children);
    }

    // row tap
    Widget rowContent = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list
      );
    if (onTap != null) {
      return InkWell(
        child: rowContent,
        onTap: onTap,);
    } else {
      return rowContent;
    }
  }

  Widget _buildRowInSection(
    BuildContext context, String title,
    {List<Widget> children,
    BoxDecoration rowBorderDecoration,
    void Function() onTap}) {
    return Container(
      decoration: rowBorderDecoration,
      height: 50,
      color: rowBorderDecoration == null ? AppColors.mainBackgroundColor.withAlpha(100) : null,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: _buildRowContent(context, title, 
          children: children, 
          onTap: onTap),
    );
  }

  Widget _buildExpandableRowInSection(
    String title,
    int validItemCount,
    {List<Widget> children,
    BoxDecoration rowBorderDecoration}) {
    return ExpandableListWidget(
      title: _buildRowTitleWidget(title),
      borderDecoration: rowBorderDecoration,
      validItemCount: validItemCount,
      rowHeight: 50.0,
      headerColor: Colors.black26,
      headerBackColor: AppColors.mainBackgroundColor.withAlpha(100),
      listItems: children,
    );
  }

  BoxDecoration _buildBoxDecoration({bool start = false, bool end = false}) {
    if (!start && !end) {
      throw Exception('BoxDecoration null error. start and end must not be null.');
    }
    return BoxDecoration(
        borderRadius: () {
          if(start && end) return BorderRadius.all(Radius.circular(8));
          else if(start) return BorderRadius.only(
            topLeft: Radius.circular(8), 
            topRight: Radius.circular(8)
          );
          else return BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)
          );
        }(),
        color: AppColors.mainBackgroundColor.withAlpha(100),
      );
  }

  Future<void> _readPrefsData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      String zipCd = (prefs.getString('zipCd') ?? '');
      if(zipCd != _zipCd) _zipCd = zipCd;

      String cityNameCd = (prefs.getString('cityNameCd') ?? 'Tokyo,JP');
      if(cityNameCd != _cityNameCd) _cityNameCd = cityNameCd;

      TemperatureUnit temprtUnit = (prefs.getInt('temprtUnit') != null ? 
        TemperatureUnit.values[prefs.getInt('temprtUnit')] : TemperatureUnit.celsius);
      if(temprtUnit != _temprtUnit) _temprtUnit = temprtUnit;
    });
  }

  Future<void>  _savePrefsData({List<String> cityValue, TemperatureUnit temprtUnit}) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (cityValue != null) {
        prefs.setString('zipCd', cityValue[0]);
        prefs.setString('cityNameCd', cityValue[1]);
        _zipCd = cityValue[0];
        _cityNameCd = cityValue[1];
        // 画面上部のバナーを最新表示する
        if(widget.weatherBannerKey.currentState != null) {
          widget.weatherBannerKey.currentState.reloadData(cityNameCd: _cityNameCd, zipCd: _zipCd);
        } 
      } else if (temprtUnit != null) {
        prefs.setInt('temprtUnit', temprtUnit.index);
        _temprtUnit = temprtUnit;
        // 画面上部のバナーを最新表示する
        if(widget.weatherBannerKey.currentState != null) {
          widget.weatherBannerKey.currentState.reloadData(temprtUnit: _temprtUnit);
        } 
      }
    });
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

 final Uri _feedbackrEmail = Uri(
  scheme: 'mailto',
  path: 'edor.pixie.work@gmail.com',
  queryParameters: {
    'subject': 'アプリのフィードバック',
    "body": '''お客様へ\n
    　このアプリのフィードバックがあるので、本メールにて送付いたします。\n
    　（本文）\n
    以上、よろしくお願い致します''',
  }
);
}