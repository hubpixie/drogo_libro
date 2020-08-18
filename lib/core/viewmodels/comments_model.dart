import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/data_result.dart';
import 'package:drogo_libro/core/services/web_api.dart';
import 'package:drogo_libro/config/service_setting.dart';

import 'base_view_model.dart';

class CommentsModel extends BaseViewModel {
  WebApi _api = ServiceSetting.locator<WebApi>();

  DataResult fetchedComments;

  Future fetchComments(int postId) async {
    setState(ViewState.Busy);
    fetchedComments = await _api.getCommentsForPost(postId);
    setState(ViewState.Idle);
  }
}
