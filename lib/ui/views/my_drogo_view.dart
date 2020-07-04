import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/home_model.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/widgets/drogo_cell.dart';

import 'base_view.dart';

class MyDrogoView extends StatefulWidget {
  final String title;
  MyDrogoView({this.title});

  @override
  State<StatefulWidget> createState() => _MyDrogoViewState();
}

class _MyDrogoViewState extends State<MyDrogoView> {
  var _cardList = List<DrogoCell>();

  @override
  void initState() {
    _cardList.add(DrogoCell(
      id: '001',
      name: 'Torrance Beach',
      desc: 'The best beach in Torrance',
      picture:'torrance-beach.jpg',
    ));
    _cardList.add(DrogoCell(
      id: '002',
      name: 'Shake Shack',
      desc: 'American fast casual restaurant',
      picture: 'shake-shack.jpg',
    ));
    _cardList.add(DrogoCell(
      id: '003',
      name: 'The Hat',
      desc: 'The best pastrami dip sandwich',
      picture:'the-hat.jpg',
    ));
    super.initState();
  }

  @override
    Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        body: model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
            Container(padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                  child: new Center(
                    child: new Column(
                     children : <Widget>[
                          ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: _cardList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return _cardList[index];
                          },
                        ),
                     ]
                    )
                 ),
            ), 
            // Expanded(child: Text("")),
        ],)
      ),
    );
  }

}
