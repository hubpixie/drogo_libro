import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:drogo_libro/core/enums/viewstate.dart';
// import 'package:drogo_libro/core/models/user.dart';
// import 'package:drogo_libro/ui/shared/app_colors.dart';

// import 'base_view.dart';

class MyAlarmView extends StatelessWidget {
  final String title;
  MyAlarmView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container();
    // return BaseView<HomeModel>(
    //   onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
    //   builder: (context, model, child) => Scaffold(
    //     backgroundColor: AppColors.mainBackgroundColor,
    //     body: model.state == ViewState.Busy
    //     ? Center(child: CircularProgressIndicator())
    //      : Column(
    //        crossAxisAlignment: CrossAxisAlignment.start,
    //        children: <Widget>[
    //         Expanded(child: Text(this.title)),
    //     ],)
    //   ),
    // );
  }
}
