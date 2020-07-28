import 'package:flutter/material.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/search_enums.dart';

class SearchResultCell extends StatelessWidget {
  final SearchType searchedType;
  final DrogoInfo drogoItem;

  SearchResultCell({this.searchedType, this.drogoItem});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () =>  Navigator.pushNamed(context, ScreenRouteName.editDrogoDetail.name,
              arguments: {"drogoItem": this.drogoItem}),
      child: Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildRow(context),
          ),
      //  )
      )
    );
  }

  /// 調剤日・薬名で検索した時の結果表示
  /// 
List<Widget> _buildRow(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    List<Widget> ret = [];
    ret.add(
      new Row(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(8.0)),
          new Text('調剤日',
            style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
          new Padding(padding: EdgeInsets.only(left: 20.0, top: 4.0),
              child: new Text(this.drogoItem.dispeningDate, 
                style: new TextStyle(backgroundColor: this.searchedType == SearchType.dispeningDate ? AppColors.searchedResultMarkColor : Colors.white
                )
              ),
            ),
        ],
      )
    );
    Row drogoRow = new Row(
        children: <Widget>[
          new Padding(padding: EdgeInsets.all(8.0)),
          new Text('お薬名',
            style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
          new Padding(padding: EdgeInsets.all(4.0)),
          new Text(this.drogoItem.drogoSummaryList[0].drogoName, 
                style: new TextStyle(backgroundColor: this.searchedType == SearchType.drogoName ? AppColors.searchedResultMarkColor : Colors.white
                )),
          new Padding(padding: EdgeInsets.all(4.0)),
          new Text('全',
            style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
          new Padding(padding: EdgeInsets.all(4.0)),
          new Text("${this.drogoItem.drogoSummaryList[0].days} 日分", softWrap: true, maxLines: 1,),
        ],
      );

    switch(this.searchedType) {
      case SearchType.dispeningDate:
      case SearchType.drogoName:
        ret.add( 
          drogoRow
        );
        break;
      case SearchType.usage:
      case SearchType.times:
        ret.add( 
          drogoRow
        );
        ret.add(
          new Row(
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text('(内服)',
                style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
              new Padding(padding: EdgeInsets.all(4.0)),
              new Text("1 日 ${this.drogoItem.drogoSummaryList[0].times}回　", 
                style: new TextStyle(backgroundColor: this.searchedType == SearchType.times ? AppColors.searchedResultMarkColor : Colors.white
                )),
              new Text("${DrogoUsages.values[this.drogoItem.drogoSummaryList[0].usage].name}", 
                style: new TextStyle(backgroundColor: this.searchedType == SearchType.usage ? AppColors.searchedResultMarkColor : Colors.white
                )),
              new Padding(padding: EdgeInsets.all(6.0)),
              new Text("1 回 ${this.drogoItem.drogoSummaryList[0].amount}錠", softWrap: true, maxLines: 1,),
            ],
          ),
        );
        break;
      case SearchType.medicalInstituteName:
        ret.add(
          new Row(
            children: <Widget>[
              new Padding(padding: EdgeInsets.all(8.0)),
              new Text('医療機関',
                style: new TextStyle(color: AppColors.labelColor, fontSize: 13.0),),
              new Padding(padding: EdgeInsets.all(4.0)),
              SizedBox(
                width: screenWidth >= 320 && screenWidth <= 360  ? 110 : 140,
                child: new Text(this.drogoItem.medicalInstituteName, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, 
                  style: new TextStyle(backgroundColor: this.searchedType == SearchType.medicalInstituteName ? AppColors.searchedResultMarkColor : Colors.white
                )),
              ),
              new Padding(padding: EdgeInsets.all(4.0)),
            ],
          ),
        );
        ret.add( 
          drogoRow
        );
        break;
      case SearchType.doctorName:
        ret.add(
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
                child: new Text(this.drogoItem.doctorName, softWrap: false, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, 
                  style: new TextStyle(backgroundColor: this.searchedType == SearchType.doctorName ? AppColors.searchedResultMarkColor : Colors.white
                )),
              ),
            ],
          ),
        );
        ret.add( 
          drogoRow
        );
        break;
      default:
        break;
    }
    return ret;
  }

}
