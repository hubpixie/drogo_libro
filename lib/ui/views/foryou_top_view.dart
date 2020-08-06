import 'package:flutter/material.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';

/// ファンクションボタンの種別
enum FunctionButtonKind {
  presentForyouAll,    //Foryou　全部みる
  usingForyou,    //記載方法
  editBloodType, //血液型
  editMedicalHistory,     //既往歴
  editAllergy,     //アレルギー
  editSuplements, //サプリメントなど
  editSideEffect, //副作用
}

class ForyouTopView extends StatefulWidget {
  final String title;
  ForyouTopView({this.title});

  @override
  State<StatefulWidget> createState() => _ForyouTopViewState();
}

class _ForyouTopViewState extends State<ForyouTopView> {
  //==========================<
  // Const defines
  static const List<String> _kFunctionButtonTextList = ["Foryou情報を丸ごと見る", "編集方法について", "血液型を編集・確認する", 
    "既往歴を編集・確認する", "アレルギー歴を編集・確認する", "サプリメントなどを編集・確認する", "副作用歴を編集・確認する"];
  static const List<IconData> _kFunctionButtonIconList = [Icons.present_to_all, Icons.description, Icons.edit_attributes, Icons.edit_attributes, Icons.edit_attributes, Icons.edit_attributes, Icons.edit_attributes];

  //==========================>

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 135;
    return  Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            primary: false,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: screenHeight * 0.3,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: screenWidth / 2,
                          color: Colors.orange[100].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.presentForyouAll),
                        ),
                        Container(
                          width: screenWidth / 2,
                          color: Colors.orange[200].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.usingForyou),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.4,
                    child: ListView(
                      primary: false,
                      children: <Widget>[
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.4 / 3,
                          color: Colors.orange[300].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.editBloodType),
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.4 / 3,
                          color: Colors.orange[400].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.editMedicalHistory),
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.4 / 3,
                          color: Colors.orange.withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.editAllergy),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.3,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: screenWidth / 2,
                          color: Colors.orange[600].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.editSuplements),
                        ),
                        Container(
                          width: screenWidth / 2,
                          color: Colors.orange[700].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.editSideEffect),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildFunctionButton(BuildContext context, FunctionButtonKind buttonKind) {
    List<Widget> wlst = [
      Ink(
        decoration: ShapeDecoration(
          color: Colors.teal,
          shape: CircleBorder(),
        ),
        child: IconButton(
          icon: Icon(_kFunctionButtonIconList[buttonKind.index]),
          color: Colors.white,
          onPressed: () => _buttonOnTap(context, buttonKind),
        ),
      ),
      Align(alignment: Alignment.center,
        child: FlatButton(
          onPressed: () => _buttonOnTap(context, buttonKind),
          child: Text(_kFunctionButtonTextList[buttonKind.index],
                style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ];
    return [FunctionButtonKind.editBloodType, FunctionButtonKind.editMedicalHistory, FunctionButtonKind.editAllergy].contains(buttonKind) ?
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: wlst
      ) :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: wlst
      );
  }

  void _buttonOnTap(BuildContext context, FunctionButtonKind buttonKind) {
    switch(buttonKind) {
      case FunctionButtonKind.presentForyouAll:
          Navigator.pushNamed(context, ScreenRouteName.presentForyouAll.name);
          break;
      case FunctionButtonKind.usingForyou:
          Navigator.pushNamed(context, ScreenRouteName.usingForyou.name);
          break;
      case FunctionButtonKind.editBloodType:
          Navigator.pushNamed(context, ScreenRouteName.editBloodType.name);
          break;
      case FunctionButtonKind.editMedicalHistory:
          Navigator.pushNamed(context, ScreenRouteName.editMedicalHistory.name);
          break;
      case FunctionButtonKind.editAllergy:
          Navigator.pushNamed(context, ScreenRouteName.editAllergy.name);
          break;
      case FunctionButtonKind.editSuplements:
          Navigator.pushNamed(context, ScreenRouteName.editSuplements.name);
          break;
      case FunctionButtonKind.editSideEffect:
          Navigator.pushNamed(context, ScreenRouteName.editSideEffect.name);
          break;
      default:
          break;
    }

  }
}
