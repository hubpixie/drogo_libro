/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/viewmodels/home_model.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

import 'base_view.dart';

class MySearchView extends StatelessWidget {
  final String title;
  MySearchView({this.title});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      onModelReady: (model) => model.getPosts(Provider.of<User>(context).id),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
         : Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
            new Padding(padding: EdgeInsets.only(top: 20.0)),
            TextField(
              //onChanged: () => {},
              maxLines: 1,
              decoration: InputDecoration(
                labelText: "Username",
                contentPadding: const EdgeInsets.all(20.0)
              )
            ),
          ],
        )
      ),
    );
  }

}
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class MySearchView extends StatefulWidget {
  final String title;
  MySearchView({this.title});

  @override
  _MySearchViewState createState() => new _MySearchViewState();
}

class _MySearchViewState extends State<MySearchView> with SingleTickerProviderStateMixin {
  // TabController to control and switch tabs
  TabController _tabController;

  // Current Index of tab
  static const int _kSearchedFieldLength = 6;
  int _currentIndex = 0;
  int _selectedItem;

  final List<String> _kSearchedButtonTextList = ["調剤日", "薬名", "飲み方", "使用量", "医療機関", "薬局"];

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: _kSearchedFieldLength, initialIndex: _currentIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: _currentIndex == 0 ? _showDatePickerWithTextField(context, DateTime.now()) :
                (_currentIndex == 1 ? _searchedFieldDrogoUsage() : _searchedFieldDrogoEtc())
            ),
          new Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: new Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: _searchedCheckButtons(_kSearchedFieldLength),
              ),
            ),
          ),
          new Expanded(
            child: new TabBarView(
                controller: _tabController,
                // Restrict scroll by user
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // 調剤日
                  new Center(
                    child: new Text(_kSearchedButtonTextList[0]),
                  ),
                  // 薬名
                  new Center(
                    child: new Text(_kSearchedButtonTextList[1]),
                  ),
                  // 飲み方
                  new Center(
                    child: new Text(_kSearchedButtonTextList[2]),
                  ),
                  // 医師名
                  new Center(
                    child: new Text(_kSearchedButtonTextList[3]),
                  ),
                  // 医療機関
                  new Center(
                    child: new Text(_kSearchedButtonTextList[4]),
                  ),
                  // 薬局
                  new Center(
                    child: new Text(_kSearchedButtonTextList[5]),
                  )
                ]),
          )
        ],
      ),
    );
  }

// 調剤日〜薬局で検索設定ボタン
List<Widget> _searchedCheckButtons(int count) {
  List<Widget> lst = [];
  for (int idx = 0; idx < count; idx++ ) {
    lst.add(
      SizedBox(
        width: (MediaQuery.of(context).size.width - 12) / count,
        child: RaisedButton(
          padding: EdgeInsets.all(0.0),
          color: _currentIndex == idx ? Colors.blue : Colors.white,
          onPressed: () {
            _tabController.animateTo(idx);
            setState(() {
              _currentIndex = idx;
            });
          },
          child: new Text(_kSearchedButtonTextList[idx],),
        )
      ,)
    );
  }

  return lst;
}

  //　飲み方で検索時
  Widget _searchedFieldDrogoUsage() {
    return  
      Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 90,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border(
                bottom:BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Colors.black38)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                hint: Text(_kSearchedButtonTextList[_currentIndex]),
                value: _selectedItem,
                items: <DropdownMenuItem<int>>[
                  new DropdownMenuItem(
                    child: new Text(
                      'CLOCK',
                      textAlign: TextAlign.right,
                    ),
                    value: 0,
                  ),
                  new DropdownMenuItem(
                    child: new Text(
                      'DATES',
                      textAlign: TextAlign.right,
                    ),
                    value: 1,
                  ),
                  new DropdownMenuItem(
                    child: new Text(
                      'SLOT MACHINE',
                    ),
                    value: 2,
                  ),
                ],
                onChanged: (int value) {
                  setState(() => _selectedItem = value);
                },
              ),
            ),
          ),                  
          IconButton(
            color: Colors.black54,
            onPressed: () => {},
            icon: Icon(Icons.search),
          )
        ],);

  }

  //　飲み方意外で検索時
  Widget _searchedFieldDrogoEtc() {
    return
      Row(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 90,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:  TextFormField(
            decoration: InputDecoration(
              hintText: _kSearchedButtonTextList[_currentIndex],
            ),
          ),
        ),
        IconButton(
          color: Colors.black54,
          onPressed: () => {},
          icon: Icon(Icons.search),
        )
      ],);
  }

  TextEditingController _dateController = new TextEditingController();
  Widget _showDatePickerWithTextField(BuildContext context, DateTime initialDate) {
    return
      Row(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 90,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child:GestureDetector(
            onTap: () => {
                DatePicker.showDatePicker(
                  context,
                  minDateTime: DateTime(2000, 1, 1),
                  maxDateTime: DateTime(DateTime.now().year + 1, 12, 31),
                  initialDateTime: DateTime.now(),
                  dateFormat: 'yyyy-MM-dd',
                  onCancel: () => {},
                  onChanged2: (dateTime, selectedIndexList) => {},
                  onConfirm2: (dateTime, selectedIndexList) => {_dateController.value = TextEditingValue(text: DateFormat('yyyy/MM/dd').format(dateTime))},
                )                           
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: 'Date of Birth',
                  prefixIcon: Icon(
                    Icons.dialpad,
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
          )
        ),
        IconButton(
          color: Colors.black54,
          onPressed: () => {},
          icon: Icon(Icons.search),
        )
      ]
    );
  }

}