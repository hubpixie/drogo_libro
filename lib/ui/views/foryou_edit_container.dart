import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/enums/code_enums.dart';
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
    _itemValue = (_itemValue == null) ? (viewModel.foryouInfo == null || viewModel.foryouInfo.result == null ? ForyouInfo() : viewModel.foryouInfo.result ) : _itemValue;

    Widget dataBody = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children : <Widget>[
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 1,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                switch(widget.routeName) {
                  case ScreenRouteName.editBloodType:
                    return BloodTypeEditCell(
                      bloodType: _itemValue != null  ? _itemValue.bloodType : null,
                      onCellEditing: (newValue) {
                        setState(() {
                          if(newValue != null) {
                            if(_itemValue.bloodType == null) {
                              _isButtonEnabled = true;
                            } else {
                              BloodTypes oldValue = _itemValue.bloodType;
                              if (oldValue != newValue) {
                                _isButtonEnabled = true;
                              }
                            }
                          }
                          _itemValue.bloodType = newValue;
                        });
                      }
                    );
                  case ScreenRouteName.editMedicalHistory:
                    return MedicalHistoryEditCell();
                  case ScreenRouteName.editAllergy:
                    return AllergyHistoryEditCell();
                  case ScreenRouteName.editSuplements:
                    return SuplementInfoEditCell();
                  case ScreenRouteName.editSideEffect:
                    return SideEffectEditCell();
                  default:
                    return Container();
                }
            },
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
    );

    return  LoadingOverlay(
      opacity: 0.7,
      child: dataBody, 
      isLoading: viewModel != null && viewModel.state == ViewState.Busy
    );
  }

  /// 保存ボタンタップ時
  ///
 void _saveButtonOnTapped(ForyouViewModel viewModel) async {
   setState(() {
      // Update data to run http put reqest.
      _itemValue.userId = context.read<User>().id;
      viewModel.updateForyouInfo(_itemValue).then((value) async {
        if(viewModel.foryouInfoUpdated != null && !viewModel.foryouInfoUpdated.hasError) {
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
        content: Text('保存できません\n(error:${viewModel.foryouInfoUpdated.code})', style: TextStyle(color: Colors.white),),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            Navigator.of(context).pop(null);
            return Future.value(false);
          },
        ),
        duration: Duration(seconds: 60),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
