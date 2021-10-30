import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/drogo_view_model.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/widgets/drogo_cell.dart';

import 'base_view.dart';

class DrogoListView extends StatefulWidget {
  final String title;
  DrogoListView({required this.title});

  @override
  State<StatefulWidget> createState() => _DrogoListViewState();
}

class _DrogoListViewState extends State<DrogoListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DrogoViewModel>(
      onModelReady: (viewModel) =>
          viewModel.getDrogoInfos(Provider.of<User>(context).id ?? -1),
      builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.appBarBackgroundColor,
            title: Text(widget.title),
          ),
          backgroundColor: AppColors.mainBackgroundColor,
          body: viewModel.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: viewModel.fetchedDrogoInfos?.result.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return DrogoCell(
                              drogoItem:
                                  viewModel.fetchedDrogoInfos?.result[index],
                              onCellSelected: (arguments) {
                                Navigator.pushNamed(context,
                                    ScreenRouteName.editDrogoDetail.name ?? '',
                                    arguments: arguments);
                              },
                            );
                          },
                        ),
                      )
                    ])),
    );
  }
}
