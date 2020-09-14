import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:drogo_libro/core/shared/string_util.dart';
import 'package:drogo_libro/ui/shared/screen_route_enums.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/views/my_drogo_view.dart';
import 'package:drogo_libro/ui/views/foryou_top_view.dart';
import 'package:drogo_libro/ui/views/my_alarm_view.dart';
import 'package:drogo_libro/ui/views/my_settings_view.dart';

class MyTabsContainer extends StatefulWidget {
  @override
  _MyTabsContainerState createState() => _MyTabsContainerState();
}

class _MyTabsContainerState extends State<MyTabsContainer> with WidgetsBindingObserver{
  int _selectedIndex = 0;
  static const List<String> _tabTitles =  ["Myくすり", "For you", "アラーム", "設定"];

  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // App call resume if background end.
    if(state == AppLifecycleState.resumed) {
      // パスコード設定をチェックし、設定された際、表示させる
      await StringUtil().readEncrptedData();
      if (StringUtil().isPcodeHidden == false 
      && (StringUtil().encryptedPcode ?? '').isNotEmpty) {
        Navigator.pushNamed(context, 
          ScreenRouteName.passcode.name,
          arguments: {'cancel': false}).then((value) {
          final bool auth = value ?? false;
          if(auth) {
           // nextCall();
          }
        });
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        title: Text(_tabTitles[_selectedIndex]),
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          MyDrogoView(title: _tabTitles[0]),
          ForyouTopView(title: _tabTitles[1]),
          MyAlarmView(title: _tabTitles[2]),
          MySettingsView(isTabAppeared: _selectedIndex == 3,),  
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(_tabTitles[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library),
            title: Text(_tabTitles[1]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text(_tabTitles[2]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text(_tabTitles[3]),
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