import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/home_model.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

import 'base_view.dart';

class DrogoDetailView extends StatelessWidget {
  final String id;
  final String name;
  final String desc;
  DrogoDetailView({this.id, this.name, this.desc});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Color(0xFF64B7DA),
          title: Text("くすり名・用法の明細"),
        ),
        body: model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
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
                  child: new Text("No      ${this.id}"),
                ),
                new Padding(padding: EdgeInsets.all(10.0)),
                new TextFormField(
                  initialValue: "${this.name}",
                  decoration: new InputDecoration(
                    labelText: "くすり名",
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
                  initialValue: "${this.desc}",
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
      ),
    );
  }

}
