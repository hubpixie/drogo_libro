import 'package:drogo_libro/core/models/post.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'web_api.dart';

class PostsService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  List<Post> _posts;
  List<Post> get posts => _posts;

  Future getPostsForUser(int userId) async {
    _posts = await _api.getPostsForUser(userId);
  }

  void incrementLikes(int postId){
    _posts.firstWhere((post) => post.id == postId).likes++;
  }
} 
