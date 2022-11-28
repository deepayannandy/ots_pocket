import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneTextFormField extends StatelessWidget {
  final TextEditingController? phoneNumberController;

  const PhoneTextFormField({@required this.phoneNumberController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneNumberController,
      keyboardType: TextInputType.phone,
      maxLength: 10,
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
          hintText: "93XXXXXX53",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Phone Number"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Phone number is required";
        } else if (value.length < 10) {
          return "Please Enter a valid phone number";
        }
        return null;
      },
    );
  }
}
