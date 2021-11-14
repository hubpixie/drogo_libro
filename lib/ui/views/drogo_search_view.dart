import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';

import 'package:drogo_libro/core/enums/code_enums.dart';
import 'package:drogo_libro/core/models/drogo_search_param.dart';

import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/shared/search_enums.dart';
import 'package:drogo_libro/ui/views/my_search_result_view.dart';

class DrogoSearchView extends StatefulWidget {
  final String title;
  DrogoSearchView({required this.title});

  @override
  _DrogoSearchViewState createState() => new _DrogoSearchViewState();
}

class _DrogoSearchViewState extends State<DrogoSearchView>
    with SingleTickerProviderStateMixin {
  //==========================<
  // Const defines
  static const int _kSearchedFieldLength = 6;
  static const List<String> _kSearchedButtonTextList = [
    "調剤日",
    "薬名",
    "飲み方",
    "服用回数",
    "医療機関",
    "医師名"
  ];
  static const List<String> _kSearchedButtonHintList = [
    "yyyy/MM/dd",
    "くすり名を入力",
    "選択...",
    "服用回数を入力",
    "医療機関名を入力",
    "医師名を入力"
  ];

  // Private variables
  SearchStatus _searchStatus = SearchStatus.ready;
  int _selectedTypeIndex = 0;
  int? _selectDrogoUsageItemValue;
  late Map<int, String> _selectedEtcItem;
  late TextEditingController _dateController;
  late TextEditingController _textController;
  //==========================>

  @override
  void initState() {
    super.initState();
    _dateController = new TextEditingController();
    _textController = new TextEditingController();
    _selectedEtcItem = new Map();
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _textController.dispose();
    _selectedEtcItem.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBackgroundColor,
        title: Text(widget.title),
      ),
      body: new Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                children: <Widget>[
                  // 検索種別指定用意
                  _buildSearchedTypeFields(),
                  // 検索項目内容
                  Padding(padding: const EdgeInsets.only(left: 10.0)),
                  SearchType.dispeningDate ==
                          SearchType.values[_selectedTypeIndex]
                      ? _showDatePickerWithTextField(context, DateTime.now())
                      : (SearchType.usage ==
                              SearchType.values[_selectedTypeIndex]
                          ? _buildSearchedItemDrogoUsage()
                          : _buildSearchedItemDrogoEtc()),
                  // 検索ボタン
                  Container(
                    width: 35,
                    child: IconButton(
                      color: Colors.black54,
                      onPressed: () {
                        setState(() {
                          // キーボードを閉じる
                          FocusScope.of(context).unfocus();

                          // 検索状態を「Search」とセットする
                          _searchStatus = SearchStatus.search;
                        });
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                  //Padding(padding: const EdgeInsets.only(bottom: 30.0)),
                ],
              )),
          Expanded(
            child: _buildSearchResultView(),
          )
        ],
      ),
    );
  }

  Widget _buildSearchResultView() {
    DrogoSearchParam? param = _makeSearchParam();
    if (param != null) {
      return MySearchResultView(
        searchedParam: param,
        searchedType: SearchType.values[_selectedTypeIndex],
      );
    } else {
      return Container();
    }
  }

  DrogoSearchParam? _makeSearchParam() {
    if (_searchStatus != SearchStatus.search) {
      return null;
    }
    DrogoSearchParam? param;
    switch (SearchType.values[_selectedTypeIndex]) {
      case SearchType.dispeningDate: //調剤日
        param = (_dateController.value.text.isNotEmpty)
            ? DrogoSearchParam(dispeningDate: _dateController.value.text)
            : null;
        break;
      case SearchType.usage: //飲み方
        param = (_selectDrogoUsageItemValue != null)
            ? DrogoSearchParam(usage: _selectDrogoUsageItemValue)
            : null;
        break;
      case SearchType.drogoName: //薬名
        param = (_selectedEtcItem.isNotEmpty)
            ? DrogoSearchParam(drogoName: _selectedEtcItem[_selectedTypeIndex])
            : null;
        break;
      case SearchType.times: //使用回数
        param = (_selectedEtcItem.isNotEmpty)
            ? DrogoSearchParam(
                times: int.tryParse(_selectedEtcItem[_selectedTypeIndex] ?? ''))
            : null;
        break;
      case SearchType.medicalInstituteName: //医療機関
        param = (_selectedEtcItem.isNotEmpty)
            ? DrogoSearchParam(
                medicalInstituteName: _selectedEtcItem[_selectedTypeIndex])
            : null;
        break;
      case SearchType.doctorName: //医師名
        param = (_selectedEtcItem.isNotEmpty)
            ? DrogoSearchParam(doctorName: _selectedEtcItem[_selectedTypeIndex])
            : null;
        break;
      default:
        param = null;
        break;
    }

    return param;
  }

  //　検索種別指定用
  Widget _buildSearchedTypeFields() {
    return Container(
      width: 90,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border(
            bottom: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Colors.black)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          hint: Text(_kSearchedButtonTextList[_selectedTypeIndex]),
          value: _selectedTypeIndex,
          items: List<DropdownMenuItem<int>>.generate(
              _kSearchedFieldLength,
              (index) => DropdownMenuItem(
                    child: Text(
                      _kSearchedButtonTextList[index],
                      textAlign: TextAlign.right,
                    ),
                    value: index,
                  )),
          onChanged: (int? value) {
            setState(() {
              // キーボードを閉じる
              FocusScope.of(context).unfocus();

              // 変更された種別などを記録する
              _selectedTypeIndex = value ?? 0;
              _searchStatus = SearchStatus.ready;
              _textController.text = '';

              //　検索種別が調剤日と飲み方以外の場合
              if (![SearchType.dispeningDate, SearchType.usage]
                  .contains(SearchType.values[_selectedTypeIndex])) {
                _textController.text =
                    _selectedEtcItem[_selectedTypeIndex] ?? '';
              }
            });
          },
        ),
      ),
    );
  }

  //　調剤日で検索時
  Widget _showDatePickerWithTextField(
      BuildContext context, DateTime initialDate) {
    return Container(
        width: MediaQuery.of(context).size.width - 175,
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border(
              bottom: BorderSide(
                  width: 1.0, style: BorderStyle.solid, color: Colors.black54)),
        ),
        child: GestureDetector(
          onTap: () => {
            DatePicker.showDatePicker(
              context,
              minDateTime: DateTime(2000, 1, 1),
              maxDateTime: DateTime(DateTime.now().year + 1, 12, 31),
              initialDateTime: DateTime.now(),
              dateFormat: 'yyyy-MM-dd',
              onCancel: () => {},
              onChange: (dateTime, selectedIndexList) => {},
              onConfirm: (dateTime, selectedIndexList) {
                setState(() {
                  _dateController.value = TextEditingValue(
                      text: DateFormat('yyyy/MM/dd').format(dateTime));
                  _searchStatus = SearchStatus.ready;
                });
              },
            )
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: _dateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: _kSearchedButtonHintList[_selectedTypeIndex],
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ));
  }

  //　飲み方で検索時
  Widget _buildSearchedItemDrogoUsage() {
    return Container(
      width: MediaQuery.of(context).size.width - 175,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border(
            bottom: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Colors.black)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          hint: Text(_kSearchedButtonHintList[_selectedTypeIndex]),
          value: _selectDrogoUsageItemValue,
          items: List<DropdownMenuItem<int>>.generate(
            DrogoUsages.values.length,
            (codeIdx) => DropdownMenuItem(
              child: Text(
                DrogoUsages.values[codeIdx].name,
                textAlign: TextAlign.right,
              ),
              value: codeIdx,
            ),
          ),
          onChanged: (int? value) {
            setState(() {
              _selectDrogoUsageItemValue = value ?? 0;
              _searchStatus = SearchStatus.ready;
            });
          },
        ),
      ),
    );
  }

  //　調剤日・飲み方以外で検索時
  Widget _buildSearchedItemDrogoEtc() {
    return Container(
      width: MediaQuery.of(context).size.width - 175,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border(
            bottom: BorderSide(
                width: 1.0, style: BorderStyle.solid, color: Colors.black54)),
      ),
      child: TextFormField(
        controller: _textController,
        keyboardType: SearchType.times == SearchType.values[_selectedTypeIndex]
            ? TextInputType.number
            : TextInputType.text,
        onChanged: (String text) {
          setState(() {
            _selectedEtcItem[_selectedTypeIndex] = text;
            _searchStatus = SearchStatus.ready;
          });
        },
        decoration: InputDecoration(
          hintText: _kSearchedButtonHintList[_selectedTypeIndex],
        ),
      ),
    );
  }
}
