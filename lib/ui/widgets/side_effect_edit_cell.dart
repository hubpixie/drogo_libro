import 'package:flutter/material.dart';

class SideEffectEditCell extends StatefulWidget {

  @override
  _SideEffectEditCellState createState() => _SideEffectEditCellState();
}

class _SideEffectEditCellState extends State<SideEffectEditCell> {
  double _screenWidth;
  List<Widget> _sideEffectContents;
  List<List> _textList;
  int _usedCount = 1;


  @override
  void initState() {
    super.initState();
    _sideEffectContents = [];
    _textList = List.filled(5, ['','']);

  }

  @override
  void dispose() {
    _sideEffectContents = null;
    _textList = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

    if(_sideEffectContents.isEmpty) {
      _initSideEffectContents();
    }
    return 
      Card(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _sideEffectContents,
        )
      );
  }

 void _initSideEffectContents() {
   _sideEffectContents.add(
    Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text("副作用",
            style: TextStyle(fontSize: 20.0),),
        ),
        Padding( padding: const EdgeInsets.only(top: 10.0),
        ),
        Container(
          width: _screenWidth < 375 ? _screenWidth - 120 : null,
          child: _screenWidth < 320 ? null : Text("該当の場合、最大５個まで記載可能",
            style: TextStyle(fontSize: 12.0, height: 1.2), maxLines: 2,)
        ),
      ]
    ),
   );


   _sideEffectContents.add(
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
          ),
          Container(
            alignment: Alignment.center,
            width: 90,
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Text('おくすり名'),
          ),
          Container(
            alignment: Alignment.center,
            //width: _screenWidth - 220,
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Text('　症状(いつ頃)', textAlign: TextAlign.right,),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if(_usedCount  > _textList.length - 1) {return;}
                  _usedCount++;
                  _addSideEffectContents(index: _usedCount - 1);
                });
              },
              padding: new EdgeInsets.all(0.0),
              icon: Icon(Icons.add, color: Colors.blueAccent,size: 30.0),
              ),
          )
        ]
      )
   );

  _addSideEffectContents(index: 0);

 }

 void _addSideEffectContents({int index}) {
   _sideEffectContents.add(
      Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
          ),
          Text("( ",
              style: TextStyle(fontSize: 16.0),),
          Container(
            width: 90,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'くすり名を入力',
              ),
              style: TextStyle(fontSize: 12.0, height: 1.0),
              onChanged: (text) {
                setState(() {
                 _textList[index][0] = text;
                });
              }
            ),
          ),
          Text(" ) ", style: TextStyle(fontSize: 16.0),),
          Container(
            width: MediaQuery.of(context).size.width - 200,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'ヒフの胸部にかゆい(2020/8/1頃)',
              ),
              style: TextStyle(fontSize: 12.0, height: 1.0),
              onChanged: (text) {
                setState(() {
                 _textList[index][1] = text;
                });
              }
            ),
          ),
        ]
      )
   );


 }

}
