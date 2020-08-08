import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

class AllergyHistoryEditCell extends StatefulWidget {

  @override
  _AllergyHistoryEditCellState createState() => _AllergyHistoryEditCellState();
}

class _AllergyHistoryEditCellState extends State<AllergyHistoryEditCell> {
  List<bool> _allergyTypeList;
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _allergyTypeList =  List.filled(AllergyTypes.values.length, false);
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
    _allergyTypeList = null;
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
      Card(child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("アレルギー",
                    style: TextStyle(fontSize: 20.0),),
                ),
                Padding( padding: const EdgeInsets.only(top: 10.0),
                ),
                Text("複数チェック可",
                    style: TextStyle(fontSize: 12.0),)
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
                  value: _allergyTypeList[AllergyTypes.milk.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.milk.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AllergyTypes.milk.name, style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _allergyTypeList[AllergyTypes.egg.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.egg.index, value),
                ),
                Text(AllergyTypes.egg.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _allergyTypeList[AllergyTypes.pollinosis.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.pollinosis.index, value),
                ),
                Text(AllergyTypes.pollinosis.name, style: TextStyle(fontSize: 16.0),),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                ),
                Text("${AllergyTypes.etc.name}  (",
                    style: TextStyle(fontSize: 16.0),),
                Container(
                  width: MediaQuery.of(context).size.width - 175,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    controller: _textController,
                    onEditingComplete: () => _textFieldOnEditigComplete(),
                    decoration: InputDecoration(
                      hintText: 'その他を入力',
                    ),
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
      _allergyTypeList[index] = value;

      //　相関チェック
      if (value) {
        _allergyTypeList[AllergyTypes.etc.index] = false;
        _textController.text = '';
      }
    });
  }

  // テキストフィールド入力完了時の処理
  void _textFieldOnEditigComplete() {
    setState(() {
      if (_textController.text.isNotEmpty) {
        for(int idx = 0; idx < _allergyTypeList.length; idx++) _allergyTypeList[idx] = false;
        _allergyTypeList[AllergyTypes.etc.index] = true;
      } else {
        _allergyTypeList[AllergyTypes.etc.index] = false;
      }
    });
  }
}
