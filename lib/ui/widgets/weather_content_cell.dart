import 'package:flutter/material.dart';

import 'package:drogo_libro/core/models/weather_info.dart';
import 'package:drogo_libro/core/models/city_info.dart';

typedef CellEditingDelegate = void Function(dynamic);

class WeatherContentCell  extends StatefulWidget {
  final WeatherInfo itemValue;
  final CellEditingDelegate onCellEditing;

  WeatherContentCell({this.itemValue, this.onCellEditing});

  @override
  _WeatherContentCellState createState() => _WeatherContentCellState();
}


class _WeatherContentCellState extends State<WeatherContentCell> {
  WeatherInfo _itemValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 30.0),),
          Container(
           // width: 40,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${_itemValue.city.nameDesc}', 
                    style: TextStyle(fontSize: 24.0)),
                  Text('${_itemValue.getWeatherDesc()}', 
                    style: TextStyle(fontSize: 14.0, color: Colors.black45)),
              ],),
              onTap: () {
                setState(() {
                  widget.onCellEditing(CityInfo(
                    name: widget.itemValue.city.name, zip: widget.itemValue.city.zip, countryCode: widget.itemValue.city.countryCode)
                  );
                });
              },
            )
          ),
          Spacer(),
          Text('${_itemValue.temperature.celsius.round()}°', style: TextStyle(fontSize: 28.0)),
          Spacer(),
          Container(
            child: Icon( _itemValue != null ?  _itemValue.getIconData() : null,
            color: Colors.black45,
            size: 40,
          )
          ),
          // Image.network(
          //   'http://openweathermap.org/img/wn/${_itemValue.iconCode}@2x.png',
          //   width: 30,
          //   height: 30,
          // ),
          Spacer(),
          Container(
            width: 40,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${_itemValue.maxTemperature.celsius.round()}°', 
                  style: TextStyle(fontSize: 16.0)),
                Text('${ _itemValue.minTemperature.celsius.round()}°', 
                  style: TextStyle(fontSize: 16.0, color: Colors.black45)),
              ],)
          ),
          Padding(padding: EdgeInsets.only(right: 30.0),),
        ],
      )
    );
  }
}
