import 'package:flutter/material.dart';

import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/ui/widgets/side_effect_edit_row.dart';

typedef CellEditingDelegate = void Function(dynamic);
class SideEffectEditCell extends StatefulWidget {
  final ForyouInfo itemValue;
  final CellEditingDelegate onCellEditing;
  final  GlobalKey<ScaffoldState> scaffoldKey;

  SideEffectEditCell({this.itemValue, this.onCellEditing, this.scaffoldKey});

  @override
  _SideEffectEditCellState createState() => _SideEffectEditCellState();
}

class _SideEffectEditCellState extends State<SideEffectEditCell> {
  ForyouInfo _itemValue;

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
    double screenWidth = MediaQuery.of(context).size.width;
    _itemValue = widget.itemValue == null ? ForyouInfo() : widget.itemValue;
    _itemValue.sideEffectList = _itemValue.sideEffectList != null ? _itemValue.sideEffectList : <SideEffectInfo>[];

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(" "),
              ),
              Text("最大${SideEffectInfo.kListMxLength}個まで記載可能",
                  style: TextStyle(fontSize: 14.0),),
              _itemValue.sideEffectList.length < SideEffectInfo.kListMxLength ? Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(left: screenWidth - 230), 
                height: 25,
                child: IconButton(
                  onPressed: () async {
                    setState(() {
                      _itemValue.sideEffectList.add(SideEffectInfo());
                      // 呼び元に返す
                      widget.onCellEditing(_itemValue);
                    });
                  },
                  padding: new EdgeInsets.all(0.0),
                  icon: Icon(Icons.add, color: Colors.blueAccent,size: 25.0),
                  ),
              ) : Container(),
            ]
          ),
          Container(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _itemValue.sideEffectList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: ObjectKey(_itemValue.sideEffectList[index]),
                    child: _buildSideEffectRow(context, index),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) async{
                      setState(() {
                        // 当該行を削除する
                        var seInfo = _itemValue.sideEffectList.removeAt(index);

                        widget.scaffoldKey.currentState..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text("以下の行を削除しました。\n　くすり名: ${seInfo.drogoName} \n　症状：${seInfo.symptom}"),
                            action: SnackBarAction(
                              label: "元に戻す",
                              onPressed: () async => setState(() {
                                 _itemValue.sideEffectList.insert(index, seInfo);
                                  widget.onCellEditing(_itemValue);
                              }) // this is what you needed
                            ),
                            duration: Duration(seconds: 5),
                          ),
                        ).closed.then((value) {
                            //Navigator.of(context).pop(_itemValue);
                            // 呼び元に返す
                            widget.onCellEditing(_itemValue);
                            return Future.value(false);
                        });
                      });
                    },
                  );
                },
            ),
          ),
        ]
      )
    );
  }

  Widget _buildSideEffectRow(BuildContext context, int index) {
    return SideEffectEditRow(sideEffectInfo: _itemValue.sideEffectList[index],
      onCellEditing: (newValue) {
        SideEffectInfo value = newValue;
        _itemValue.sideEffectList[index].id = index + 1;
        if(value != null) {
          _itemValue.sideEffectList[index].drogoName = value.drogoName;
          _itemValue.sideEffectList[index].symptom = value.symptom;

          // 親ページ画面へ反映する
          widget.onCellEditing(_itemValue);
        }
    });
  }

}
