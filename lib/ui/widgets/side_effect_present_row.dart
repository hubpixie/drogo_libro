import 'package:flutter/material.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';

class SideEffectPresentRow  extends StatelessWidget {
  final SideEffectInfo sideEffectInfo;
  SideEffectInfo _sideEffectInfo;

  SideEffectPresentRow({this.sideEffectInfo});

  @override
  Widget build(BuildContext context) {
    _sideEffectInfo = this.sideEffectInfo != null ? this.sideEffectInfo : SideEffectInfo();
    
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
        ),
        Text(" ",
            style: TextStyle(fontSize: 16.0),),
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(_sideEffectInfo.drogoName ?? '',
            maxLines: null,
            style: TextStyle(fontSize: 14.0, height: 1.0),
          ),
        ),
        Text("  ", style: TextStyle(fontSize: 16.0),),
        Container(
          width: MediaQuery.of(context).size.width - 200,
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Text(_sideEffectInfo.symptom ?? '',
            maxLines: null,
            style: TextStyle(fontSize: 14.0, height: 1.0),
          ),
        ),
      ]
    );
  }
}