import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:drogo_libro/config/service_setting.dart';
import 'package:drogo_libro/core/services/firebse_analytics_service.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/viewmodels/login_model.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/widgets/login_header.dart';
import 'package:drogo_libro/ui/views/base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    ServiceSetting.locator<FirebaseAnalyticsService>().sendViewEvent(sender: AnalyticsSender.login);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
        builder: (context, viewModel, child) => Scaffold(
          backgroundColor: AppColors.mainBackgroundColor,
          body: LoadingOverlay(
            opacity: 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LoginHeader(
                  validationMessage: viewModel.errorMessage,
                  controller: _controller),
                viewModel.state == ViewState.Busy
                ? CircularProgressIndicator()
                : FlatButton(
                  color: Colors.white,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async { 
                    // キーボードを閉じる
                    FocusScope.of(context).unfocus();

                    // ログイン認証
                    var loginSuccess = await viewModel.login(_controller.text);
                    if(loginSuccess){
                      Navigator.pushNamed(context, ScreenRouteName.myTabs.name);
                    }
                  },
                )
              ],
            ),
            isLoading: viewModel.state == ViewState.Busy
          ),
        ),
    );
  }
}
