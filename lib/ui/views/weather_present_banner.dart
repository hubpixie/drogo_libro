import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/viewmodels/weather_view_model.dart';
import 'package:drogo_libro/core/models/city_info.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';
import 'package:drogo_libro/ui/widgets/weather_top_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_content_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_function_cell.dart';

import 'base_view.dart';

class WeatherPresentBanner  extends StatefulWidget {
  final bool isTabAppeared;

  WeatherPresentBanner({Key key, this.isTabAppeared}) : super(key: key);

  @override
  WeatherPresentBannerState createState() => WeatherPresentBannerState();
}

class WeatherPresentBannerState extends State<WeatherPresentBanner> with WidgetsBindingObserver {
  String _cityNameCd;
  String _zipCd;
  GlobalKey<BaseViewState> _reloaderKey;
  bool _isTabFirstAppeared = true;
  TemperatureUnit _temprtUnit;

  @override
  void initState() {
    _reloaderKey = GlobalKey<BaseViewState>();
    _readPrefsData();

    // set first appearing status after 3 seconds.
    Future.delayed(Duration(seconds: 3), () {
      _isTabFirstAppeared = false;
    }); 

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _reloaderKey = null;

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App call resume if background end.
    if(state == AppLifecycleState.resumed && widget.isTabAppeared){
      // reload this banner due to parameter changed.
      this.reloadData();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isTabAppeared) {
      this.reloadData();
    }

    return ( _cityNameCd == null || _cityNameCd.isEmpty) && (_zipCd == null || _zipCd.isEmpty) ?
      Center(child: CircularProgressIndicator()) : 
      BaseView<WeatherViewModel>(
        key: _reloaderKey,
        onModelReady: (viewModel) => viewModel.getWeatherData(cityNameCd: _cityNameCd, zipCd: _zipCd),
        builder: (context, viewModel, child) {
          // 検索中のインジケーターを表示する
          if (viewModel.state == ViewState.Busy) {
            return Center(child: CircularProgressIndicator());
          }
          // データないときのメッセージを表示する
          if (viewModel.fetchedWeatherInfo.isNotFound) {
            return _buildMessageArea(
              context: context,
              message: '該当の天気情報がありません。');
          } else if (viewModel.fetchedWeatherInfo.hasError) {
            print('error stack = ${viewModel.fetchedWeatherInfo.message}');
            return _buildMessageArea(
              context: context,
              message: '天気情報取得時にエラーが発生しました。\n(error:${viewModel.fetchedWeatherInfo.errorCode})',
              needsReload: true);
          } else {
            return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              UIHelper.verticalSpaceSmall(),
              WeatherTopCell(itemValue: viewModel.fetchedWeatherInfo.result,),
              UIHelper.verticalSpaceSmallest(),
              WeatherContentCell(
                itemValue: viewModel.fetchedWeatherInfo.result,
                temprtUnit: _temprtUnit,
                onCellEditing: (arguments) {
                  Navigator.pushNamed(context, ScreenRouteName.selectCity.name, arguments: arguments)
                  .then((value) {
                    List<String> cityValue = value;
                    if(cityValue != null && cityValue.length > 1 ) {
                      _savePrefsData(cityValue: cityValue);
                    }
                  });
              }),
              UIHelper.verticalSpaceSmallest(),
              WeatherFunctionCell(
                itemValue: viewModel.fetchedWeatherInfo.result,
                temprtUnit: _temprtUnit,
              ),
            ],);
          }
        }
      );
  }

/// データリロード処理
  void reloadData({String cityNameCd, String zipCd, TemperatureUnit temprtUnit}) {
    setState(() {
      if(cityNameCd != null) {
        _cityNameCd = cityNameCd;
      }
      if(zipCd != null) {
        _zipCd = zipCd;
      }
      if(temprtUnit != null) {
        _temprtUnit = temprtUnit;
      }
      // reload this banner due to parameter changed.
      if (_reloaderKey.currentState != null && !_isTabFirstAppeared) {
        _reloaderKey.currentState.reload();
      }
    });
  }

  Widget _buildMessageArea({BuildContext context, String message, bool needsReload = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        UIHelper.verticalSpaceMedium(),
        Container(
          alignment: Alignment.center,
          child: Text(message, )
        ),
        needsReload ? UIHelper.verticalSpaceSmallest() : UIHelper.verticalSpaceSmall(),
        needsReload ? Container(
          height: 20.0,
          child: FlatButton(
            child: const Text('再表示', 
              style: TextStyle(color: Colors.blueAccent),),
            onPressed: () {
              setState(() {
                // 再表示する
                BaseView.of(context).reload();
              });
            }
          )
        ) : UIHelper.verticalSpaceSmallest(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0),
          height: 20.0,
          child: FlatButton(
            child: const Text('地域変更', 
              style: TextStyle(color: Colors.blueAccent),),
            onPressed: () {
              Navigator.pushNamed(context, 
                ScreenRouteName.selectCity.name, 
                arguments: CityInfo(name: 'Tokyo', countryCode: 'JP') )
              .then((value) async {
                List<String> cityValue = value;
                if(cityValue != null && cityValue.length > 1) {
                  _savePrefsData(cityValue: cityValue);
                }
              });
            }
          ),
        ),
      ],
    );
  }

  Future<void> _readPrefsData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _zipCd = (prefs.getString('zipCd') ?? '');
      _cityNameCd = (prefs.getString('cityNameCd') ?? 'Tokyo,JP');
      _temprtUnit = (prefs.getInt('temprtUnit') != null ? 
        TemperatureUnit.values[prefs.getInt('temprtUnit')] : TemperatureUnit.celsius);
    });
  }

  Future<void>  _savePrefsData({List<String> cityValue}) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('zipCd', cityValue[0]);
      prefs.setString('cityNameCd', cityValue[1]);
      _zipCd = cityValue[0];
      _cityNameCd = cityValue[1];
    });
  }
 
}
