import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String? errorMsg;

  const ErrorTextWidget({@required this.errorMsg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMsg!,
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF717171)),
    );
  }
}
