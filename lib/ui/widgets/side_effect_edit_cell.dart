import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/ui/widgets/side_effect_edit_row.dart';

typedef CellEditingDelegate = void Function(dynamic);

class SideEffectEditCell extends StatefulWidget {
  final ForyouInfo? itemValue;
  final CellEditingDelegate? onCellEditing;

  SideEffectEditCell({Key? key, this.itemValue, this.onCellEditing})
      : super(key: key);

  @override
  SideEffectEditCellState createState() => SideEffectEditCellState();
}

class SideEffectEditCellState extends State<SideEffectEditCell> {
  ForyouInfo? _itemValue;

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
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _itemValue?.sideEffectList = _itemValue?.sideEffectList != null
        ? _itemValue?.sideEffectList
        : <SideEffectInfo>[];
    return Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(" "),
            ),
            Text(
              "最大${SideEffectInfo.kListMxLength}個まで記載可能",
              style: TextStyle(fontSize: 14.0),
            ),
          ]),
          Container(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _itemValue?.sideEffectList?.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: _buildSideEffectRow(context, index),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: '削除',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        // 行の削除
                        setState(() {
                          _itemValue?.sideEffectList?.removeAt(index);
                          // 呼び元に返す
                          widget.onCellEditing?.call(_itemValue);
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ]));
  }

  Widget _buildSideEffectRow(BuildContext context, int index) {
    return SideEffectEditRow(
        rowIndex: index,
        sideEffectInfoList: _itemValue?.sideEffectList ?? [],
        onCellEditing: (newValue) {
          SideEffectInfo? value = newValue;
          _itemValue?.sideEffectList?[index].id = index + 1;
          if (value != null) {
            _itemValue?.sideEffectList?[index].drogoName = value.drogoName;
            _itemValue?.sideEffectList?[index].symptom = value.symptom;

            // 親ページ画面へ反映する
            widget.onCellEditing?.call(_itemValue);
          }
        });
  }

  void addingRow(int rows) {
    setState(() {
      if (rows > (_itemValue?.sideEffectList?.length ?? 0)) {
        _itemValue?.sideEffectList?.add(SideEffectInfo());
        // 呼び元に返す
        widget.onCellEditing?.call(_itemValue);
      }
    });
  }
}
