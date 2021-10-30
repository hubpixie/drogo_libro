import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

typedef CellEditingDelegate = void Function(dynamic);

class BloodTypeEditCell extends StatefulWidget {
  final ForyouInfo? itemValue;
  final CellEditingDelegate? onCellEditing;

  BloodTypeEditCell({this.itemValue, this.onCellEditing});

  @override
  _BloodTypeEditCellState createState() => _BloodTypeEditCellState();
}

class _BloodTypeEditCellState extends State<BloodTypeEditCell> {
  ForyouInfo? _itemValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
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
            "次の○のいずれかをチェックして下さい",
            style: TextStyle(fontSize: 14.0),
          )
        ]),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                " ",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Radio(
              value: BloodTypes.a,
              groupValue: _itemValue?.bloodType,
              onChanged: (BloodTypes? value) => _radioOnChanged(value),
            ),
            Container(
              width: 40,
              child: Text(
                BloodTypes.a.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Radio(
              value: BloodTypes.b,
              groupValue: _itemValue?.bloodType,
              onChanged: (BloodTypes? value) => _radioOnChanged(value),
            ),
            Container(
              width: 40,
              child: Text(
                BloodTypes.b.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Radio(
              value: BloodTypes.ab,
              groupValue: _itemValue?.bloodType,
              onChanged: (BloodTypes? value) => _radioOnChanged(value),
            ),
            Container(
              width: 40,
              child: Text(
                BloodTypes.ab.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
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
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Radio(
              value: BloodTypes.o,
              groupValue: _itemValue?.bloodType,
              onChanged: (BloodTypes? value) => _radioOnChanged(value),
            ),
            Container(
              width: 40,
              child: Text(
                BloodTypes.o.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Radio(
              value: BloodTypes.rhPlus,
              groupValue: _itemValue?.bloodType,
              onChanged: (BloodTypes? value) => _radioOnChanged(value),
            ),
            Container(
              width: 40,
              child: Text(
                BloodTypes.rhPlus.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Radio(
              value: BloodTypes.rhMinus,
              groupValue: _itemValue?.bloodType,
              onChanged: (BloodTypes? value) => _radioOnChanged(value),
            ),
            Container(
              width: 40,
              child: Text(
                BloodTypes.rhMinus.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }

  void _radioOnChanged(BloodTypes? value) {
    setState(() {
      _itemValue?.bloodType = value;
      widget.onCellEditing?.call(_itemValue);
    });
  }
}
