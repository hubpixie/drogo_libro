import 'package:flutter/material.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';

class DrogoCell extends StatelessWidget {

  final String id;
  final String name;
  final String desc;
  final String picture;

  DrogoCell({this.id, this.name, this.desc, this.picture});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 70,
            child:  ListTile(
              leading: Icon(Icons.map),
              title: Text(this.name),
              subtitle: Text(this.desc),
              onTap: () =>  Navigator.pushNamed(context, ScreenRouteName.drogoDetail.name,
              arguments: {"id":this.id, "name":this.name, "desc": this.desc, "picture":this.picture}),
            ),
          )
          //Image.asset('assets/${this.picture}'),
        ],
      ),
    );
  }
}
