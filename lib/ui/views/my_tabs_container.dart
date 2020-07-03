import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyTabsContainer extends StatefulWidget {
  @override
  _MyTabsContainerState createState() => _MyTabsContainerState();
}

class _MyTabsContainerState extends State<MyTabsContainer> {
  int _selectedIndex = 0;
  static const List<String> _tabTitles =  ["Myくすり", "検索", "アラーム", "設定"];
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Myくすり',
      style: optionStyle,
    ),
    Text(
      'Index 1: 検索',
      style: optionStyle,
    ),
    Text(
      'Index 2: アラーム',
      style: optionStyle,
    ),
    Text(
      'Index 3: 設定',
      style: optionStyle,
    ),    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF64B7DA),
        title: Text(_tabTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Myくすり"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('検索'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text('アラーム'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('設定'),
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xFF64B7DA),
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.white60,
        onTap: _onItemTapped,
      ),
    );
  }
}