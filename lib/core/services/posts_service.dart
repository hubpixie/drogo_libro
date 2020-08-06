import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';

import 'web_api.dart';

class PostsService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  DataResult _posts;
  DataResult get posts => _posts;

  Future getPostsForUser(int userId) async {
    _posts = await _api.getPostsForUser(userId);
  }

  void incrementLikes(int postId){
    _posts.result.firstWhere((post) => post.id == postId).likes++;
  }
} 
