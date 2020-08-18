import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/services/posts_service.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'base_view_model.dart';

class HomeModel extends BaseViewModel {
  PostsService _postsService = ServiceSetting.locator<PostsService>();
  
  DataResult get posts => _postsService.posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    await _postsService.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}