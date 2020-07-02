import 'package:flutter/material.dart';

class MyTabsContainer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF64B7DA),
              title: Text("Title text"),
            ),
            bottomNavigationBar: menu(),
            body: TabBarView(
              children: [
                Container(child: Icon(Icons.directions_car)),
                Container(child: Icon(Icons.directions_transit)),
                Container(child: Icon(Icons.directions_bike)),
                Container(child: Icon(Icons.directions_bike)),
              ],
            ),
          ),
        ),
      );
    }
  
Widget menu() {
return Container(
  color: Color(0xFF64B7DA),
  child: TabBar(
    labelColor: Colors.black87,
    unselectedLabelColor: Colors.white60,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorPadding: EdgeInsets.all(5.0),
    indicatorColor: Colors.blue,
    tabs: [
      Tab(
        text: "服薬",
        icon: Icon(Icons.note),
      ),
      Tab(
        text: "検索",
        icon: Icon(Icons.search),
      ),
      Tab(
        text: "アラーム",
        icon: Icon(Icons.alarm),
      ),
      Tab(
        text: "設定",
        icon: Icon(Icons.settings),
      ),
    ],
  ),
);
}
}

