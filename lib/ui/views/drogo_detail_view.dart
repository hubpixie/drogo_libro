import 'package:flutter/material.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/drogo_view_model.dart';
import 'package:drogo_libro/core/models/drogo_info.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

class DrogoDetailView extends StatelessWidget {
  final DrogoInfo drogoItem;
  DrogoDetailView({this.drogoItem});

  @override
  Widget build(BuildContext context) {
    return /*BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => */Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Color(0xFF64B7DA),
          title: Text("くすり・用法の明細"),
        ),
        body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
            Container(padding: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: new Column(
              children : [
                new Padding(padding: EdgeInsets.only(top: 20.0)),
                new Text('くすり名と飲み方を入力してください',
                style: new TextStyle(color: Color(0xFFF2A03D), fontSize: 25.0),),
                new Padding(padding: EdgeInsets.all(10.0)),
                Align (
                  alignment: Alignment.centerLeft,
                  child: new Text("No      ${this.drogoItem.id}"),
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new TextFormField(
                  initialValue: "${this.drogoItem.drogoSummaryList[0].drogoName}",
                  decoration: new InputDecoration(
                    labelText: "くすり１",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  validator: (val) {
                    if(val.length==0) {
                      return "Name cannot be empty";
                    }else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 10.0)),
                new TextFormField(
                  initialValue: "${this.drogoItem.drogoSummaryList[0].usage}",
                  decoration: new InputDecoration(
                    labelText: "用法",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(
                      ),
                    ),
                  ),
                  validator: (val) {
                    if(val.length==0) {
                      return "Desc cannot be empty";
                    }else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ]
            )
          ), 
          Expanded(child: Text("")),
        ],)
      );
    //);
  }

}
