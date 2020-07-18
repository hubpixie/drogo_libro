import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/comment.dart';
import 'package:drogo_libro/core/services/web_api.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'base_view_model.dart';

class CommentsModel extends BaseViewModel {
  WebApi _api = ServiceSetting.locator<WebApi>();

  List<Comment> comments;

  Future fetchComments(int postId) async {
    setState(ViewState.Busy);
    comments = await _api.getCommentsForPost(postId);
    setState(ViewState.Idle);
  }
}
