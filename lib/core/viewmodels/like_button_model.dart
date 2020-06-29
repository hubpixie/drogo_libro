import 'package:drogo_libro/core/services/posts_service.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'base_model.dart';

class LikeButtonModel extends BaseModel {
  PostsService _postsService = ServiceSetting.locator<PostsService>();

  int postLikes(int postId) {
    return _postsService.posts
        .firstWhere((post) => post.id == postId)
        .likes;
  }

  void increaseLikes(int postId) {
    _postsService.incrementLikes(postId);
    notifyListeners();
  }
}
