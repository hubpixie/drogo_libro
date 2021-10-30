import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';
import 'package:drogo_libro/core/viewmodels/drogo_view_model.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/search_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/widgets/search_result_cell.dart';

import 'base_view.dart';

class MySearchResultView extends StatefulWidget {
  final DrogoSearchParam searchedParam;
  final SearchType searchedType;
  MySearchResultView({required this.searchedParam, required this.searchedType});

  @override
  State<StatefulWidget> createState() => _MySearchResultViewState();
}

class _MySearchResultViewState extends State<MySearchResultView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DrogoViewModel>(
      onModelReady: (viewModel) => viewModel.getDrogoInfos(
          Provider.of<User>(context).id ?? -1,
          param: widget.searchedParam),
      builder: (context, viewModel, child) => Scaffold(
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
                            return SearchResultCell(
                                searchedType: widget.searchedType,
                                drogoItem:
                                    viewModel.fetchedDrogoInfos?.result[index],
                                onCellSelected: (arguments) {
                                  Navigator.pushNamed(
                                      context,
                                      ScreenRouteName.editDrogoDetail.name ??
                                          '',
                                      arguments: arguments);
                                });
                          },
                        ),
                      )
                    ])),
    );
  }
}
