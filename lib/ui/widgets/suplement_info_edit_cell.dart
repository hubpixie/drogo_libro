import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

class SuplementInfoEditCell extends StatefulWidget {

  @override
  _SuplementInfoEditCellState createState() => _SuplementInfoEditCellState();
}

class _SuplementInfoEditCellState extends State<SuplementInfoEditCell> {
  List<bool> _suplementTypeList;
  TextEditingController _textController;


  @override
  void initState() {
    super.initState();
    _suplementTypeList = List.filled(SuplementTypes.values.length, false);
    _textController = TextEditingController();

    // キーボード開閉時監視イベント作成
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if(!visible) {
          _textFieldOnEditigComplete();
        }
      },
    );    

  }

  @override
  void dispose() {
    _suplementTypeList = null;
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return 
      Card(child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("使用中のサプリメント等",
                    style: TextStyle(fontSize: 20.0),),
                ),
                Padding( padding: const EdgeInsets.only(top: 10.0),
                ),
                Container(
                  width: screenWidth < 375 ? 50 : null,
                  child: screenWidth < 320 ? null : Text("複数チェック可",
                    style: TextStyle(fontSize: 12.0, height: 1.2), maxLines: 2,)
                ),
              ]
             ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(" ",
                    style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _suplementTypeList[SuplementTypes.vitaminK.index],
                  onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.vitaminK.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: screenWidth - 130,
                  height: 40,
                  child: Text(SuplementTypes.vitaminK.name, style: TextStyle(fontSize: 15.0, height: 1.2), maxLines: 2, ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(" ",
                    style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _suplementTypeList[SuplementTypes.stJohnsWort.index],
                  onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.stJohnsWort.index, value),
                ),
                Text(SuplementTypes.stJohnsWort.name, style: TextStyle(fontSize: 16.0),),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(" ",
                    style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _suplementTypeList[SuplementTypes.gingyoLeafExtract.index],
                  onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.gingyoLeafExtract.index, value),
                ),
                Text(SuplementTypes.gingyoLeafExtract.name, style: TextStyle(fontSize: 16.0),),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                ),
                Text("${SuplementTypes.etc.name}  (",
                    style: TextStyle(fontSize: 16.0),),
                Container(
                  width: MediaQuery.of(context).size.width - 175,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'その他を入力',
                    ),
                    style: TextStyle(fontSize: 12.0, height: 1.0),
                  ),
                ),
                Text(" )", style: TextStyle(fontSize: 16.0),),
              ]
            )
        ],)
      );
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
    setState(() {
      // 該当チェックボックスにチェック状態の更新を行う
      _suplementTypeList[index] = value;

      //　相関チェック
      if (value) {
        _suplementTypeList[SuplementTypes.etc.index] = false;
        _textController.text = '';
      }
    });
  }

  // テキストフィールド入力完了時の処理
  void _textFieldOnEditigComplete() {
    setState(() {
      if (_textController.text.isNotEmpty) {
        for(int idx = 0; idx < _suplementTypeList.length; idx++) _suplementTypeList[idx] = false;
        _suplementTypeList[SuplementTypes.etc.index] = true;
      } else {
        _suplementTypeList[SuplementTypes.etc.index] = false;
      }
    });
  }  
}
