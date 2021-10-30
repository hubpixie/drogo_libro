import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';

enum _HidesPasscode {
  no,
  yes,
}

class PasscodeSettingsView extends StatefulWidget {
  final String title;

  PasscodeSettingsView({required this.title});

  @override
  _PasscodeSettingsViewState createState() => _PasscodeSettingsViewState();
}

class _PasscodeSettingsViewState extends State<PasscodeSettingsView> {
  _HidesPasscode? _hidesPasscode;

  String? _passcode;

  @override
  void initState() {
    // Shared preferenceからパスコードを読み込む
    _readPrefsData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        title: Text(widget.title),
      ),
      body: _buildInputContent(context),
    );
  }

  Widget _buildInputContent(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Radio(
              value: _HidesPasscode.no,
              groupValue: _hidesPasscode,
              onChanged: (_HidesPasscode? value) async =>
                  _savePrefsData(hidesPasscode: value ?? _HidesPasscode.yes),
            ),
            Container(
              child: Text(
                'パスコードを表示する',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              //width: MediaQuery.of(context).size.width - 10,
              margin: EdgeInsets.only(left: 70, right: 10),
              alignment: Alignment.bottomLeft,
              child: Text(
                _passcode != null && (_passcode?.isNotEmpty ?? false)
                    ? ''
                    : '未設定の場合、設定してください',
                maxLines: null,
                style: TextStyle(
                  fontSize: 12.0,
                  height: 0.9,
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Radio(
              value: _HidesPasscode.yes,
              groupValue: _hidesPasscode,
              onChanged: (_HidesPasscode? value) async =>
                  _savePrefsData(hidesPasscode: value ?? _HidesPasscode.yes),
            ),
            Container(
              child: Text(
                'パスコードを表示しない',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        UIHelper.verticalSpaceLarge(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 50.0,
              margin: EdgeInsets.only(bottom: 100),
              child: TextButton(
                onPressed: () => setState(() {
                  void Function() nextCall = () {
                    Navigator.pushNamed(
                        context, ScreenRouteName.editPasscode.name ?? '',
                        arguments: {'pcd': _passcode}).then((value) async {
                      String? newValue = value as String?;
                      if (newValue != null && newValue.isNotEmpty) {
                        setState(() {
                          _passcode = newValue;
                        });
                      }
                    });
                  };

                  if ((_passcode?.isNotEmpty ?? false)) {
                    Navigator.pushNamed(
                            context, ScreenRouteName.passcode.name ?? '')
                        .then((value) {
                      final bool? auth = value as bool?;
                      if (auth ?? false) {
                        nextCall();
                      }
                    });
                  } else {
                    // パスコード未設定の場合、直接パスコード設定画面へいく
                    nextCall();
                  }
                }),
                child: Text(
                  (_passcode?.isNotEmpty ?? false) ? 'パスコーの変更' : 'パスコード設定',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                //color: Colors.blueAccent,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.5);
                      else if (states.contains(MaterialState.disabled))
                        return Colors.grey[400]!;
                      return Colors.blueAccent; // Use the component's default.
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _readPrefsData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hidesPasscode = (prefs.getBool('isPasscodeHidden') ?? true)
          ? _HidesPasscode.yes
          : _HidesPasscode.no;
      _passcode = (prefs.getString('pcd') ?? '');
    });
  }

  Future<void> _savePrefsData({_HidesPasscode? hidesPasscode}) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (hidesPasscode != null) {
        _hidesPasscode = hidesPasscode;
        prefs.setBool('isPasscodeHidden',
            hidesPasscode == _HidesPasscode.yes ? true : false);
      }
    });
  }
}
