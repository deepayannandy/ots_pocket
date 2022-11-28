import 'package:flutter/material.dart';

showAlertPopUpForErrorMsg(
    {required BuildContext context,
    required String title,
    required String errorMsg,
    required VoidCallback onClickOk}) {
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
            errorMsg,
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
              TextButton(
                onPressed: () {
                  onClickOk();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF157B4F)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
