import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/drogo_view_model.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/widgets/drogo_cell.dart';

import 'base_view.dart';

class MyDrogoView extends StatefulWidget {
  final String title;
  MyDrogoView({this.title});

  @override
  State<StatefulWidget> createState() => _MyDrogoViewState();
}

class _MyDrogoViewState extends State<MyDrogoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
    return BaseView<DrogoViewModel>(
      onModelReady: (viewModel) => viewModel.getDrogoInfoList(Provider.of<User>(context).id),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: viewModel.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: viewModel.drogoInfoList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return DrogoCell(drogoItem: viewModel.drogoInfoList[index]);
                  },
                ),
              )
            ]
          )
        ),
    );
  }

}
