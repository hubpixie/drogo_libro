import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:drogo_libro/ui/shared/app_colors.dart';

typedef ValidateDelegate = bool Function(String);

class PasscodePanel extends StatefulWidget {
  final String title;
  final ValidateDelegate? onValidate;
  final bool cancelable;

  PasscodePanel(
      {Key? key, required this.title, this.onValidate, this.cancelable = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasscodePanelState();
}

class _PasscodePanelState extends State<PasscodePanel> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return PasscodeScreen(
      title: Text(
        'Enter App Passcode',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 28),
      ),
      passwordEnteredCallback: _onPasscodeEntered,
      cancelButton: Text(
        widget.cancelable ? 'Cancel' : '',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Cancel',
      ),
      deleteButton: Text(
        'Delete',
        style: const TextStyle(fontSize: 16, color: Colors.white),
        semanticsLabel: 'Delete',
      ),
      shouldTriggerVerification: _verificationNotifier.stream,
      backgroundColor:
          AppColors.mainBackgroundColor.withAlpha(100).withOpacity(0.8),
      cancelCallback: widget.cancelable ? _onPasscodeCancelled : null,
    );
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = widget.onValidate?.call(enteredPasscode) ?? true;
    _verificationNotifier.add(isValid);
    if (isValid) {
      setState(() {
        this.isAuthenticated = isValid;
      });
      Navigator.maybePop(context, isValid);
    }
  }

  _onPasscodeCancelled() {
    Navigator.maybePop(context);
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }
}
