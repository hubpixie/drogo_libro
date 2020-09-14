import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/weather_info.dart';

typedef PresentWeeklyForecastDelegate = void Function();

class WeatherFunctionCell  extends StatefulWidget {
  final WeatherInfo itemValue;
  final TemperatureUnit temprtUnit;
  final PresentWeeklyForecastDelegate onPresentWeeklyForecast;

  WeatherFunctionCell({this.itemValue, this.temprtUnit, this.onPresentWeeklyForecast});

  @override
  _WeatherDetailPresentCellState createState() => _WeatherDetailPresentCellState();
}

class _WeatherDetailPresentCellState extends State<WeatherFunctionCell> {
  WeatherInfo _itemValue;

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FlatButton(
              child: Text('週間予報', 
                    style: TextStyle(fontSize: 18.0)),
              onPressed: () => widget.onPresentWeeklyForecast(),
            ),
          ),
          Spacer(),
          Text('体感 ', 
            style: TextStyle(fontSize: 11.0, color: Colors.black54),),
          Spacer(),
          Text('${_itemValue.feelsLike.as(widget.temprtUnit).round()}°', style: TextStyle(fontSize: 20.0)),
          Spacer(),
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('日の出', 
                  style: TextStyle(fontSize: 11.0, color: Colors.black54)),
                Text('${ _itemValue.getSunriseFormattedString()}', 
                  style: TextStyle(fontSize: 16.0)),
              ],)
          ),
          Spacer(),
          Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('日暮れ', 
                  style: TextStyle(fontSize: 11.0, color: Colors.black54)),
                Text('${ _itemValue.getSunsetFormattedString()}', 
                  style: TextStyle(fontSize: 16.0)),
              ],)
          ),
          Spacer(),
        ],
      )
    );
  }
}
