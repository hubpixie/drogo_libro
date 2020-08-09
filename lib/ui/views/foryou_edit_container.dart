import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/core/viewmodels/foryou_view_model.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/widgets/blood_type_edit_cell.dart';
import 'package:drogo_libro/ui/widgets/allergy_history_edit_cell.dart';
import 'package:drogo_libro/ui/widgets/suplement_info_edit_cell.dart';
import 'package:drogo_libro/ui/widgets/medical_history_edit_cell.dart';
import 'package:drogo_libro/ui/widgets/side_effect_edit_cell.dart';

import 'base_view.dart';

class ForyouEditContainer extends StatefulWidget {
  final String title;
  final ScreenRouteName routeName;
  final ForyouInfo itemValue;
  ForyouEditContainer({this.title, this.routeName, this.itemValue});

  @override
  _ForyouEditContainerState createState() => _ForyouEditContainerState();
}

class _ForyouEditContainerState extends State<ForyouEditContainer> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  ForyouInfo _itemValue;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    _itemValue = widget.itemValue;
   
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  void dispose() {
    _scaffoldKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BaseView<ForyouViewModel>(
      onModelReady: widget.itemValue == null ? 
        (viewModel) => viewModel.getForyouInfo(Provider.of<User>(context).id) : null,
      builder: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          title: Text(widget.title),
        ),
        backgroundColor: AppColors.mainBackgroundColor,
        body: _dataBody(viewModel),
      ),
    );
  }

  Widget _dataBody(ForyouViewModel viewModel) {
    if(viewModel.fetchedForyouInfo != null) {
      if(!viewModel.fetchedForyouInfo.hasError || viewModel.fetchedForyouInfo.isNotFound) {
        if(!viewModel.fetchedForyouInfo.hasData) {
          _itemValue = ForyouInfo();
        } else {
          _itemValue = viewModel.fetchedForyouInfo.result;
        }
      }
    } else {
        _itemValue = ForyouInfo();
    }
    
    Widget dataBody = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // キーボードを閉じる
          FocusScope.of(context).unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children : <Widget>[
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: 1,
                  //scrollDirection: Axis.vertical,
                  //shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildCardPart(context, index, viewModel);
                  }
              ),
            ),
            Container(
              width: 200.0,
              height: 50.0,
              margin: EdgeInsets.only(bottom: 20.0),
              child: FlatButton(
                onPressed: _isButtonEnabled ? () => _saveButtonOnTapped(viewModel) : null,
                child: Text('保存',
                  style: TextStyle(color: _isButtonEnabled ? Colors.white : Colors.white30,
                  fontSize: 20.0)),
                color: Colors.blueAccent,
                disabledColor: Colors.grey[400],
              ),
            )
          ],
        )
      );

    return  LoadingOverlay(
      opacity: 0.7,
      child: dataBody, 
      isLoading: viewModel != null && viewModel.state == ViewState.Busy
    );
  }

 Widget _buildCardPart(BuildContext context, int index, ForyouViewModel viewModel) {
    switch(widget.routeName) {
      case ScreenRouteName.editBloodType:
        return BloodTypeEditCell(
          itemValue: ForyouInfo(bloodType: _itemValue.bloodType),
          onCellEditing: (newValue) {
            setState(() {
              ForyouInfo newItemValue = newValue;
              if(newItemValue != null) {
                if(_itemValue.bloodType == null) {
                  _isButtonEnabled = true;
                } else {
                  if (_itemValue.bloodType != newItemValue.bloodType) {
                    _isButtonEnabled = true;
                  }
                }
              }
              _itemValue.bloodType = newItemValue.bloodType;
            });
          }
        );
      case ScreenRouteName.editMedicalHistory:
        return MedicalHistoryEditCell(
          itemValue: ForyouInfo(medicalHistoryTypeList: _itemValue.medicalHistoryTypeList != null ? [..._itemValue.medicalHistoryTypeList] : null, 
            medicalHdText: _itemValue.medicalHdText, medicalEtcText: _itemValue.medicalEtcText),
          onCellEditing: (newValue) {
            setState(() {
              ForyouInfo newItemValue = newValue;
              /// each checkbox
              if(!_isButtonEnabled) {
                _isButtonEnabled = _isCheckboxValuesChanged(
                _itemValue.medicalHistoryTypeList, newItemValue.medicalHistoryTypeList);
              }
              _itemValue.medicalHistoryTypeList = newItemValue.medicalHistoryTypeList;

              /// hd text
              if(!_isButtonEnabled) {
                _isButtonEnabled = newItemValue.medicalHdText != _itemValue.medicalHdText;
              }
              _itemValue.medicalHdText = newItemValue.medicalHdText;
              
              /// etc text
              if(!_isButtonEnabled) {
                _isButtonEnabled = newItemValue.medicalEtcText != _itemValue.medicalEtcText;
              }
              _itemValue.medicalEtcText = newItemValue.medicalEtcText;
            });
          }
        );
      case ScreenRouteName.editAllergy:
        return AllergyHistoryEditCell(
          itemValue: ForyouInfo(allergyHistoryTypeList: _itemValue.allergyHistoryTypeList != null ? [..._itemValue.allergyHistoryTypeList] : null, 
            allergyEtcText: _itemValue.allergyEtcText),
          onCellEditing: (newValue) {
            setState(() {
              ForyouInfo newItemValue = newValue;
              /// each checkbox
              if(!_isButtonEnabled) {
                _isButtonEnabled = _isCheckboxValuesChanged(
                _itemValue.allergyHistoryTypeList, newItemValue.allergyHistoryTypeList);
              }
              _itemValue.allergyHistoryTypeList = newItemValue.allergyHistoryTypeList;

              /// etc text
              if(!_isButtonEnabled) {
                _isButtonEnabled = newItemValue.allergyEtcText != _itemValue.allergyEtcText;
              }
              _itemValue.allergyEtcText = newItemValue.allergyEtcText;
            });
          }
        );
      case ScreenRouteName.editSuplements:
        return SuplementInfoEditCell();
      case ScreenRouteName.editSideEffect:
        return SideEffectEditCell();
      default:
        return Container();
    }
 }

 bool _isCheckboxValuesChanged(List<bool> currentValue, List<bool> newValue) {
    bool ret  = false;
    if(newValue != null) {
      if(currentValue == null) {
        ret = true;
      } else {
        for(int idx = 0; idx < currentValue.length; idx++) {
          if(currentValue[idx] != newValue[idx]) {
            ret = true;
            break;
          }
        }
      }
    }
    return ret;
 }
  /// 保存ボタンタップ時
  ///
 void _saveButtonOnTapped(ForyouViewModel viewModel) async {
   setState(() {
      // Update data to run http put reqest.
      _itemValue.userId = context.read<User>().id;
      viewModel.updateForyouInfo(_itemValue).then((value) async {
        if(viewModel.updatedForyouInfo != null && !viewModel.updatedForyouInfo.hasError) {
          final snackBar = SnackBar(
              backgroundColor: Colors.deepPurple[900],
              content: Text('正常に保存しました', style: TextStyle(color: Colors.white),),
              action: SnackBarAction(
                label: '',
                onPressed: () {},
              ),
              duration: Duration(seconds: 4),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar).closed.then((value) {
                Navigator.of(context).pop(_itemValue);
                return Future.value(false);
            });
        } else {
          _showErrorSnackBarIfNeed(viewModel);
        }

      }).catchError((error) {
        _showErrorSnackBarIfNeed(viewModel);
      });
    });
  }
  void _showErrorSnackBarIfNeed(ForyouViewModel viewModel) {
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('保存できません\n(error:${viewModel.updatedForyouInfo.errorCode})', style: TextStyle(color: Colors.white),),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
        duration: Duration(seconds: 60),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
