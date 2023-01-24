import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SsnNewConfirmTextFormField extends StatelessWidget {
  final TextEditingController? ssnController1;
  final TextEditingController? ssnController_1;

  const SsnNewConfirmTextFormField(
      {@required this.ssnController1, @required this.ssnController_1, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: ssnController1,
            keyboardType: TextInputType.number,
            maxLength: 4,
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
                hintText: "XXXX",
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF919191),
                ),
                labelText: "Confirm SSN#"),
            validator: (value) {
              if (value!.isEmpty) {
                return "SSN is required";
              } else if (value.length < 4) {
                return "SSN length should be at list 4";
              } else if (value.trim() != ssnController_1!.text.trim()) {
                return "Confirm SSN should be same as SSN";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
