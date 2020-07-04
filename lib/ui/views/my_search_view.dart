import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/home_model.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

import 'base_view.dart';

class MySearchView extends StatelessWidget {
  final String title;
  MySearchView({this.title});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 20.0)),
            TextField(
              //onChanged: () => {},
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Username",
                contentPadding: const EdgeInsets.all(20.0)
              )
            ),
          ],
        )
      ),
    );
  }

}
