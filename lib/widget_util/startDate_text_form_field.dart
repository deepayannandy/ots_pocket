import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SartDateTextFormField extends StatelessWidget {
  final TextEditingController? startdateController;
  const SartDateTextFormField({@required this.startdateController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: startdateController,
      keyboardType: TextInputType.datetime,
      textCapitalization: TextCapitalization.none,
      maxLength: 50,
      maxLines: null,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Start Date",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Start Date"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Start Date is required";
        } else if (value.length < 8) {
          return "Start Date length should be at list 6";
        }
        return null;
      },
    );
  }
}
