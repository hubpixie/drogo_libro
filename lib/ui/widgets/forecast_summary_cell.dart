import 'package:flutter/material.dart';

import 'package:drogo_libro/core/shared/date_util.dart';
import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/weather_info.dart';

import 'package:drogo_libro/ui/shared/ui_helpers.dart';

typedef CellEditingDelegate = void Function(bool cityChanged, dynamic temprtUnit);

class ForecastSummaryCell  extends StatefulWidget {
  final WeatherInfo itemValue;
  final TemperatureUnit temprtUnit;
  final CellEditingDelegate onCellEditing;

  ForecastSummaryCell({this.itemValue, this.temprtUnit, this.onCellEditing});

  @override
  _ForecastSummaryCellState createState() => _ForecastSummaryCellState();
}


class _ForecastSummaryCellState extends State<ForecastSummaryCell> {
  WeatherInfo _itemValue;
  TemperatureUnit _temprtUnit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    _itemValue = widget.itemValue;
    _temprtUnit = widget.temprtUnit;

    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
      children: <Widget>[
        UIHelper.verticalSpaceSmall(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20.0),),
            Text('${DateUtil().getDateMDEString()} ', 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),),
            Spacer(),
            Text('${_itemValue.temperature.as(_temprtUnit).round()}°', 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 50.0)),
            Spacer(),
            Container(
              constraints: BoxConstraints(
                minWidth: 80, 
                maxWidth: () {
                  if(screenWidth <= 280) return 110.0;
                  if(screenWidth <= 360) return 150.0;
                  if(screenWidth <= 420) return 180.0;
                  else return 250.0;                
                }()),
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_itemValue.city.nameDesc}', 
                      softWrap: false, 
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 24.0)),
                    Text('${_itemValue.getWeatherDesc()}', 
                      softWrap: false, 
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 11.0, color: Colors.black45)),
                  ],
                ),
                onTap: () {
                  widget.onCellEditing(true, null);
                },
              )
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              width: 65,
              child: Text(
                '${_itemValue.maxTemperature.as(_temprtUnit).round()}°', 
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0)
              ),
            ),
            Spacer(),
            Container(
              child: Icon( _itemValue != null ?  _itemValue.getIconData() : null,
              color: Colors.black45,
                size: 50,
              )
            ),
            Spacer(),
            Container(
              width: 65,
              child: Text(
                '${ _itemValue.minTemperature.as(_temprtUnit).round()}°', 
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Colors.black45)),
            ),
            Spacer(flex: 2,),
            Container(
              margin: EdgeInsets.only(right: 0.0),
              width: 50.0,
              child: FlatButton(
                child: Text('°C',
                  textAlign: TextAlign.center,
                  style: TextStyle
                    (color: _temprtUnit == TemperatureUnit.celsius ? Colors.blueAccent : Colors.blueAccent.withAlpha(100),
                    fontWeight: _temprtUnit == TemperatureUnit.celsius ? FontWeight.bold : FontWeight.normal,),
                ),
                onPressed: () {
                   widget.onCellEditing(false, TemperatureUnit.celsius);
                },
              )
            ),
            Container(
              width: 50.0,
              child: FlatButton(
                child: Text('°F',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _temprtUnit == TemperatureUnit.fahrenheit ? Colors.blueAccent : Colors.blueAccent.withAlpha(100),
                    fontWeight: _temprtUnit == TemperatureUnit.fahrenheit ? FontWeight.bold : FontWeight.normal,),
                ),
                onPressed: () {
                   widget.onCellEditing(false, TemperatureUnit.fahrenheit);
                },
              )
            ),
          ],
        ),
      ]
    ));
  }
}
