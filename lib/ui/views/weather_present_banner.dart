import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/viewmodels/weather_view_model.dart';
import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/shared/city_util.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';
import 'package:drogo_libro/ui/widgets/weather_top_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_content_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_function_cell.dart';

import 'base_view.dart';

typedef CellEditingDelegate = void Function(dynamic temprtUnit);

class WeatherPresentBanner extends StatefulWidget {
  final bool? isTabAppeared;
  final CellEditingDelegate? onCellEditing;

  WeatherPresentBanner({Key? key, this.isTabAppeared, this.onCellEditing})
      : super(key: key);

  @override
  WeatherPresentBannerState createState() => WeatherPresentBannerState();
}

class WeatherPresentBannerState extends State<WeatherPresentBanner>
    with WidgetsBindingObserver {
  late CityInfo _cityParam;
  late GlobalKey<BaseViewState> _reloaderKey;
  bool _isTabFirstAppeared = true;
  TemperatureUnit _temprtUnit = TemperatureUnit.celsius;

  @override
  void initState() {
    _reloaderKey = GlobalKey<BaseViewState>();
    _cityParam = CityInfo();
    _readPrefsData();

    // set first appearing status after 3 seconds.
    Future.delayed(Duration(seconds: 3), () {
      _isTabFirstAppeared = false;
    });

    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App call resume if background end.
    if (state == AppLifecycleState.resumed && (widget.isTabAppeared ?? false)) {
      // reload this banner due to parameter changed.
      this.reloadData();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isTabAppeared ?? false) {
      this.reloadData();
    }

    return (_cityParam.zip.isEmpty && _cityParam.name.isEmpty)
        ? Center(child: CircularProgressIndicator())
        : BaseView<WeatherViewModel>(
            key: _reloaderKey,
            onModelReady: (viewModel) =>
                viewModel.getWeatherData(cityParam: _cityParam),
            builder: (context, viewModel, child) {
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                    WeatherTopCell(
                      itemValue: viewModel.fetchedWeatherInfo?.result,
                    ),
                    UIHelper.verticalSpaceSmallest(),
                    WeatherContentCell(
                        itemValue: viewModel.fetchedWeatherInfo?.result,
                        temprtUnit: _temprtUnit,
                        onCellEditing: () {
                          Navigator.pushNamed(
                              context, ScreenRouteName.selectCity.name ?? '',
                              arguments: {'city': _cityParam}).then((value) {
                            CityInfo? cityValue = value as CityInfo?;
                            if (cityValue != null) {
                              _savePrefsData(cityValue: cityValue);
                            }
                          });
                        }),
                    UIHelper.verticalSpaceSmallest(),
                    WeatherFunctionCell(
                        itemValue: viewModel.fetchedWeatherInfo?.result,
                        temprtUnit: _temprtUnit,
                        onPresentWeeklyForecast: () {
                          Navigator.pushNamed(context,
                              ScreenRouteName.presentWeeklyForecast.name ?? '',
                              arguments: {
                                'city': _cityParam,
                                'temprtUnit': _temprtUnit
                              }).then((value) {
                            Map<String, dynamic>? ret =
                                value as Map<String, dynamic>?;
                            CityInfo? cityValue = ret?['city'];
                            TemperatureUnit tempertUnit = ret?['temprtUnit'];

                            setState(() {
                              if (cityValue?.zip != _cityParam.zip ||
                                  cityValue?.name != _cityParam.name) {
                                _cityParam.zip = cityValue?.zip ?? '';
                                _cityParam.name = cityValue?.name ?? '';
                                _cityParam.nameDesc = cityValue?.nameDesc ?? '';
                                _cityParam.countryCode =
                                    cityValue?.countryCode ?? '';
                                _cityParam.isFavorite =
                                    cityValue?.isFavorite ?? false;
                              }
                              if (_temprtUnit != tempertUnit) {
                                _temprtUnit = tempertUnit;
                                if (widget.onCellEditing != null) {
                                  widget.onCellEditing?.call(_temprtUnit);
                                }
                              }
                            });
                          });
                        }),
                  ],
                );
              }
            });
  }

  /// データリロード処理
  void reloadData({CityInfo? cityParam, TemperatureUnit? temprtUnit}) {
    setState(() {
      if (cityParam != null) {
        _cityParam.zip = cityParam.zip;
        _cityParam.name = cityParam.name;
        _cityParam.nameDesc = cityParam.nameDesc;
        _cityParam.countryCode = cityParam.countryCode;
        _cityParam.isFavorite = cityParam.isFavorite;
      }

      if (temprtUnit != null) {
        _temprtUnit = TemperatureUnit.values[temprtUnit.index];
      }
      // reload this banner due to parameter changed.
      if (_reloaderKey.currentState != null && !_isTabFirstAppeared) {
        _reloaderKey.currentState?.reload();
      }
    });
  }

  Widget _buildMessageArea(
      {required BuildContext context,
      String? message,
      bool? needsReload = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        UIHelper.verticalSpaceMedium(),
        Container(
            alignment: Alignment.center,
            child: Text(
              message ?? '',
            )),
        needsReload ?? false
            ? UIHelper.verticalSpaceSmallest()
            : UIHelper.verticalSpaceSmall(),
        needsReload ?? false
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
    );
  }

  Future<void> _readPrefsData() async {
    final prefs = await SharedPreferences.getInstance();
    await CityUtil().readCityInfoFromPref(isDefault: true);

    setState(() {
      // CityInfo
      _cityParam.zip = CityUtil().savedCity?.zip ?? '';
      _cityParam.name = CityUtil().savedCity?.name ?? '';
      _cityParam.nameDesc = CityUtil().savedCity?.nameDesc ?? '';
      _cityParam.countryCode = CityUtil().savedCity?.countryCode ?? '';
      _cityParam.isFavorite = CityUtil().savedCity?.isFavorite ?? false;

      // Tempreture Unit
      _temprtUnit = (prefs.getInt('temprtUnit') != null
          ? TemperatureUnit.values[prefs.getInt('temprtUnit') ?? 0]
          : TemperatureUnit.celsius);
    });
  }

  Future<void> _savePrefsData({CityInfo? cityValue}) async {
    if (cityValue == null) {
      return;
    }
    setState(() {
      _cityParam.zip = cityValue.zip;
      _cityParam.name = cityValue.name;
      _cityParam.nameDesc = cityValue.nameDesc;
      _cityParam.countryCode = cityValue.countryCode;
      _cityParam.isFavorite = cityValue.isFavorite;
    });
  }
}
