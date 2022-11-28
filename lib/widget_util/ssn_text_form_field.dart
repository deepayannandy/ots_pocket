import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SsnTextFormField extends StatelessWidget {
  final TextEditingController? ssnController;

  const SsnTextFormField({@required this.ssnController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ssnController,
      keyboardType: TextInputType.number,
      maxLength: 3,
      maxLines: null,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp('[0-9]'),
        ),
      ],
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "12XXXXXX90",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "SSN Number"),
      validator: (value) {
        if (value!.isEmpty) {
          return "SSN is required";
        } else if (value.length < 9) {
          return "SSN length should be at list 9";
        }
        return null;
      },
    );
  }
}
