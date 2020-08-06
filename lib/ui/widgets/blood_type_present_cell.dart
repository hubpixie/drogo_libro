import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

typedef CellEditingDelegate = void Function();
class BloodTypePresentCell extends StatefulWidget {
  final BloodTypes bloodType;
  final CellEditingDelegate onCellEditing;

  BloodTypePresentCell({this.bloodType, this.onCellEditing});

  @override
  _BloodTypePresentCellState createState() => _BloodTypePresentCellState();
}

class _BloodTypePresentCellState extends State<BloodTypePresentCell> {
  BloodTypes _bloodType;
  List<Color> _lableColorList;

  @override
  void initState() {
    _lableColorList = List.filled(6, Colors.black38);
    super.initState();
  }

  @override
  void dispose() {
    _lableColorList = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    _bloodType = widget.bloodType;
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
                    style: TextStyle(fontSize: 20.0),),
                ),
                Radio(
                  activeColor: Colors.black,
                  value: BloodTypes.a,
                  groupValue: _bloodType,
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
                  groupValue: _bloodType,
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
                  groupValue: _bloodType,
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
                  groupValue: _bloodType,
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
                  groupValue: _bloodType,
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
                  groupValue: _bloodType,
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
    if(_bloodType != null) {
      _lableColorList[_bloodType.index] = Colors.black;
    }
  }

  void _handleRadio(BloodTypes value) {
    setState(() {
      // _bloodType = value;
      // _updateRadioTextColor();
    });
  }
}
