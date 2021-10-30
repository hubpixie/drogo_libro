import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function();

class MedicalHistoryPresnetCell extends StatefulWidget {
  final ForyouInfo? itemValue;
  final CellEditingDelegate? onCellEditing;

  MedicalHistoryPresnetCell({this.itemValue, this.onCellEditing});

  @override
  _MedicalHistoryPresentCellState createState() =>
      _MedicalHistoryPresentCellState();
}

class _MedicalHistoryPresentCellState extends State<MedicalHistoryPresnetCell> {
  ForyouInfo? _itemValue;
  late List<Color> _lableColorList;

  @override
  void initState() {
    _lableColorList =
        List.filled(MedicalHistoryTypes.values.length, Colors.black38);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _itemValue?.medicalHistoryTypeList =
        _itemValue?.medicalHistoryTypeList != null
            ? _itemValue?.medicalHistoryTypeList
            : List.filled(MedicalHistoryTypes.values.length, false);
    _itemValue?.medicalHdText =
        _itemValue?.medicalHdText != null ? _itemValue?.medicalHdText : '';
    _itemValue?.medicalEtcText =
        _itemValue?.medicalEtcText != null ? _itemValue?.medicalEtcText : '';
    _updateCheckTextColor();

    return Theme(
        data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.black38,
            disabledColor: Colors.grey[400]),
        child: Card(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "既往歴",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Spacer(),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  //編集ボタン
                  onPressed: () {
                    setState(() {
                      widget.onCellEditing?.call();
                    });
                  },
                  padding: new EdgeInsets.all(0.0),
                  icon: Icon(Icons.edit, color: Colors.black38, size: 20.0),
                ),
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
                  activeColor: Colors.black,
                  value: _itemValue?.medicalHistoryTypeList?[
                      MedicalHistoryTypes.hypertension.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.hypertension.index, value ?? false),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    MedicalHistoryTypes.hypertension.name,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: _lableColorList[
                            MedicalHistoryTypes.hypertension.index]),
                  ),
                ),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue?.medicalHistoryTypeList?[
                      MedicalHistoryTypes.hyperlipidemia.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.hyperlipidemia.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.hyperlipidemia.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[
                          MedicalHistoryTypes.hyperlipidemia.index]),
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
                  activeColor: Colors.black,
                  value: _itemValue
                      ?.medicalHistoryTypeList?[MedicalHistoryTypes.dm.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.dm.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.dm.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[MedicalHistoryTypes.dm.index]),
                ),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue?.medicalHistoryTypeList?[
                      MedicalHistoryTypes.glaucoma.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.glaucoma.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.glaucoma.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color:
                          _lableColorList[MedicalHistoryTypes.glaucoma.index]),
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
                  activeColor: Colors.black,
                  value: _itemValue
                      ?.medicalHistoryTypeList?[MedicalHistoryTypes.kd.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.kd.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.kd.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[MedicalHistoryTypes.kd.index]),
                ),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue?.medicalHistoryTypeList?[
                      MedicalHistoryTypes.asthma.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.asthma.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.asthma.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[MedicalHistoryTypes.asthma.index]),
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
                  activeColor: Colors.black,
                  value: _itemValue
                      ?.medicalHistoryTypeList?[MedicalHistoryTypes.bph.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.bph.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.bph.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[MedicalHistoryTypes.bph.index]),
                ),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue
                      ?.medicalHistoryTypeList?[MedicalHistoryTypes.ld.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.ld.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.ld.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[MedicalHistoryTypes.ld.index]),
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
                  activeColor: Colors.black,
                  value: _itemValue
                      ?.medicalHistoryTypeList?[MedicalHistoryTypes.gdu.index],
                  onChanged: (bool? value) => _checkboxOnChanged(
                      MedicalHistoryTypes.gdu.index, value ?? false),
                ),
                Text(
                  MedicalHistoryTypes.gdu.name,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: _lableColorList[MedicalHistoryTypes.gdu.index]),
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
                activeColor: Colors.black,
                value: _itemValue
                    ?.medicalHistoryTypeList?[MedicalHistoryTypes.hd.index],
                onChanged: (bool? value) => _checkboxOnChanged(
                    MedicalHistoryTypes.hd.index, value ?? false),
              ),
              Text(
                MedicalHistoryTypes.hd.name,
                style: TextStyle(
                    fontSize: 16.0,
                    color: _lableColorList[MedicalHistoryTypes.hd.index]),
              ),
              Text("  "),
              Container(
                width: MediaQuery.of(context).size.width - 190,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color:
                                _lableColorList[MedicalHistoryTypes.hd.index],
                            width: 1.0))),
                child: Text(
                  _itemValue?.medicalHdText ?? '',
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.0,
                    color: _lableColorList[MedicalHistoryTypes.hd.index],
                  ),
                ),
              ),
            ]),
            Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  " ",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Checkbox(
                activeColor: Colors.black,
                value: _itemValue
                    ?.medicalHistoryTypeList?[MedicalHistoryTypes.etc.index],
                onChanged: (bool? value) => _checkboxOnChanged(
                    MedicalHistoryTypes.etc.index, value ?? false),
              ),
              Text(
                MedicalHistoryTypes.etc.name,
                style: TextStyle(
                    fontSize: 16.0,
                    color: _lableColorList[MedicalHistoryTypes.etc.index]),
              ),
              Text("  "),
              Container(
                width: MediaQuery.of(context).size.width - 190,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color:
                                _lableColorList[MedicalHistoryTypes.etc.index],
                            width: 1.0))),
                child: Text(
                  _itemValue?.medicalEtcText ?? '',
                  maxLines: null,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.0,
                    color: _lableColorList[MedicalHistoryTypes.etc.index],
                  ),
                ),
              ),
            ]),
          ],
        )));
  }

  void _updateCheckTextColor() {
    for (int idx = 0; idx < _lableColorList.length; idx++) {
      _lableColorList[idx] = _itemValue?.medicalHistoryTypeList != null &&
              (_itemValue?.medicalHistoryTypeList?[idx] ?? false)
          ? Colors.black
          : Colors.black38;
    }
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {}
}
