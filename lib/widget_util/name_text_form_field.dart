import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameTextFormField extends StatelessWidget {
  final TextEditingController? nameController;
  const NameTextFormField({@required this.nameController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.none,
      maxLength: 50,
      maxLines: null,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp('[A-Za-z ]'),
        ),
      ],
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Your Name",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Full Name"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Name is required";
        } else if (value.length < 8) {
          return "Name length should be at list 6";
        }
        return null;
      },
    );
  }
}
