import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/weather_info.dart';

class WeeklyForecastCell extends StatefulWidget {
  final List<WeatherInfo>? weeklyForecastValue;
  final TemperatureUnit temprtUnit;

  WeeklyForecastCell({this.weeklyForecastValue, required this.temprtUnit});

  _WeeklyForecastCellState createState() => _WeeklyForecastCellState();
}

class _WeeklyForecastCellState extends State<WeeklyForecastCell> {
  List<WeatherInfo>? _weeklyForecastValue;
  late TemperatureUnit _temprtUnit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _weeklyForecastValue = widget.weeklyForecastValue;
    _temprtUnit = widget.temprtUnit;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(_weeklyForecastValue != null &&
                  (_weeklyForecastValue?.isNotEmpty ?? false)
              ? '${_weeklyForecastValue?.first.getDataFormattedString()} 〜 ${_weeklyForecastValue?.last.getDataFormattedString()}'
              : ''),
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _weeklyForecastValue?.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _buildHourlyItem(context, index);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyItem(BuildContext context, int index) {
    WeatherInfo? weeklyValue = _weeklyForecastValue?[index];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('${weeklyValue?.getDataFormattedString()}'),
        Container(
          //width: 50,
          height: 70,
          child: Icon(
            weeklyValue != null ? weeklyValue.getIconData() : null,
            color: Colors.black45,
            size: 40,
          ),
        ),
        Text(
            '${weeklyValue?.maxTemperatureOfForecast?.as(_temprtUnit).round()}°'),
        Text(
          '${weeklyValue?.minTemperatureOfForecast?.as(_temprtUnit).round()}°',
          style: TextStyle(color: Colors.black38),
        ),
      ],
    );
  }
}
