import 'package:flutter/material.dart';

import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function(dynamic);
class SideEffectEditRow  extends StatefulWidget {
  final int rowIndex;
  final List<SideEffectInfo> sideEffectInfoList;
  final CellEditingDelegate onCellEditing;

  SideEffectEditRow({this.rowIndex, this.sideEffectInfoList, this.onCellEditing});

  @override
  _SideEffectEditRowState createState() => _SideEffectEditRowState();
}


class _SideEffectEditRowState extends State<SideEffectEditRow> {
  List<TextEditingController> _textControllers;
  List<String> _fieldLabels;
  List<String> _fieldHints;

  static const int _kIndexDrogo = 0;
  static const int _kIndexSymptom = 1;

  @override
  void initState() {
    // ラベルとヒント用テキスト
    _fieldLabels = ['くすり名', '症状'];
    _fieldHints = ['くすり名を入力', '[いつごろ]症状を入力'];

    // テキスト入力コントローラの初期化
    _textControllers = [TextEditingController(), TextEditingController()];
    _textControllers[_kIndexDrogo] = TextEditingController(
      text: widget.sideEffectInfoList[widget.rowIndex].drogoName);
    _textControllers[_kIndexSymptom] = TextEditingController(
      text: widget.sideEffectInfoList[widget.rowIndex].symptom);

    // テキスト入力コントローラの監視イベント
    _textControllers[_kIndexDrogo].addListener(() { 
      widget.onCellEditing(SideEffectInfo(id: widget.sideEffectInfoList[widget.rowIndex].id, drogoName: _textControllers[_kIndexDrogo].text, 
        symptom: _textControllers[_kIndexSymptom].text));
    });
    _textControllers[_kIndexSymptom].addListener(() { 
      widget.onCellEditing(SideEffectInfo(id: widget.sideEffectInfoList[widget.rowIndex].id, drogoName: _textControllers[_kIndexDrogo].text, 
        symptom: _textControllers[_kIndexSymptom].text));
    });
    super.initState();
   }

  @override
  void dispose() {
    _textControllers[_kIndexDrogo].dispose();
    _textControllers[_kIndexSymptom].dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildInputTextForm(context, _kIndexDrogo),
        _buildInputTextForm(context, _kIndexSymptom),
        Padding(padding: EdgeInsets.all(10.0),),
      ],
    );
  }

  Widget _buildInputTextForm(BuildContext context, int index) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 2.0),
          width: MediaQuery.of(context).size.width - 70,
          child: GestureDetector(
            onTap: () => _showDialog(context, index),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _textControllers[index],
                maxLines: null,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "${_fieldLabels[index]} [${widget.rowIndex+1}]",
                  hintText: _fieldHints[index],
                  fillColor: Colors.white,
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(4.0),
                    borderSide: new BorderSide(
                      color: Colors.grey[300], width: 0.5,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black38, fontSize: 14.0),
              ),
            ),
          ),
        ),
      ]
    );
  }

  _showDialog(BuildContext context, int index) async {
    TextEditingController te = TextEditingController(text: _textControllers[index].text);
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextFormField(
                keyboardType: TextInputType.text,
                maxLines: null,
                controller: te,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: _fieldLabels[index], 
                    hintText: _fieldHints[index]),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                setState(() {
                  // キーボードを閉じる
                  FocusScope.of(context).unfocus();
                  // ダイアログを閉じる
                  Navigator.pop(context);
                });
              }),
          new FlatButton(
              child: const Text('OK'),
              onPressed: () async{
                setState(() {
                  // キーボードを閉じる
                  FocusScope.of(context).unfocus();
                  // ダイアログを閉じる
                  Navigator.pop(context);
                  // 入力元に代入する
                  _textControllers[index].text = te.text;
                });
              })
        ],
      ),
    );
  }
}