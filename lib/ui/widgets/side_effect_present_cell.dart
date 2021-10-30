import 'package:flutter/material.dart';

import 'package:drogo_libro/core/models/foryou_info.dart';

import 'package:drogo_libro/ui/widgets/side_effect_present_row.dart';

typedef CellEditingDelegate = void Function();

class SideEffectPresentCell extends StatefulWidget {
  final ForyouInfo? itemValue;
  final CellEditingDelegate? onCellEditing;

  SideEffectPresentCell({this.itemValue, this.onCellEditing});

  @override
  _SideEffectPresentCellState createState() => _SideEffectPresentCellState();
}

class _SideEffectPresentCellState extends State<SideEffectPresentCell> {
  late ForyouInfo _itemValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue!;
    _itemValue.sideEffectList =
        _itemValue.sideEffectList != null ? _itemValue.sideEffectList : [];

    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "副作用",
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
            ),
          ]),
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
            ),
            Container(
              alignment: Alignment.center,
              width: 100,
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Text(
                'おくすり名',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              alignment: Alignment.center,
              //width: _screenWidth - 220,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '[いつごろ]症状',
                textAlign: TextAlign.center,
              ),
            ),
          ]),
          Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Divider(
              color: Colors.black26,
            ),
          ),
          _itemValue.sideEffectList?.isNotEmpty ?? false
              ? Container(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _itemValue.sideEffectList?.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return SideEffectPresentRow(
                        rowIndex: index,
                        sideEffectInfoList: _itemValue.sideEffectList ?? [],
                      );
                    },
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  alignment: Alignment.center,
                  child: Text(
                    '該当データがありません',
                    textAlign: TextAlign.center,
                  ),
                ),
        ]));
  }
}
