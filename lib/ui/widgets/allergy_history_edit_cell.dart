import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function(dynamic);
class AllergyHistoryEditCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;

  AllergyHistoryEditCell({this.itemValue, this.onCellEditing});

  @override
  _AllergyHistoryEditCellState createState() => _AllergyHistoryEditCellState();
}

class _AllergyHistoryEditCellState extends State<AllergyHistoryEditCell> {
  ForyouInfo _itemValue;
  TextEditingController _etcTextController;
  FocusNode _etcFocusNode;

  @override
  void initState() {
  _etcTextController = TextEditingController();
    if(widget.itemValue != null) {
      _etcTextController.text = widget.itemValue.allergyEtcText;
    }

    _etcFocusNode = FocusNode();
    _etcFocusNode.addListener(() {
      if(!_etcFocusNode.hasFocus) {
        _etcTextOnEditigComplete();
      }
    });
    // キーボード開閉時監視イベント作成
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if(!visible) {
          _etcTextOnEditigComplete();
        }
      },
    );    
    super.initState();
  }

  @override
  void dispose() {
    _etcTextController.dispose();
    _etcFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _itemValue.allergyHistoryTypeList = _itemValue.allergyHistoryTypeList != null ? _itemValue.allergyHistoryTypeList : List.filled(AllergyTypes.values.length, false);

    return 
      Card(child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(" ",
                    style: TextStyle(fontSize: 20.0),),
                ),
                Text("複数項目がチェックできます",
                    style: TextStyle(fontSize: 14.0),)
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
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.milk.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.milk.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AllergyTypes.milk.name, style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.egg.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.egg.index, value),
                ),
                Text(AllergyTypes.egg.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.pollinosis.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.pollinosis.index, value),
                ),
                Text(AllergyTypes.pollinosis.name, style: TextStyle(fontSize: 16.0),),
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
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.etc.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.etc.index, value),
                ),
                Text(AllergyTypes.etc.name, style: TextStyle(fontSize: 16.0),),
                Text('  '),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _etcTextController,
                    focusNode: _etcFocusNode,
                    onEditingComplete: () => _etcTextOnEditigComplete(),
                    decoration: InputDecoration(
                      hintText: '${AllergyTypes.etc.name}を入力',
                    ),
                    style: TextStyle(fontSize: 14.0, height: 1.0),
                  ),
                ),
              ]
            ),
          ],
        )
      );
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
    setState(() {
      // 相関チェック
      if (!value) {
        _etcTextController.text = (AllergyTypes.etc.index == index) ? '' : _etcTextController.text;
      }
      // 該当チェックボックスにチェック状態の更新を行う
      _itemValue.allergyHistoryTypeList[index] = value;

      // テキストも更新する
      _itemValue.allergyEtcText = _etcTextController.text;

      // 親ページ画面へ反映する
      widget.onCellEditing(_itemValue);
    });
  }

  /// ETCテキストフィールド入力完了時の処理
  void _etcTextOnEditigComplete() {
    setState(() {
      // 入力あり時、該当チェックボックスをONにする
      _itemValue.allergyHistoryTypeList[AllergyTypes.etc.index] = _etcTextController.text.isNotEmpty;

      // 親ページへ反映さえる
      _itemValue.allergyEtcText = _etcTextController.text;
      widget.onCellEditing(_itemValue);
    });
  }

}
