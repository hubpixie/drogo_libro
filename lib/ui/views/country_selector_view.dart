import 'package:flutter/material.dart';

import 'package:drogo_libro/core/models/city_info.dart';
import 'package:drogo_libro/core/shared/city_util.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';

class CountrySelectorView extends StatefulWidget {
  final String title;
  final String countryCode;

  CountrySelectorView({required this.title, required this.countryCode});

  @override
  _CountrySelectorViewState createState() => _CountrySelectorViewState();
}

class _CountrySelectorViewState extends State<CountrySelectorView> {
  late List<CountryInfo> _countryNameList;
  late List<bool> _checkedStatusList;
  late int _selectedIndex;

  @override
  void initState() {
    _countryNameList = CityUtil().countryNameList;
    _selectedIndex = _countryNameList
        .indexWhere((element) => element.code == widget.countryCode);
    _checkedStatusList = List.filled(_countryNameList.length, false);
    if (_selectedIndex >= 0) {
      _checkedStatusList[_selectedIndex] = true;
    }

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
          Navigator.of(context).pop(_selectedIndex >= 0
              ? CountryInfo(
                  id: _countryNameList[_selectedIndex].id,
                  code: _countryNameList[_selectedIndex].code,
                  jpName: _countryNameList[_selectedIndex].jpName,
                  enName: _countryNameList[_selectedIndex].enName,
                )
              : null);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: AppColors.appBarBackgroundColor,
          ),
          body: _buildBody(context),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _countryNameList.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: <Widget>[
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                  backgroundColor: Colors.white,
                ),
                child: CheckboxListTile(
                  title: Text(
                    "${_countryNameList[index].code}　${_countryNameList[index].jpName}",
                    style: TextStyle(color: Colors.black87),
                  ),
                  value: _checkedStatusList[index],
                  activeColor: Colors.white,
                  checkColor: Colors.blueAccent,
                  controlAffinity: ListTileControlAffinity.platform,
                  selected: false,
                  onChanged: (bool? value) {
                    setState(() {
                      for (int i = 0; i < _checkedStatusList.length; i++) {
                        _checkedStatusList[i] = false;
                      }
                      _checkedStatusList[index] = true;
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
              Divider(
                color: Colors.black26,
                height: 0.5,
              ),
            ]);
          },
        ),
      ),
    ]);
  }
}
