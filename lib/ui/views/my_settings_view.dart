import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/views/weather_present_banner.dart';
import 'package:drogo_libro/ui/views/settings_menu.dart';


class MySettingsView extends StatefulWidget {
  final String title;
  final bool isTabAppeared;

  MySettingsView({this.title, this.isTabAppeared});
  @override
  _MySettingsViewState createState() => _MySettingsViewState();
}

class _MySettingsViewState extends State<MySettingsView> {
  final GlobalKey<WeatherPresentBannerState> _weatherBannerKey = GlobalKey<WeatherPresentBannerState>();
  TemperatureUnit _temprtUnit;

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
                  isTabAppeared: widget.isTabAppeared,
                  onCellEditing: (value) {
                    TemperatureUnit temprtUnit = value;
                    if(temprtUnit != null) {
                      setState(() {
                        _temprtUnit = temprtUnit;
                      });
                    }
                  },
                ),
            ),
            Container(
              margin: EdgeInsets.only(top: 160),
              height: MediaQuery.of(context).size.height - 220,
              width: MediaQuery.of(context).size.width,
              child: SettingsMenu(
                weatherBannerKey: _weatherBannerKey,
                temprtUnit: _temprtUnit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
