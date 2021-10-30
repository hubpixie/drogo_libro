import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function(dynamic);

class SuplementInfoEditCell extends StatefulWidget {
  final ForyouInfo? itemValue;
  final CellEditingDelegate? onCellEditing;

  SuplementInfoEditCell({this.itemValue, this.onCellEditing});

  @override
  _SuplementInfoEditCellState createState() => _SuplementInfoEditCellState();
}

class _SuplementInfoEditCellState extends State<SuplementInfoEditCell> {
  late ForyouInfo _itemValue;
  late TextEditingController _etcTextController;
  late FocusNode _etcFocusNode;

  late StreamSubscription<bool> _keyboardSubscription;

  @override
  void initState() {
    _etcTextController = TextEditingController();
    if (widget.itemValue != null) {
      _etcTextController.text = widget.itemValue?.suplementEtcText ?? '';
    }

    // 入力フォーカス関しイベント処理
    _etcFocusNode = FocusNode();
    _etcFocusNode.addListener(() {
      if (!_etcFocusNode.hasFocus) {
        _etcTextOnEditigComplete();
      }
    });

    // キーボード開閉時監視イベント作成
    /*
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (!visible) {
          if (_etcFocusNode.hasFocus) {
            _etcTextOnEditigComplete();
          }
        }
      },
    );*/

    // Subscribe
    _keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      if (!visible) {
        if (_etcFocusNode.hasFocus) {
          _etcTextOnEditigComplete();
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _etcTextController.dispose();
    _etcFocusNode.dispose();
    _keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue!;
    _itemValue.suplementTypeList = _itemValue.suplementTypeList != null
        ? _itemValue.suplementTypeList
        : List.filled(SuplementTypes.values.length, false);

    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              " ",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Text(
            "複数項目がチェックできます",
            style: TextStyle(fontSize: 14.0),
          )
        ]),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                " ",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Checkbox(
              value:
                  _itemValue.suplementTypeList?[SuplementTypes.vitaminK.index],
              onChanged: (bool? value) => _checkboxOnChanged(
                  SuplementTypes.vitaminK.index, value ?? false),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: screenWidth - 130,
              height: 40,
              child: Text(
                SuplementTypes.vitaminK.name,
                style: TextStyle(fontSize: 15.0, height: 1.2),
                maxLines: 2,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                " ",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Checkbox(
              value: _itemValue
                  .suplementTypeList?[SuplementTypes.stJohnsWort.index],
              onChanged: (bool? value) => _checkboxOnChanged(
                  SuplementTypes.stJohnsWort.index, value ?? false),
            ),
            Text(
              SuplementTypes.stJohnsWort.name,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                " ",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Checkbox(
              value: _itemValue
                  .suplementTypeList?[SuplementTypes.gingyoLeafExtract.index],
              onChanged: (bool? value) => _checkboxOnChanged(
                  SuplementTypes.gingyoLeafExtract.index, value ?? false),
            ),
            Text(
              SuplementTypes.gingyoLeafExtract.name,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              " ",
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Checkbox(
            value: _itemValue.suplementTypeList?[SuplementTypes.etc.index],
            onChanged: (bool? value) =>
                _checkboxOnChanged(SuplementTypes.etc.index, value ?? false),
          ),
          Text(
            SuplementTypes.etc.name,
            style: TextStyle(fontSize: 16.0),
          ),
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
                hintText: '${SuplementTypes.etc.name}を入力',
              ),
              style: TextStyle(fontSize: 14.0, height: 1.0),
            ),
          ),
        ]),
      ],
    ));
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
    setState(() {
      // 相関チェック
      if (!value) {
        _etcTextController.text =
            (SuplementTypes.etc.index == index) ? '' : _etcTextController.text;
      }
      // 該当チェックボックスにチェック状態の更新を行う
      _itemValue.suplementTypeList?[index] = value;

      // テキストも更新する
      _itemValue.suplementEtcText = _etcTextController.text;

      // 親ページ画面へ反映する
      widget.onCellEditing?.call(_itemValue);
    });
  }

  /// ETCテキストフィールド入力完了時の処理
  void _etcTextOnEditigComplete() {
    setState(() {
      // 入力あり時、該当チェックボックスをONにする
      _itemValue.suplementTypeList?[SuplementTypes.etc.index] =
          _etcTextController.text.isNotEmpty;

      // 親ページへ反映さえる
      _itemValue.suplementEtcText = _etcTextController.text;
      widget.onCellEditing?.call(_itemValue);
    });
  }
}
