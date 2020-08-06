import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

class MedicalHistoryEditCell extends StatefulWidget {

  @override
  _MedicalHistoryEditCellState createState() => _MedicalHistoryEditCellState();
}

class _MedicalHistoryEditCellState extends State<MedicalHistoryEditCell> {
  List<bool> _medicalHistoryTypeList;
  TextEditingController _hdTextController;
  TextEditingController _etcTextController;


  @override
  void initState() {
    super.initState();

    _medicalHistoryTypeList = List.filled(MedicalHistoryTypes.values.length, false);
    _hdTextController = TextEditingController();
    _etcTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _medicalHistoryTypeList = null;
    _hdTextController = null;
    _etcTextController = null;
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
                  child: Text("既往歴",
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.hypertension.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hypertension.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(MedicalHistoryTypes.hypertension.name, style: TextStyle(fontSize: 16.0),),
                ),
                Checkbox(
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.hyperlipidemia.index],
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.dm.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.dm.index, value),
                ),
                Text(MedicalHistoryTypes.dm.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.glaucoma.index],
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.kd.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.kd.index, value),
                ),
                Text(MedicalHistoryTypes.kd.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.asthma.index],
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.bph.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.bph.index, value),
                ),
                Text(MedicalHistoryTypes.bph.name, style: TextStyle(fontSize: 16.0),),
                Checkbox(
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.ld.index],
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.gdu.index],
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.hd.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hd.index, value),
                ),
                Text(MedicalHistoryTypes.hd.name, style: TextStyle(fontSize: 16.0),),
                Text(" (", style: TextStyle(fontSize: 16.0),),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _hdTextController,
                    onChanged: (String text) {
                      setState(() {
                        _medicalHistoryTypeList[MedicalHistoryTypes.hd.index] = text.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '${MedicalHistoryTypes.hd.name}を入力',
                    ),
                    style: TextStyle(fontSize: 12.0, height: 1.0),
                  ),
                ),
                Text(" )", style: TextStyle(fontSize: 16.0),),
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
                  value: _medicalHistoryTypeList[MedicalHistoryTypes.etc.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.etc.index, value),
                ),
                Text(MedicalHistoryTypes.etc.name, style: TextStyle(fontSize: 16.0),),
                Text(" (", style: TextStyle(fontSize: 16.0),),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _etcTextController,
                    onChanged: (String text) {
                      setState(() {
                        _medicalHistoryTypeList[MedicalHistoryTypes.etc.index] = text.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: '${MedicalHistoryTypes.etc.name}を入力',
                    ),
                    style: TextStyle(fontSize: 12.0, height: 1.0),
                  ),
                ),
                Text(" )", style: TextStyle(fontSize: 16.0),),
              ]
            ),
        ],)
      );
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
    setState(() {
      // キーボードを閉じる
      FocusScope.of(context).unfocus();

      // 該当チェックボックスにチェック状態の更新を行う
      _medicalHistoryTypeList[index] = value;

      // 相関チェック
      if (!value) {
        _hdTextController.text = (MedicalHistoryTypes.hd.index == index) ? '' : _hdTextController.text;
        _etcTextController.text = (MedicalHistoryTypes.etc.index == index) ? '' : _etcTextController.text;
      }
    });
  }
}
