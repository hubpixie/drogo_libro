import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/viewmodels/weather_view_model.dart';
import 'package:drogo_libro/core/models/city_info.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';
import 'package:drogo_libro/ui/widgets/forecast_summary_cell.dart';
import 'package:drogo_libro/ui/widgets/hourly_forecast_cell.dart';
import 'package:drogo_libro/ui/widgets/weekly_forecast_cell.dart';

import 'base_view.dart';

class WeeklyForecastView extends StatefulWidget {
  final String title;
  final CityInfo? cityItem;
  final TemperatureUnit? temprtUnit;

  WeeklyForecastView({required this.title, this.cityItem, this.temprtUnit});

  _WeeklyForecastViewState createState() => _WeeklyForecastViewState();
}

class _WeeklyForecastViewState extends State<WeeklyForecastView> {
  late CityInfo _cityItem;
  late TemperatureUnit _temprtUnit;

  @override
  void initState() {
    _cityItem = widget.cityItem ?? CityInfo();
    _temprtUnit = widget.temprtUnit ?? TemperatureUnit.celsius;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            'city': CityInfo(
                zip: _cityItem.zip,
                name: _cityItem.name,
                countryCode: _cityItem.countryCode),
            'temprtUnit': _temprtUnit
          });
          return Future.value(false);
        },
        child: BaseView<WeatherViewModel>(
          onModelReady: (viewModel) => viewModel.getWeatherData(
              cityParam: _cityItem, forecastEnabled: true),
          builder: (context, viewModel, child) => Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appBarBackgroundColor,
              title: Text(widget.title),
              centerTitle: Platform.isAndroid ? false : true,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        BaseView.of(context).reload();
                      });
                    },
                    icon: Icon(Icons.refresh),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                              ScreenRouteName.selectCityFavorite.name ?? '')
                          .then((value) async {
                        CityInfo? cityValue2 = value as CityInfo?;
                        if (cityValue2 != null) {
                          await _savePrefsData(cityValue: cityValue2);
                          BaseView.of(context).reload();
                        }
                      });
                    },
                    icon: Icon(Icons.view_list),
                  ),
                ),
              ],
            ),
            body: () {
              // 検索中のインジケーターを表示する
              if (viewModel.state == ViewState.Busy) {
                return Center(child: CircularProgressIndicator());
              }
              // データないときのメッセージを表示する
              if (viewModel.fetchedWeatherInfo?.isNotFound ?? true) {
                return _buildMessageArea(
                    context: context, message: '該当の天気情報がありません。');
              } else if (viewModel.fetchedWeatherInfo?.hasError ?? false) {
                print('error stack = ${viewModel.fetchedWeatherInfo?.message}');
                return _buildMessageArea(
                    context: context,
                    message:
                        '天気情報取得時にエラーが発生しました。\n(error:${viewModel.fetchedWeatherInfo?.errorCode})',
                    needsReload: true);
              } else {
                return _buildBody(context, viewModel);
              }
            }(),
          ),
        ));
  }

  Widget _buildBody(BuildContext context, WeatherViewModel viewModel) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            color: AppColors.mainBackgroundColor.withAlpha(100),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: ForecastSummaryCell(
              itemValue: viewModel.fetchedWeatherInfo?.result,
              temprtUnit: _temprtUnit,
              onCellEditing: (cityChanged, temprtUnit) {
                if (cityChanged) {
                  Navigator.pushNamed(
                      context, ScreenRouteName.selectCity.name ?? '',
                      arguments: {'city': _cityItem}).then((value) async {
                    CityInfo? cityValue2 = value as CityInfo?;
                    if (cityValue2 != null) {
                      await _savePrefsData(cityValue: cityValue2);
                      BaseView.of(context).reload();
                    }
                  });
                } else if (temprtUnit != null) {
                  _savePrefsData(temprtUnit: temprtUnit);
                }
              },
            ),
          ),
          Container(
            color: AppColors.mainBackgroundColor.withAlpha(120),
            margin: EdgeInsets.only(top: 150),
            height: 140,
            width: MediaQuery.of(context).size.width,
            child: HourlyForecastCell(
              hourlyForecastValue: viewModel.hourlyForecastData,
              temprtUnit: _temprtUnit,
            ),
          ),
          Container(
            color: AppColors.mainBackgroundColor.withAlpha(140),
            margin: EdgeInsets.only(top: 290),
            height: MediaQuery.of(context).size.height - 290,
            width: MediaQuery.of(context).size.width,
            child: WeeklyForecastCell(
              weeklyForecastValue: viewModel.weeklyForecastData,
              temprtUnit: _temprtUnit,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageArea(
      {required BuildContext context,
      String message = '',
      bool needsReload = false}) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        UIHelper.verticalSpaceMedium(),
        Container(
            alignment: Alignment.center,
            child: Text(
              message,
            )),
        needsReload
            ? UIHelper.verticalSpaceSmallest()
            : UIHelper.verticalSpaceSmall(),
        needsReload
            ? Container(
                height: 20.0,
                child: TextButton(
                    child: const Text(
                      '再表示',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    onPressed: () {
                      setState(() {
                        // 再表示する
                        BaseView.of(context).reload();
                      });
                    }))
            : UIHelper.verticalSpaceSmallest(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 20.0,
          child: TextButton(
              child: const Text(
                '地域変更',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                Navigator.pushNamed(
                    context, ScreenRouteName.selectCity.name ?? '', arguments: {
                  'city': CityInfo(name: 'Tokyo', countryCode: 'JP')
                }).then((value) async {
                  CityInfo? cityValue = value as CityInfo?;
                  if (cityValue != null) {
                    _savePrefsData(cityValue: cityValue);
                  }
                });
              }),
        ),
      ],
    ));
  }

  Future<void> _savePrefsData(
      {CityInfo? cityValue, TemperatureUnit? temprtUnit}) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (cityValue != null) {
        _cityItem.zip = cityValue.zip;
        _cityItem.name = cityValue.name;
        _cityItem.nameDesc = cityValue.nameDesc;
        _cityItem.countryCode = cityValue.countryCode;
        _cityItem.isFavorite = cityValue.isFavorite;
      }
      if (temprtUnit != null) {
        prefs.setInt('temprtUnit', temprtUnit.index);
        _temprtUnit = temprtUnit;
      }
    });
  }
}
