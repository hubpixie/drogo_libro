import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';
typedef CellEditingDelegate = void Function();
class AllergyHistoryPresentCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;

  AllergyHistoryPresentCell({this.itemValue, this.onCellEditing});

  @override
  _AllergyHistoryPresentCellState createState() => _AllergyHistoryPresentCellState();
}

class _AllergyHistoryPresentCellState extends State<AllergyHistoryPresentCell> {
  ForyouInfo _itemValue;
  List<Color> _lableColorList;


  @override
  void initState() {
    _lableColorList = List.filled(AllergyTypes.values.length, Colors.black38);
   
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
    _itemValue.allergyHistoryTypeList = _itemValue.allergyHistoryTypeList != null ? _itemValue.allergyHistoryTypeList : List.filled(AllergyTypes.values.length, false);
    _itemValue.allergyEtcText = _itemValue.allergyEtcText != null ? _itemValue.allergyEtcText : '';
    _updateCheckTextColor();

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
                  child: Text("アレルギー",
                    style: TextStyle(fontSize: 20.0),),
                ),
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(left: screenWidth - 180),
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
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.milk.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.milk.index, value),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(AllergyTypes.milk.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[AllergyTypes.milk.index]),),
                ),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.egg.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.egg.index, value),
                ),
                Text(AllergyTypes.egg.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[AllergyTypes.egg.index]),),
                Checkbox(
                  activeColor: Colors.black,
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.pollinosis.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.pollinosis.index, value),
                ),
                Text(AllergyTypes.pollinosis.name, style: TextStyle(fontSize: 16.0, color: _lableColorList[AllergyTypes.pollinosis.index]),),
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
                  value: _itemValue.allergyHistoryTypeList[AllergyTypes.etc.index],
                  onChanged: (bool value) => _checkboxOnChanged(AllergyTypes.etc.index, value),
                ),
                Text(AllergyTypes.etc.name, style: TextStyle(fontSize: 16.0,color: _lableColorList[AllergyTypes.etc.index]),),
                Text('  '),
                Container(
                  width: MediaQuery.of(context).size.width - 190,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _lableColorList[AllergyTypes.etc.index],
                        width: 1.0))),
                  child: Text(_itemValue.allergyEtcText,
                    maxLines: null,
                    style: TextStyle(fontSize: 14.0, height: 1.0,
                      color: _lableColorList[AllergyTypes.etc.index],
                    ),
                  ),
                ),
              ]
            ),
          ],
        )
      )
    );
  }

  void _updateCheckTextColor() {
    for (int idx = 0; idx < _lableColorList.length; idx++) {
      _lableColorList[idx] = _itemValue.allergyHistoryTypeList != null && _itemValue.allergyHistoryTypeList[idx] ? Colors.black : Colors.black38;
    }
  }

  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
  }
}
