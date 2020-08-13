import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:drogo_libro/core/enums/viewstate.dart';
import 'package:drogo_libro/core/models/user.dart';
import 'package:drogo_libro/core/models/foryou_info.dart';
import 'package:drogo_libro/core/viewmodels/foryou_view_model.dart';

import 'package:drogo_libro/ui/shared/screen_route_enums.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';
import 'package:drogo_libro/ui/widgets/blood_type_present_cell.dart';
import 'package:drogo_libro/ui/widgets/allergy_history_present_cell.dart';
import 'package:drogo_libro/ui/widgets/suplement_info_present_cell.dart';
import 'package:drogo_libro/ui/widgets/medical_history_present_cell.dart';
import 'package:drogo_libro/ui/widgets/side_effect_present_cell.dart';

import 'base_view.dart';

class ForyouPresentView extends StatefulWidget {
  final String title;
  ForyouPresentView({this.title});

  @override
  _ForyouPresentViewState createState() => _ForyouPresentViewState();
}

class _ForyouPresentViewState extends State<ForyouPresentView> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  ForyouInfo _itemValue;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _itemValue = null;
  }

  @override
  void dispose() {
    _scaffoldKey = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ForyouViewModel>(
      onModelReady: (viewModel) => viewModel.getForyouInfo(Provider.of<User>(context).id),
      builder: (context, viewModel, child) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.appBarBackgroundColor,
          title: Text(widget.title),
        ),
        backgroundColor: AppColors.mainBackgroundColor,
        body: LoadingOverlay(
          opacity: 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: 5,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCardPart(context, index, viewModel);
                  },
                ),
              )
            ]
          ),
          isLoading: () {
            _showErrorSnackBarIfNeed(viewModel);
            return viewModel.state == ViewState.Busy;
          }(),
        ),
      ),
    );
  }

  Widget _buildCardPart(BuildContext context, int index, ForyouViewModel viewModel) {
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
    
    switch(index) {
      case 0:
        return BloodTypePresentCell(
          itemValue: _itemValue,
          onCellEditing: () {
            Navigator.pushNamed(context, ScreenRouteName.editBloodType.name)
            .then((result) async {
              setState(() {
                ForyouInfo value = result;
                if (value != null) {
                  _itemValue.bloodType = value.bloodType;
                }

                // reload this page due to data updated.
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => super.widget));
              });
            });
          });
      case 1:
        return MedicalHistoryPresnetCell(
          itemValue: _itemValue,
          onCellEditing: () {
            Navigator.pushNamed(context, ScreenRouteName.editMedicalHistory.name)
            .then((result) async {
              setState(() {
                ForyouInfo value = result;
                if (value != null) {
                  _itemValue.medicalHistoryTypeList = value.medicalHistoryTypeList;
                  _itemValue.medicalHdText = value.medicalHdText;
                  _itemValue.medicalEtcText = value.medicalEtcText;
                }

                // reload this page due to data updated.
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => super.widget));
              });
            });
          });
      case 2:
        return AllergyHistoryPresentCell(
          itemValue: _itemValue,
          onCellEditing: () {
            Navigator.pushNamed(context, ScreenRouteName.editAllergy.name)
            .then((result) async {
              setState(() {
                ForyouInfo value = result;
                if (value != null) {
                  _itemValue.allergyHistoryTypeList = value.allergyHistoryTypeList;
                  _itemValue.allergyEtcText = value.allergyEtcText;
                }

                // reload this page due to data updated.
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => super.widget));
              });
            });
          });
      case 3:
        return SuplementInfoPresentCell(
          itemValue: _itemValue,
          onCellEditing: () {
            Navigator.pushNamed(context, ScreenRouteName.editSuplements.name)
            .then((result) async {
              setState(() {
                ForyouInfo value = result;
                if (value != null) {
                  _itemValue.suplementTypeList = value.suplementTypeList;
                  _itemValue.suplementEtcText = value.suplementEtcText;
                }

                // reload this page due to data updated.
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => super.widget));
              });
            });
          });
      case 4:
        return SideEffectPresentCell(
          itemValue: _itemValue,
          onCellEditing: () {
            Navigator.pushNamed(context, ScreenRouteName.editSideEffect.name)
            .then((result) async {
              setState(() {
                ForyouInfo value = result;
                if (value != null) {
                  _itemValue.sideEffectList = value.sideEffectList;
                }

                // reload this page due to data updated.
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => super.widget));
              });
            });
          });
      default:
        return Container();
    }

  }
  
  void _showErrorSnackBarIfNeed(ForyouViewModel viewModel) {
    if(viewModel.state == ViewState.Busy || viewModel.fetchedForyouInfo == null || !viewModel.fetchedForyouInfo.hasError) {
      return;
    }
    print("error_message: [${viewModel.fetchedForyouInfo.errorCode}] ${viewModel.fetchedForyouInfo.message}");
    final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('エラーが発生しました\n(error:${viewModel.fetchedForyouInfo.errorCode})', style: TextStyle(color: Colors.white),),
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
