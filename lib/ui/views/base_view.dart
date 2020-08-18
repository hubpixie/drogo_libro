import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/viewmodels/base_view_model.dart';

import 'package:drogo_libro/config/service_setting.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final Function(T) onModelReady;

  BaseView({this.builder, this.onModelReady});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T viewMOdel = ServiceSetting.locator<T>();

  @override
  void initState() {
    if (widget.onModelReady != null) {
      widget.onModelReady(viewMOdel);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => viewMOdel,
        child: Consumer<T>(builder: widget.builder));
  }
}
