import 'package:flutter/material.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';

/// ファンクションボタンの種別
enum FunctionButtonKind {
  listupDrogo,    //一覧
  searchDrogo,    //検索
  addDrogoDetail, //登録
  editMyMemo,     //気になったことを記録
  usingDrogo,     //薬の飲み方
  showDrogoForgotHelp, //飲み忘れた時
}

class MyDrogoView extends StatefulWidget {
  final String title;
  MyDrogoView({this.title});

  @override
  State<StatefulWidget> createState() => _MyDrogoViewState();
}

class _MyDrogoViewState extends State<MyDrogoView> {
  //==========================<
  // Const defines
  static const List<String> _kFunctionButtonTextList = ["おくすり一覧", "おくすり検索", "おくすりを登録する", "気になったことを記録する", "お薬の飲み方", "おくすりを忘れたら"];
  static const List<IconData> _kFunctionButtonIconList = [Icons.list, Icons.search, Icons.edit, Icons.note, Icons.info_outline, Icons.help_outline];

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
                    height: screenHeight / 3,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: screenWidth / 2,
                          color: Colors.indigo[100].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.listupDrogo),
                        ),
                        Container(
                          width: screenWidth / 2,
                          color: Colors.indigo[200].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.searchDrogo),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight / 3,
                    child: ListView(
                      primary: false,
                      children: <Widget>[
                        Container(
                          width: screenWidth,
                          height: screenHeight / 6,
                          color: Colors.indigo[300].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.addDrogoDetail),
                        ),
                        Container(
                          width: screenWidth,
                          height: screenHeight / 6,
                          color: Colors.indigo[400].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.editMyMemo),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight / 3,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: screenWidth / 2,
                          color: Colors.indigo.withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.usingDrogo),
                        ),
                        Container(
                          width: screenWidth / 2,
                          color: Colors.indigo[600].withAlpha(200),
                          child: _buildFunctionButton(context, FunctionButtonKind.showDrogoForgotHelp),
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
    return buttonKind == FunctionButtonKind.addDrogoDetail || buttonKind == FunctionButtonKind.editMyMemo ?
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
      case FunctionButtonKind.listupDrogo:
          Navigator.pushNamed(context, ScreenRouteName.listupDrogo.name);
          break;
      case FunctionButtonKind.searchDrogo:
          Navigator.pushNamed(context, ScreenRouteName.searchDrogo.name);
          break;
      case FunctionButtonKind.addDrogoDetail:
          Navigator.pushNamed(context, ScreenRouteName.addDrogoDetail.name);
          break;
      case FunctionButtonKind.editMyMemo:
          Navigator.pushNamed(context, ScreenRouteName.editMyMemo.name);
          break;
      case FunctionButtonKind.usingDrogo:
          Navigator.pushNamed(context, ScreenRouteName.usingDrogo.name);
          break;
      case FunctionButtonKind.showDrogoForgotHelp:
          Navigator.pushNamed(context, ScreenRouteName.showDrogoForgotHelp.name);
          break;
      default:
          break;
    }

  }
}
