import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class instructorTextFormField extends StatelessWidget {
  final TextEditingController? nameController;
  const instructorTextFormField({@required this.nameController, Key? key})
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
          hintText: "Supervisor Name",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Supervisor"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Supervisor is required";
        } else if (value.length < 4) {
          return "Supervisor length should be at list 4";
        }
        return null;
      },
    );
  }
}
