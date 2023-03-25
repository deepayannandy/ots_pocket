import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnitRateTextFormField extends StatelessWidget {
  final TextEditingController? UnitRateNumberController;

  const UnitRateTextFormField(
      {@required this.UnitRateNumberController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: UnitRateNumberController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      maxLength: 10,
      maxLines: null,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp('^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)'),
        ),
      ],
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "99.99",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "MSR"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Unit Rate is required";
        }
        return null;
      },
    );
  }
}
