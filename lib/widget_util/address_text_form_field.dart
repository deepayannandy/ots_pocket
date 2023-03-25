import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressTextFormField extends StatelessWidget {
  final TextEditingController? nameController;
  const AddressTextFormField({@required this.nameController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
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
          hintText: "Address",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Address"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Address is required";
        } else if (value.length < 8) {
          return "Address length should be at list 6";
        }
        return null;
      },
    );
  }
}
