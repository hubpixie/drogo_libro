import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/views/weather_present_banner.dart';
import 'package:drogo_libro/ui/widgets/settings_menu_cell.dart';

class MySettingsView extends StatelessWidget {
  final String title;
  MySettingsView({this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                color: AppColors.mainBackgroundColor,
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: WeatherPresentBanner(),
              ),
              top: 0,
            ),
            Positioned(
              child: Container(
                child: SettingsMenuCell(),
              ),
              top: 120,
            ),
            // Positioned(
            //   child: Container(
            //     color: Colors.black38,
            //     height: 60,
            //     width: MediaQuery.of(context).size.width,
            //     child: Text('Footer'),
            //   ),
            //   bottom: 0,
            // ),
          ],
        ),
      ),
    );
  }
}
