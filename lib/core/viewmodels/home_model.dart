import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/post.dart';
import 'package:drogo_libro/core/services/posts_service.dart';
import '../../config/service_setting.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  PostsService _postsService = ServiceSetting.locator<PostsService>();
  
  List<Post> get posts => _postsService.posts;

  Future getPosts(int userId) async {
    setState(ViewState.Busy);
    await _postsService.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}