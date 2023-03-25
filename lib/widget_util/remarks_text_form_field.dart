import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RemarksForm extends StatelessWidget {
  final TextEditingController? jdcontroller;
  const RemarksForm({@required this.jdcontroller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: jdcontroller,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.none,
      maxLength: 150,
      maxLines: 3,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Remarks",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Remarks"),
    );
  }
}
