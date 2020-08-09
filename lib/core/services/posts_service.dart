import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/models/data_result.dart';

import 'web_api.dart';

class PostsService {
  WebApi _api = ServiceSetting.locator<WebApi>();

  DataResult _fetchedPosts;
  DataResult get posts => _fetchedPosts;

  Future getPostsForUser(int userId) async {
    _fetchedPosts = await _api.getPostsForUser(userId);
  }

  void incrementLikes(int postId){
    _fetchedPosts.result.firstWhere((post) => post.id == postId).likes++;
  }
} 
