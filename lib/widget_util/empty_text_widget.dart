import 'package:flutter/material.dart';

class EmptyTextWidget extends StatelessWidget {
  final String? emptyMsg;

  const EmptyTextWidget({@required this.emptyMsg, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      emptyMsg!,
      style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF717171)),
    );
  }
}
