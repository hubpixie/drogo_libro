import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

typedef CellSelectedDelegate = void Function(Object);
class DrogoCell extends StatelessWidget {
  final DrogoInfo drogoItem;
  final CellSelectedDelegate onCellSelected;

  DrogoCell({this.drogoItem, this.onCellSelected});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () =>  this.onCellSelected({"drogoItem": this.drogoItem}),
      child: Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new Text('調剤日',
                    style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
                  new Padding(padding: EdgeInsets.only(left: 20.0, top: 4.0),
                      child: new Text(this.drogoItem.dispeningDate),
                    ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new Text('医療機関',
                    style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  SizedBox(
                    width: screenWidth >= 320 && screenWidth <= 360  ? 110 : 140,
                    child: new Text(this.drogoItem.medicalInstituteName, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                  ),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text('医師名',
                    style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0), ),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  SizedBox(
                    width: screenWidth == 320 ? 55 : 80,
                    child: new Text(this.drogoItem.doctorName, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new Text('お薬名',
                    style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text(this.drogoItem.drogoSummaryList[0].drogoName),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text('全',
                    style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text("${this.drogoItem.drogoSummaryList[0].days} 日分", softWrap: true, maxLines: 1,),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new Text('(内服)',
                    style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text("1日${this.drogoItem.drogoSummaryList[0].times}回", 
                    ),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text("${DrogoUsages.values[this.drogoItem.drogoSummaryList[0].usage].name}"),
                  new Padding(padding: EdgeInsets.all(4.0)),
                  new Text("1回${this.drogoItem.drogoSummaryList[0].amount}錠", softWrap: true, maxLines: 1,
                    style: TextStyle(height: 1.2),),
                ],
              ),
              new Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45)
                ),
                child: Row(children: <Widget>[
                  new Padding(padding: EdgeInsets.all(8.0)),
                  new Container(
                    alignment: Alignment.topLeft,
                    width: 80.0,
                    child: new Text('※この薬服用にあたって',
                      style: new TextStyle(color: AppColors.labelColor, 
                      fontSize: 12.0), maxLines: 3,
                      ),
                    ),
                  new Container(
                    alignment: Alignment.centerLeft,
                      width: screenWidth - 152.0,
                      height: 50,
                      child: new Text('${this.drogoItem.drogoSummaryList[0].notaBene}', 
                        style: new TextStyle(fontSize: 12.0, height: 1.2), 
                      maxLines: 3),
                    )
                ],),
              ),
              new Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth - 130, bottom: 8.0),
                    child: Text("詳細を見る", style: new TextStyle(color: AppColors.mainBackgroundColor, fontSize: 13.0),),
                  ),
                ],
              ),
            ]
          ),
      //  )
      )
    );
  }
}
