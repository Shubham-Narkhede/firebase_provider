import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class HelperFlushBar {
  static showFlushBarSuccess(BuildContext context, String msg) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: Colors.green,
      flushbarPosition: FlushbarPosition.TOP,
      message: msg,
      duration: Duration(milliseconds: 900),
    )..show(context);
  }

  static showFlushBarError(BuildContext context, String msg,
      {Color? backGroundColor, Color? textColor}) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      backgroundColor: backGroundColor ?? Colors.red,
      flushbarPosition: FlushbarPosition.TOP,
      message: msg,
      messageColor: textColor ?? Colors.white,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
