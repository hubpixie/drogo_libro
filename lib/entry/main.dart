import 'package:flutter/material.dart';
import 'app_entry.dart';
import 'package:drogo_libro/config/app_env.dart';
import 'package:drogo_libro/config/service_setting.dart';

void main() {
  // App Envを指定する
  AppEnv.configure(flavor: Flavor.product);
  // APPの初期登録
  ServiceSetting.setup();
  // APPの起動
  runApp(MyApp());
}