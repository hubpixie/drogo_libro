import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/weather_info.dart';
import 'package:drogo_libro/core/models/city_info.dart';

typedef CellEditingDelegate = void Function(dynamic);

class WeatherContentCell  extends StatefulWidget {
  final WeatherInfo itemValue;
  final TemperatureUnit temprtUnit;
  final CellEditingDelegate onCellEditing;

  WeatherContentCell({this.itemValue, this.temprtUnit, this.onCellEditing});

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
    final double screenWidth = MediaQuery.of(context).size.width;
    _itemValue = widget.itemValue;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          Container(
            //width: screenWidth >= 320 && screenWidth <= 360  ? 120 : 150,
            constraints: BoxConstraints(
              minWidth: 80, 
              maxWidth: () {
                if(screenWidth <= 280) return 110.0;
                if(screenWidth <= 360) return 150.0;
                if(screenWidth <= 420) return 180.0;
                else return 250.0;                
              }()),
            padding: EdgeInsets.symmetric(vertical: 5.0),
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
          Text('${_itemValue.temperature.as(widget.temprtUnit).round()}°', style: TextStyle(fontSize: 40.0)),
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
                Text('${_itemValue.maxTemperature.as(widget.temprtUnit).round()}°', 
                  style: TextStyle(fontSize: 16.0)),
                Text('${ _itemValue.minTemperature.as(widget.temprtUnit).round()}°', 
                  style: TextStyle(fontSize: 16.0, color: Colors.black45)),
              ],)
          ),
          Spacer(),
        ],
      )
    );
  }
}
