import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:drogo_libro/core/viewmodels/base_view_model.dart';

import 'package:drogo_libro/config/service_setting.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? onModelReady;

  BaseView({Key? key, required this.builder, this.onModelReady})
      : super(key: key);

  @override
  BaseViewState<T> createState() => BaseViewState<T>();

  static of(BuildContext context) =>
      context.findAncestorStateOfType<BaseViewState>();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T viewModel = ServiceSetting.locator<T>();
  bool isLoading = false;

  @override
  void initState() {
    this.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (context) => viewModel,
        child: Consumer<T>(builder: widget.builder));
  }

  Future<void> reload() async {
    if (this.isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    if (widget.onModelReady != null) {
      await widget.onModelReady!(viewModel);
      setState(() {
        isLoading = false;
      });
    }
  }
}
