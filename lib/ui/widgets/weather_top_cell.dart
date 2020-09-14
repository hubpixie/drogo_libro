import 'package:flutter/material.dart';

import 'package:drogo_libro/core/shared/date_util.dart';
import 'package:drogo_libro/core/models/weather_info.dart';

class WeatherTopCell  extends StatefulWidget {
  final WeatherInfo itemValue;

  WeatherTopCell({this.itemValue});

  @override
  _WeatherTopCellState createState() => _WeatherTopCellState();
}

class _WeatherTopCellState extends State<WeatherTopCell> {
  WeatherInfo _itemValue;

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue;

    return Container(
      child: Row(
        children: _buildTopWidgets(),
      )
    );
  }

  List<Widget> _buildTopWidgets() {
    List<Widget> wlist = <Widget>[
      Padding(padding: EdgeInsets.only(left: 10.0),),
      Text('${DateUtil().getDateMDEString()} ', style: TextStyle(fontSize: 16.0),),
      Spacer(),
      Text('湿度 ', 
        style: TextStyle(fontSize: 11.0, color: Colors.black54),),
      Spacer(),
      Text('${_itemValue.humidity}% ', style: TextStyle(fontSize: 16.0)),
    ];

    if(_itemValue.hasPrecit) {
      wlist.addAll([
        Spacer(),
        Text('${_itemValue.getPrecipLabel()} ', style: TextStyle(fontSize: 11.0, color: Colors.black54),),
        Spacer(),
        Text('${_itemValue.getPrecipValue()}', style: TextStyle(fontSize: 16.0))
      ]);
    } else {
      wlist.addAll([
        Spacer(),
        Text('風速 ', style: TextStyle(fontSize: 11.0, color: Colors.black54),),
        Spacer(),
        Text('${_itemValue.windSpeed } ',
          style: TextStyle(fontSize: 14.0)),
        Text('m/s (${_itemValue.getWindDirectionValue()})',
          style: TextStyle(fontSize: 11.0)),
      ]);
    }
    wlist.add(
      Padding(padding: EdgeInsets.only(right: 10.0),)
    );

    return wlist;
  }
}