import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function();
class BloodTypePresentCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;

  BloodTypePresentCell({this.itemValue, this.onCellEditing});

  @override
  _BloodTypePresentCellState createState() => _BloodTypePresentCellState();
}

class _BloodTypePresentCellState extends State<BloodTypePresentCell> {
  ForyouInfo _itemValue;
  List<Color> _lableColorList;

  @override
  void initState() {
    _lableColorList = List.filled(BloodTypes.values.length, Colors.black38);
    super.initState();
  }

  @override
  void dispose() {
    _lableColorList = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _updateRadioTextColor();
    
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
                  child: Text("血液型",
                    style: TextStyle(fontSize: 20.0),),
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
                    style: TextStyle(fontSize: 20.0),),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.a,
                  groupValue: _itemValue.bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.a.name, 
                    style: TextStyle(fontSize: 20.0, color: _lableColorList[BloodTypes.a.index]),
                  ),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.b,
                  groupValue: _itemValue.bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.b.name, 
                    style: TextStyle(fontSize: 20.0, color: _lableColorList[BloodTypes.b.index]),
                  ),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.ab,
                  groupValue: _itemValue.bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.ab.name, 
                    style: TextStyle(fontSize: 20.0, color: _lableColorList[BloodTypes.ab.index]),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(" ",
                    style: TextStyle(fontSize: 20.0),),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.o,
                  groupValue: _itemValue.bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.o.name, 
                    style: TextStyle(fontSize: 20.0, color: _lableColorList[BloodTypes.o.index]),
                  ),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.rhPlus,
                  groupValue: _itemValue.bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.rhPlus.name, 
                    style: TextStyle(fontSize: 20.0, color: _lableColorList[BloodTypes.rhPlus.index]),
                  ),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.rhMinus,
                  groupValue: _itemValue.bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.rhMinus.name, 
                    style: TextStyle(fontSize: 20.0, color: _lableColorList[BloodTypes.rhMinus.index]),
                  ),
                ),
              ],
            ),
        ],)
      )
    );
  }

  void _updateRadioTextColor() {
    for (int idx = 0; idx < _lableColorList.length; idx++) {
      _lableColorList[idx] = Colors.black38;
    }
    if(_itemValue != null && _itemValue.bloodType != null) {
      _lableColorList[_itemValue.bloodType.index] = Colors.black;
    }
  }

  void _handleRadio(BloodTypes value) {
    setState(() {
    });
  }
}
