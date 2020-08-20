import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/viewmodels/weather_view_model.dart';

import 'package:drogo_libro/ui/shared/ui_helpers.dart';
import 'package:drogo_libro/ui/widgets/weather_top_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_content_cell.dart';
import 'package:drogo_libro/ui/widgets/weather_function_cell.dart';

import 'base_view.dart';

class WeatherPresentBanner  extends StatefulWidget {
  @override
  _WeatherPresentBannerState createState() => _WeatherPresentBannerState();
}

class _WeatherPresentBannerState extends State<WeatherPresentBanner> {
  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherViewModel>(
      onModelReady: (viewModel) => viewModel.getWeatherData(cityName: 'Tokyo,jp'),
      builder: (context, viewModel, child) => viewModel.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
            UIHelper.verticalSpaceSmall(),
            WeatherTopCell(itemValue: viewModel.fetchedWeatherInfo.result,),
            UIHelper.verticalSpaceSmall(),
            WeatherContentCell(),
            UIHelper.verticalSpaceSmall(),
            WeatherFunctionCell(),
            UIHelper.verticalSpaceSmall(),
        ],
      )
    );
  }
}
