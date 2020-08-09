import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function(dynamic);
class MedicalHistoryEditCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;

  MedicalHistoryEditCell({this.itemValue, this.onCellEditing});

  @override
  _MedicalHistoryEditCellState createState() => _MedicalHistoryEditCellState();
}

class _MedicalHistoryEditCellState extends State<MedicalHistoryEditCell> {
  ForyouInfo _itemValue;
  TextEditingController _hdTextController;
  TextEditingController _etcTextController;
  FocusNode _hdFocusNode;
  FocusNode _etcFocusNode;


  @override
  void initState() {
    _hdTextController = TextEditingController();
    _etcTextController = TextEditingController();
    if(widget.itemValue != null) {
      _hdTextController.text = widget.itemValue.medicalHdText;
      _etcTextController.text = widget.itemValue.medicalEtcText;
    }

    // 入力フォーカス関しイベント処理
    _hdFocusNode = FocusNode();
    _hdFocusNode.addListener(() {
      if(!_hdFocusNode.hasFocus) {
        _hdTextOnEditigComplete();
      }
    });
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
          if(_hdFocusNode.hasFocus) {
            _hdTextOnEditigComplete();
          }
          if(_etcFocusNode.hasFocus) {
            _etcTextOnEditigComplete();
          }
        }
      },
    );    

    super.initState();
  }

  @override
  void dispose() {
    _hdTextController.dispose();
    _etcTextController.dispose();
    _hdFocusNode.dispose();
    _etcFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _itemValue.medicalHistoryTypeList = _itemValue.medicalHistoryTypeList != null ? _itemValue.medicalHistoryTypeList : List.filled(MedicalHistoryTypes.values.length, false);

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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hypertension.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hypertension.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(MedicalHistoryTypes.hypertension.name, style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hyperlipidemia.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hyperlipidemia.index, value),
                ),
                Text(MedicalHistoryTypes.hyperlipidemia.name, style: TextStyle(fontSize: 16.0),),
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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.dm.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.dm.index, value),
                ),
                Text(MedicalHistoryTypes.dm.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.glaucoma.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.glaucoma.index, value),
                ),
                Text(MedicalHistoryTypes.glaucoma.name, style: TextStyle(fontSize: 16.0),),
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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.kd.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.kd.index, value),
                ),
                Text(MedicalHistoryTypes.kd.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.asthma.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.asthma.index, value),
                ),
                Text(MedicalHistoryTypes.asthma.name, style: TextStyle(fontSize: 16.0),),
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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.bph.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.bph.index, value),
                ),
                Text(MedicalHistoryTypes.bph.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.ld.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.ld.index, value),
                ),
                Text(MedicalHistoryTypes.ld.name, style: TextStyle(fontSize: 16.0),),
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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.gdu.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.gdu.index, value),
                ),
                Text(MedicalHistoryTypes.gdu.name, style: TextStyle(fontSize: 16.0),),
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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hd.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hd.index, value),
                ),
                Text(MedicalHistoryTypes.hd.name, style: TextStyle(fontSize: 16.0),),
                Text('  '),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _hdTextController,
                    focusNode: _hdFocusNode,
                    onEditingComplete: () => _hdTextOnEditigComplete(),
                    decoration: InputDecoration(
                      hintText: '${MedicalHistoryTypes.hd.name}を入力',
                    ),
                    style: TextStyle(fontSize: 14.0, height: 1.0),
                  ),
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
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.etc.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.etc.index, value),
                ),
                Text(MedicalHistoryTypes.etc.name, style: TextStyle(fontSize: 16.0),),
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
                      hintText: '${MedicalHistoryTypes.etc.name}を入力',
                    ),
                    style: TextStyle(fontSize: 14.0, height: 1.0),
                  ),
                ),
              ]
            ),
        ],)
      );
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
    setState(() {
      // 相関チェック
      if (!value) {
        _hdTextController.text = (MedicalHistoryTypes.hd.index == index) ? '' : _hdTextController.text;
        _etcTextController.text = (MedicalHistoryTypes.etc.index == index) ? '' : _etcTextController.text;
      }
      // 該当チェックボックスにチェック状態の更新を行う
      _itemValue.medicalHistoryTypeList[index] = value;

      // テキストも更新する
      _itemValue.medicalHdText = _hdTextController.text;
      _itemValue.medicalEtcText = _etcTextController.text;

      // 親ページ画面へ反映する
      widget.onCellEditing(_itemValue);
    });
  }

  /// ETCテキストフィールド入力完了時の処理
  void _hdTextOnEditigComplete() {
    setState(() {
      // 入力あり時、該当チェックボックスをONにする
      _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hd.index] = _hdTextController.text.isNotEmpty;

      // 親ページへ反映さえる
      _itemValue.medicalHdText = _hdTextController.text;
      widget.onCellEditing(_itemValue);
    });
  }

  /// ETCテキストフィールド入力完了時の処理
  void _etcTextOnEditigComplete() {
    setState(() {
      // 入力あり時、該当チェックボックスをONにする
      _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.etc.index] = _etcTextController.text.isNotEmpty;

      // 親ページへ反映さえる
      _itemValue.medicalEtcText = _etcTextController.text;
      widget.onCellEditing(_itemValue);
    });
  }

}
