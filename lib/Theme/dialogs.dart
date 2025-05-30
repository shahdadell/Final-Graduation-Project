import 'package:flutter/material.dart';
import 'package:graduation_project/Theme/text_style.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:lottie/lottie.dart';

enum DialogType {
  success,
  error,
}

showAppDialog(BuildContext context, String message,
    [DialogType? type = DialogType.error]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor:
          type == DialogType.success ? MyTheme.primaryColor : MyTheme.redColor,
      content: Text(
        message,
        style: getFont16TextStyle(color: MyTheme.whiteColor),
      )));
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    // barrierDismissible: false, // لمنع الإغلاق عند الضغط خارج الـ Dialog
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // جعل الخلفية شفافة
        child: Center(
          child: Lottie.asset('assets/images/loading.json'),
        ),
      );
    },
  );
}
