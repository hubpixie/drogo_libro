import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/weather_info.dart';


class HourlyForecastCell extends StatefulWidget {
  final List<WeatherInfo> hourlyForecastValue;
  final TemperatureUnit temprtUnit;

  HourlyForecastCell({this.hourlyForecastValue, this.temprtUnit});

  _HourlyForecastCellState createState() => _HourlyForecastCellState();

}

class _HourlyForecastCellState extends State<HourlyForecastCell> {
  List<WeatherInfo> _hourlyForecastValue;
  TemperatureUnit _temprtUnit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _hourlyForecastValue = widget.hourlyForecastValue;
    _temprtUnit = widget.temprtUnit;

    return Padding(
      padding: EdgeInsets.all(10),
      // width: 75,
      // height: 100.0,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _hourlyForecastValue.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildHourlyItem(context, index);
        }
      ),
    );
  }

  Widget _buildHourlyItem(BuildContext context, int index) {
    WeatherInfo hourValue = _hourlyForecastValue != null && _hourlyForecastValue.length > index ? _hourlyForecastValue[index] : WeatherInfo();

    return Column(
        children: <Widget>[
          Text('${hourValue.getTimeFormattedString()}'),
          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            width: 70,
            height: 70,
            child: Icon( hourValue != null  ?  hourValue.getIconData() : null,
              color: Colors.black45,
              size: 40,
              ),
          ),
          Text('${hourValue.temperature.as(_temprtUnit).round()}°'),
        ],
    );
  }
}
