import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function();
class SuplementInfoPresentCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;

  SuplementInfoPresentCell({this.itemValue, this.onCellEditing});

  @override
  _SuplementInfoPresentCellState createState() => _SuplementInfoPresentCellState();
}

class _SuplementInfoPresentCellState extends State<SuplementInfoPresentCell> {
  ForyouInfo _itemValue;
  List<Color> _lableColorList;



  @override
  void initState() {
    _lableColorList = List.filled(SuplementTypes.values.length, Colors.black38);
   
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
    _itemValue.suplementTypeList = _itemValue.suplementTypeList != null ? _itemValue.suplementTypeList : List.filled(SuplementTypes.values.length, false);
    _itemValue.suplementEtcText = _itemValue.suplementEtcText != null ? _itemValue.suplementEtcText : '';
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
                child: Text("使用中のサプリメント等",
                  style: TextStyle(fontSize: 20.0),),
              ),
              Padding( padding: const EdgeInsets.only(top: 10.0),
              ),
              Spacer(),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 20),
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
                value: _itemValue.suplementTypeList[SuplementTypes.vitaminK.index],
                onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.vitaminK.index, value),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: screenWidth - 130,
                height: 40,
                child: Text(SuplementTypes.vitaminK.name, 
                  style: TextStyle(fontSize: 15.0, height: 1.2, 
                  color: _lableColorList[SuplementTypes.vitaminK.index]), 
                  maxLines: 2, ),
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
                activeColor: Colors.black,
                value: _itemValue.suplementTypeList[SuplementTypes.stJohnsWort.index],
                onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.stJohnsWort.index, value),
              ),
              Text(SuplementTypes.stJohnsWort.name, 
                style: TextStyle(fontSize: 16.0,
                  color: _lableColorList[SuplementTypes.stJohnsWort.index]), 
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
                activeColor: Colors.black,
                value: _itemValue.suplementTypeList[SuplementTypes.gingyoLeafExtract.index],
                onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.gingyoLeafExtract.index, value),
              ),
              Text(SuplementTypes.gingyoLeafExtract.name, 
                style: TextStyle(fontSize: 16.0, 
                  color: _lableColorList[SuplementTypes.gingyoLeafExtract.index]), 
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
                activeColor: Colors.black,
                value: _itemValue.suplementTypeList[SuplementTypes.etc.index],
                onChanged: (bool value) => _checkboxOnChanged(SuplementTypes.etc.index, value),
              ),
              Text("${SuplementTypes.etc.name}",
                style: TextStyle(fontSize: 16.0,
                  color: _lableColorList[SuplementTypes.etc.index]), 
              ),
              Text('  '),
              Container(
                width: MediaQuery.of(context).size.width - 190,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: _lableColorList[SuplementTypes.etc.index],
                      width: 1.0))),
                child: Text(_itemValue.suplementEtcText,
                  maxLines: null,
                  style: TextStyle(fontSize: 14.0, height: 1.0,
                    color: _lableColorList[SuplementTypes.etc.index],
                  ),
                ),
              ),
            ]
          )
        ],
      )
     )
    );
  }

  void _updateCheckTextColor() {
    for (int idx = 0; idx < _lableColorList.length; idx++) {
      _lableColorList[idx] = _itemValue.suplementTypeList != null && _itemValue.suplementTypeList[idx] ? Colors.black : Colors.black38;
    }
  }
  // チェックボックス選択時の処理
  void _checkboxOnChanged(int index, bool value) {
  }
}
