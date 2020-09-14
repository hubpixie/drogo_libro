import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/shared/city_util.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';

class CityFavoritesView extends StatefulWidget {
  final String title;
  //final CityInfo  cityItem;

  CityFavoritesView({this.title});

  @override
 _CityFavoritesViewState createState() => _CityFavoritesViewState();
}

class _CityFavoritesViewState extends State<CityFavoritesView> {
  List<CityInfo> _cityFavoritsList;
  List<bool> _checkedStatusList;
  int _selectedIndex;
  int _sortedByAscending;

  @override
  void initState() {
    _cityFavoritsList = null;
    _selectedIndex = -1;
    _readFavoriteData();
    _sortedByAscending = -1;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop((_selectedIndex >= 0 && _cityFavoritsList.isNotEmpty) ?
          CityInfo(
            zip:_cityFavoritsList[_selectedIndex].zip,
            name: _cityFavoritsList[_selectedIndex].name,
            nameDesc: _cityFavoritsList[_selectedIndex].nameDesc,
            countryCode: _cityFavoritsList[_selectedIndex].countryCode,
            isFavorite: _cityFavoritsList[_selectedIndex].isFavorite,
          ) : null
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: Platform.isAndroid ? false : true,
          backgroundColor: AppColors.appBarBackgroundColor,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: _cityFavoritsList != null && _cityFavoritsList.length > 1 ?  () async{
    print('_selectedIndex.1 = $_selectedIndex');
                  CityInfo cityValue = _cityFavoritsList[_selectedIndex];
                  _sortedByAscending *= -1;
                  _cityFavoritsList.sort((cityInfo1, cityInfo2) {
                    if(cityInfo1.nameDesc != null && cityInfo2.nameDesc != null)
                      return cityInfo1.nameDesc.compareTo(cityInfo2.nameDesc) * _sortedByAscending;
                    else return cityInfo1.name.compareTo(cityInfo2.name) * _sortedByAscending;
                  });
                  //　ソート後の結果を保存する
                  await _saveFavoriteData(cityValue: cityValue);
                } : null,
                icon: Icon(
                  Icons.sort
                ),
              ),
            ),
          ],
        ),
        body: _cityFavoritsList == null ? 
          Center(child: CircularProgressIndicator()) :
           _buildBody(context),
      )
    );
  }

  Widget _buildBody(BuildContext context) {
    return _cityFavoritsList.isNotEmpty ? Column (
      children: <Widget>[
        Expanded( 
          child : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _cityFavoritsList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
            return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: _buildFavoriteItem(context, index),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: '削除',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      // 行の削除
                      setState(() {
                        _cityFavoritsList.removeAt(index);
                        _selectedIndex = -1;
                      });
                      // 削除の保存
                      await CityUtil().saveCityInfoIntoPref();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ]
    ) :
    Column(
      children: <Widget>[
        Spacer(),
        Container(
          alignment: Alignment.center,
          child: Text('お気に入りがありません'),
        ),
        Spacer(),
      ],
    );
  }

  Widget _buildFavoriteItem(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
            backgroundColor: Colors.white,
          ),
          child:  CheckboxListTile(
            title: Text(_cityFavoritsList[index].nameDesc != null && _cityFavoritsList[index].nameDesc.isNotEmpty ?
              _cityFavoritsList[index].nameDesc :
              _cityFavoritsList[index].name, 
            style: TextStyle(color: Colors.black87),),
            value: _checkedStatusList[index],
            activeColor: Colors.white,
            checkColor: Colors.blueAccent,
            controlAffinity: ListTileControlAffinity.platform,
            selected: false,
            onChanged: (bool value) {
              setState(() {
                for(int i = 0; i < _checkedStatusList.length; i ++) {
                  _checkedStatusList[i] = false;
                }
                _checkedStatusList[index] = true;
                _selectedIndex = index;
              });
            },
          ),
        ),
        Divider(color: Colors.black26, height: 0.5,),
        ]
      );
  }

  Future<void> _readFavoriteData() async {
    await CityUtil().readFavoriteData();

    setState(() {
      _selectedIndex = CityUtil().selectedFavoriteIndex;
      _cityFavoritsList = CityUtil().cityFavoriteList;
      _checkedStatusList = _cityFavoritsList.length > 0 ? List.filled(_cityFavoritsList.length, false) : [];
      if(_selectedIndex >= 0) {
        _checkedStatusList[_selectedIndex] = true;
      }
    });
  }

  Future<void> _saveFavoriteData({CityInfo cityValue}) async {
    await CityUtil().saveCityListIntoPref(cityList: _cityFavoritsList, selectedItem: cityValue);

    print('_selectedIndex.2 = $_selectedIndex');
    _selectedIndex = CityUtil().selectedFavoriteIndex;
    print('_selectedIndex.3 = $_selectedIndex');
    setState(() {
      if(_selectedIndex >= 0) {
        for(int i = 0; i < _checkedStatusList.length; i ++) {
          _checkedStatusList[i] = false;
        }
        _checkedStatusList[_selectedIndex] = true;
      }
    });
  }

}
