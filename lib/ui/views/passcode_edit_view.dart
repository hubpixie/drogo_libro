import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:drogo_libro/core/shared/string_util.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/ui_helpers.dart';

class PasscodeEditView extends StatefulWidget {
  final String title;
  final String passcode;

  PasscodeEditView({this.title, this.passcode});

  @override
 _PasscodeEditViewState createState() => _PasscodeEditViewState();
}

class _PasscodeEditViewState extends State<PasscodeEditView> {
   GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _passcodeTextController;
  TextEditingController _passcodeConfirmedTextController;
  String _oldPasscode;
  FocusNode _passcodeFocusNode;
  FocusNode _passcodeConfirmedFocusNode;
  bool _isPasscodeChanged = false;
  bool _isPasscodeEqual = true;
  bool _isPasscodeOK = false;

  @override
  void initState() {
    _scaffoldKey = GlobalKey<ScaffoldState>();

    _passcodeTextController = TextEditingController(text: '');
    _oldPasscode = widget.passcode ?? '';
    if(_oldPasscode.isEmpty) {
      StringUtil().readEncrptedData();
     _oldPasscode = StringUtil().encryptedPcode ?? '';
    }
    _passcodeConfirmedTextController = TextEditingController(text: '');

    
    // 入力フォーカス関しイベント処理
    _passcodeFocusNode = FocusNode();
    _passcodeFocusNode.addListener(() {
      if(!_passcodeFocusNode.hasFocus) {
        setState(() {
          _validatePasscodeOK();
        });
      }
    });

    _passcodeConfirmedFocusNode = FocusNode();
    _passcodeConfirmedFocusNode.addListener(() {
      if(!_passcodeConfirmedFocusNode.hasFocus) {
        setState(() {
          _validatePasscodeOK();
        });
      }
    });

    // キーボード開閉時監視イベント作成
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if(!visible) {
          if(_passcodeFocusNode.hasFocus) {
            setState(() {
              _validatePasscodeOK();
            });
          }
          if(_passcodeConfirmedFocusNode.hasFocus) {
            setState(() {
              _validatePasscodeOK();
            });
          }
        }
      },
    );    

    super.initState();
  }

  @override
  void dispose() {
    _passcodeTextController.dispose();
    _passcodeConfirmedTextController.dispose();
    _passcodeFocusNode.dispose();
    _passcodeConfirmedFocusNode.dispose();
    _scaffoldKey = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // キーボードを閉じる
          FocusScope.of(context).unfocus();
        },
        child:_buildInputContent(context),
      )
    );
 }

 Widget _buildInputContent(BuildContext context) {
    return  Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 60),),
            // 郵便番号 / 市町村
            Container(
              width: MediaQuery.of(context).size.width - 140,
              alignment: Alignment.center,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _passcodeTextController,
                focusNode: _passcodeFocusNode,
                maxLength: 6,
                obscureText: true,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'パスコード',
                  hintText: '******',
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 郵便番号 / 市町村
            Container(
              width: MediaQuery.of(context).size.width - 140,
              alignment: Alignment.center,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _passcodeConfirmedTextController,
                focusNode: _passcodeConfirmedFocusNode,
                maxLength: 6,
                obscureText: true,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: '確認用パスコード',
                  hintText: '******',
                  counterText: '',
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(!_isPasscodeEqual ?
              'パスコード不一致' : '',
              style: TextStyle(color: Colors.red),
            )
          ]
        ),
        UIHelper.verticalSpaceLarge(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Spacer(),
            Container(
              width: 200,
              height: 50.0,
              //margin: EdgeInsets.only(bottom: 50),
              child: FlatButton(
                onPressed: _isPasscodeOK ?
                () async {
                  // キーボードを閉じる
                  FocusScope.of(context).unfocus();
                  _savePrefsData(passcode: _passcodeTextController.text);
                  final snackBar = SnackBar(
                      backgroundColor: Colors.deepPurple[900],
                      content: Text(_oldPasscode.isNotEmpty ? '更新しました' : '設定しました', style: TextStyle(color: Colors.white),),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                      duration: Duration(seconds: 4),
                    );
                    _scaffoldKey.currentState.showSnackBar(snackBar).closed.then((value) {
                      Navigator.of(context).pop<String>(
                        _isPasscodeChanged ? _passcodeTextController.text : widget.passcode
                      );
                    return Future.value(false);
                  });
                }: null,
                child: Text(_oldPasscode.isNotEmpty ? '更新する' : '設定する', 
                  style: TextStyle(
                    color: _isPasscodeOK ? Colors.white : Colors.white30,
                    fontSize: 20.0,
                  ),
                ),
                color: Colors.blueAccent,
                disabledColor: Colors.grey[400],
              )
            ,),
          ],
        ),
      ],
    );
  }

  void _validatePasscodeOK() {
    bool flag = false;
    if(_passcodeTextController.text.length == 6 && _passcodeTextController.text.length == 6 ) {
      flag = (_passcodeTextController.text == _passcodeConfirmedTextController.text);
    }
    _isPasscodeOK = flag;
    if(_passcodeTextController.text.isEmpty && _passcodeConfirmedTextController.text.isEmpty) {
      _isPasscodeEqual = true;
    } else {
      _isPasscodeEqual = _isPasscodeOK;
    }
  }

  Future<void>  _savePrefsData({String passcode = ''}) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (passcode.isNotEmpty) {
        _isPasscodeChanged = true;
        prefs.setString('pcd', StringUtil().encryptedString(passcode));
      } 
    });
  }

}