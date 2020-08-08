import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

typedef CellEditingDelegate = void Function();
class MedicalHistoryPresnetCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;

  MedicalHistoryPresnetCell({this.itemValue, this.onCellEditing});

  @override
  _MedicalHistoryPresentCellState createState() => _MedicalHistoryPresentCellState();
}

class _MedicalHistoryPresentCellState extends State<MedicalHistoryPresnetCell> {
  ForyouInfo _itemValue;
  List<Color> _lableColorList;


  @override
  void initState() {
    _lableColorList = List.filled(MedicalHistoryTypes.values.length, Colors.black38);
   
    super.initState();
}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _itemValue.medicalHistoryTypeList = _itemValue.medicalHistoryTypeList != null ? _itemValue.medicalHistoryTypeList : List.filled(MedicalHistoryTypes.values.length, false);
    _itemValue.medicalHdText = _itemValue.medicalHdText != null ? _itemValue.medicalHdText : '';
    _itemValue.medicalEtcText = _itemValue.medicalEtcText != null ? _itemValue.medicalEtcText : '';

    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: Colors.black38,
        disabledColor: Colors.grey[400]
      ),
      child: Card(child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("既往歴",
                    style: TextStyle(fontSize: 20.0),),
                ),
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(left: screenWidth - 140),
                  alignment: Alignment.bottomCenter,
                  child: IconButton( //編集ボタン
                    onPressed: () {
                      setState(() {
                        widget.onCellEditing();
                      });
                    },
                    padding: new EdgeInsets.all(0.0),
                    icon: Icon(Icons.edit, color: Colors.black38, size: 20.0),
                    ),
                )
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hypertension.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hypertension.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(MedicalHistoryTypes.hypertension.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.hypertension.index]),),
                ),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hyperlipidemia.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hyperlipidemia.index, value),
                ),
                Text(MedicalHistoryTypes.hyperlipidemia.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.hyperlipidemia.index]),),
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.dm.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.dm.index, value),
                ),
                Text(MedicalHistoryTypes.dm.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.dm.index]),),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.glaucoma.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.glaucoma.index, value),
                ),
                Text(MedicalHistoryTypes.glaucoma.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.glaucoma.index]),),
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.kd.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.kd.index, value),
                ),
                Text(MedicalHistoryTypes.kd.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.kd.index]),),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.asthma.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.asthma.index, value),
                ),
                Text(MedicalHistoryTypes.asthma.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.asthma.index]),),
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.bph.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.bph.index, value),
                ),
                Text(MedicalHistoryTypes.bph.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.bph.index]),),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.ld.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.ld.index, value),
                ),
                Text(MedicalHistoryTypes.ld.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.ld.index]),),
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.gdu.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.gdu.index, value),
                ),
                Text(MedicalHistoryTypes.gdu.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.gdu.index]),),
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.hd.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.hd.index, value),
                ),
                Text(MedicalHistoryTypes.hd.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[MedicalHistoryTypes.hd.index]),),
                Text(" (", style: TextStyle(fontSize: 16.0),),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text(_itemValue.medicalHdText,
                    maxLines: null,
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
                  activeColor: Colors.black,
                  value: _itemValue.medicalHistoryTypeList[MedicalHistoryTypes.etc.index],
                  onChanged: (bool value) => _checkboxOnChanged(MedicalHistoryTypes.etc.index, value),
                ),
                Text(MedicalHistoryTypes.etc.name, style: TextStyle(fontSize: 16.0,color: _lableColorList[MedicalHistoryTypes.etc.index]),),
                Text(" (", style: TextStyle(fontSize: 16.0),),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(_itemValue.medicalEtcText,
                    maxLines: null,
                    style: TextStyle(fontSize: 12.0, height: 1.0),
                  ),
                ),
                Text(" )", style: TextStyle(fontSize: 16.0),),
              ]
            ),
        ],)
      )
    );
  }

  void _updateRadioTextColor() {
    for (int idx = 0; idx < _lableColorList.length; idx++) {
      _lableColorList[idx] = _itemValue.medicalHistoryTypeList != null && _itemValue.medicalHistoryTypeList[idx] ? Colors.black : Colors.black38;
    }
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
  }
}
