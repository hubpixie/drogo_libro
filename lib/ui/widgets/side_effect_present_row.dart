import 'package:flutter/material.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

class SideEffectPresentRow extends StatelessWidget {
  final int rowIndex;
  final List<SideEffectInfo>? sideEffectInfoList;

  SideEffectPresentRow({required this.rowIndex, this.sideEffectInfoList});

  @override
  Widget build(BuildContext context) {
    if (this.sideEffectInfoList == null ||
        (this.sideEffectInfoList?.isEmpty ?? true)) return Container();

    return Row(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
      ),
      Text(
        "${this.rowIndex + 1}. ",
        style: TextStyle(fontSize: 16.0),
      ),
      Container(
        width: 100,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          this.sideEffectInfoList?[this.rowIndex].drogoName ?? '',
          maxLines: null,
          style: TextStyle(fontSize: 14.0, height: 1.0),
        ),
      ),
      Text(
        "  ",
        style: TextStyle(fontSize: 16.0),
      ),
      Container(
        width: MediaQuery.of(context).size.width - 200,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Text(
          this.sideEffectInfoList?[this.rowIndex].symptom ?? '',
          maxLines: null,
          style: TextStyle(fontSize: 14.0, height: 1.0),
        ),
      ),
    ]);
  }
}
