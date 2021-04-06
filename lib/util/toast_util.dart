import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//toast工具 需要注意的一点 toast会被键盘遮住  所以建议使用原生或者将toast位置设置到中间
void showWarnToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white);
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,);
}