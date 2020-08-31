import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/views/weather_present_banner.dart';
import 'package:drogo_libro/ui/views/settings_menu.dart';

class MySettingsView extends StatelessWidget {
  final String title;
  final bool isTabAppeared;

  final GlobalKey<WeatherPresentBannerState> _weatherBannerKey = GlobalKey<WeatherPresentBannerState>();

  MySettingsView({this.title, this.isTabAppeared});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                color: AppColors.mainBackgroundColor.withAlpha(100),
                height: 160,
                width: MediaQuery.of(context).size.width,
                child: WeatherPresentBanner(
                  key: _weatherBannerKey,
                  isTabAppeared: this.isTabAppeared,),
            ),
            Container(
              margin: EdgeInsets.only(top: 160),
              height: MediaQuery.of(context).size.height - 220,
              width: MediaQuery.of(context).size.width,
              child: SettingsMenu(weatherBannerKey: _weatherBannerKey,),
            ),
          ],
        ),
      ),
    );
  }
}
