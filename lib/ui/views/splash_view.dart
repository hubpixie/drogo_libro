import 'package:flutter/material.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';

import 'package:drogo_libro/core/shared/city_util.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  void navigationPage() {
    Navigator.pushNamed(context, ScreenRouteName.login.name ?? '');
  }

  @override
  void initState() {
    // ローマ字地名リストを予め読み込んでおく
    CityUtil().loadRomajiCityCsv();
    // 国名コードリストを予め読み込んでおく
    CityUtil().loadCountryNameCsv();

    // ログイン画面へ遷移する
    Future.delayed(Duration(seconds: 2), () {
      navigationPage();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFFABC5FD),
      body: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: new Image.asset(
                'assets/images/launch.png',
                fit: BoxFit.fill,
              ),
              borderRadius: new BorderRadius.circular(8.0),
            ),
          ),
          new Align(
            alignment: Alignment.center,
            child: new Container(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: new CircularProgressIndicator(
                backgroundColor: Colors.grey[850],
              ),
            ),
          )
        ],
      ),
    );
  }
}
