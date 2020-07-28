import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/post.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/home_model.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/widgets/postlist_item.dart';

import 'base_view.dart';

class MySettingsView extends StatelessWidget {
  final String title;
  MySettingsView({this.title});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.mainBackgroundColor,
        body: model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             UIHelper.verticalSpaceLarge(),
            RaisedButton(
              child: Text("passcode"),
              onPressed: () {
                  Navigator.pushNamed(context, ScreenRouteName.passcode.name);
              },
            ),
            UIHelper.verticalSpaceSmall(),
            //Expanded(child: getPostsUi(model.posts)),
        ],)
      ),
    );
  }

  Widget getPostsUi(List<Post> posts) => ListView.builder(
    itemCount: posts.length,
     itemBuilder: (context, index) => PostListItem(
      post: posts[index],
      onTap: () {
        Navigator.pushNamed(context, ScreenRouteName.post.name, arguments: posts[index]);
      },
     )
  );
}
