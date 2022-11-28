import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppIndicator {
  static BuildContext? dialogContext;

  static var circularProgressIndicator = SpinKitRing(
    color: Color(0xFF157B4F),
    size: 40,
    lineWidth: 4,
  );

  static void onLoading(BuildContext context) {
    showDialog(
      context: context,
      builder: (builderContext) {
        dialogContext = builderContext;
        return Container(
          child: AppIndicator.circularProgressIndicator,
        );
      },
    );
  }

  static void popDialogContext() {
    if (dialogContext != null) {
      Navigator.of(dialogContext!).pop();
    }
  }
}
