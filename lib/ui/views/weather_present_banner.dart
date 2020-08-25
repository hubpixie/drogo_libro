import 'package:drogo_libro/core/models/city_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/viewmodels/weather_view_model.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';
import 'package:drogo_libro/ui/widgets/weather_top_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_content_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_function_cell.dart';

import 'base_view.dart';

class WeatherPresentBanner  extends StatefulWidget {
  final bool isTabAppeared;

  WeatherPresentBanner({this.isTabAppeared});

  @override
  _WeatherPresentBannerState createState() => _WeatherPresentBannerState();
}

class _WeatherPresentBannerState extends State<WeatherPresentBanner> with WidgetsBindingObserver {
  String _cityNameCd;
  String _zipCd;
  GlobalKey<BaseViewState> _reloaderKey;
  bool _isTabFirstAppeared = true;

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
    if(state == AppLifecycleState.resumed){
      // reload this banner due to parameter changed.
      setState(() {
        if (_reloaderKey.currentState != null && !_isTabFirstAppeared) {
          _reloaderKey.currentState.reload();
        }
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isTabAppeared) {
      setState(() {
        // reload this banner due to parameter changed.
        if (_reloaderKey.currentState != null && !_isTabFirstAppeared) {
          _reloaderKey.currentState.reload();
        }
      });
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
              UIHelper.verticalSpaceSmall(),
              WeatherContentCell(itemValue: viewModel.fetchedWeatherInfo.result,
              onCellEditing: (arguments) {
                Navigator.pushNamed(context, ScreenRouteName.selectCity.name, arguments: arguments)
                .then((value) {
                    List<String> cityValue = value;
                    print('cityValue = $cityValue');
                    if(cityValue != null && cityValue.length > 1 ) {
                      _savePrefsData(cityValue);
                    }
                });
              }),
              UIHelper.verticalSpaceSmall(),
              WeatherFunctionCell(),
              UIHelper.verticalSpaceSmall(),
            ],);
          }
        }
      );
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
                setState(() {
                  List<String> cityValue = value;
                  print('cityValue = $cityValue');
                  if(cityValue != null && cityValue.length > 1) {
                    _zipCd = cityValue[0];
                    _cityNameCd = cityValue[1];
                  }
                });
              });
            }
          ),
        ),
      ],
    );
  }

  void _readPrefsData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _zipCd = (prefs.getString('zipCd') ?? '');
      _cityNameCd = (prefs.getString('cityNameCd') ?? 'Tokyo,JP');
      print('_readPrefsData : _cityNameCd = $_cityNameCd');
    });
  }

  void  _savePrefsData(List<String> cityValue) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString('zipCd', cityValue[0]);
      prefs.setString('cityNameCd', cityValue[1]);
      print('_savePrefsData : _cityNameCd = ${prefs.getString('cityNameCd') ?? 'Tokyo,JP'}');
      _zipCd = cityValue[0];
      _cityNameCd = cityValue[1];
    });
  }
 
}
