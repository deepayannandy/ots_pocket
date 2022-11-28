import 'package:flutter/material.dart';

showAlertPopUpForConfirmation({
  required BuildContext context,
  required String title,
  required String confirmationMsg,
  required VoidCallback onClickOk,
  required VoidCallback onClickCancel,
  required String buttonTextForOk,
  required Color buttonOkTextColor,
  required double buttonOkTextSize,
  required String buttonTextForCancel,
  required Color buttonCancelTextColor,
  required double buttonCancelTextSize,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
          child: Text(
            confirmationMsg,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFF000000),
            ),
          ),
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      onClickCancel();
                    },
                    child: Text(
                      buttonTextForCancel,
                      style: TextStyle(
                          fontSize: buttonCancelTextSize,
                          fontWeight: FontWeight.bold,
                          color: buttonCancelTextColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      onClickOk();
                    },
                    child: Text(
                      buttonTextForOk,
                      style: TextStyle(
                          fontSize: buttonOkTextSize,
                          fontWeight: FontWeight.bold,
                          color: buttonOkTextColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      );
    },
  );
}
