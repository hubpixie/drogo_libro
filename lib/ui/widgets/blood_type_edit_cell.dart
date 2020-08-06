import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';

typedef CellEditingDelegate = void Function(BloodTypes);
class BloodTypeEditCell extends StatefulWidget {
  final BloodTypes bloodType;
  final CellEditingDelegate onCellEditing;

  BloodTypeEditCell({this.bloodType, this.onCellEditing});

  @override
  _BloodTypeEditCellState createState() => _BloodTypeEditCellState();
}

class _BloodTypeEditCellState extends State<BloodTypeEditCell> {
  BloodTypes _bloodType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloodType = widget.bloodType;

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
                Text("次の○のいずれかをチェックして下さい",
                    style: TextStyle(fontSize: 14.0),)
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
                  value: BloodTypes.a,
                  groupValue: _bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.a.name, 
                    style: TextStyle(fontSize: 20.0,),
                  ),
                ),
                Radio(
                  value: BloodTypes.b,
                  groupValue: _bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.b.name, 
                    style: TextStyle(fontSize: 20.0,),
                  ),
                ),
                Radio(
                  value: BloodTypes.ab,
                  groupValue: _bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.ab.name, 
                    style: TextStyle(fontSize: 20.0,),
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
                  value: BloodTypes.o,
                  groupValue: _bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.o.name, 
                    style: TextStyle(fontSize: 20.0,),
                  ),
                ),
                Radio(
                  value: BloodTypes.rhPlus,
                  groupValue: _bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.rhPlus.name, 
                    style: TextStyle(fontSize: 20.0,),
                  ),
                ),
                Radio(
                  value: BloodTypes.rhMinus,
                  groupValue: _bloodType,
                  onChanged: (BloodTypes value) => _handleRadio(value),
                ),
                Container(
                  width: 40,
                  child: Text(BloodTypes.rhMinus.name, 
                    style: TextStyle(fontSize: 20.0,),
                  ),
                ),
              ],
            ),
        ],)
      );
  }

  void _handleRadio(BloodTypes value) {
    setState(() {
      widget.onCellEditing(value);
      _bloodType = value;
    });
  }
}
