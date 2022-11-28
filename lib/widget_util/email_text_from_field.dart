import 'package:flutter/material.dart';

class EmailTextFromField extends StatelessWidget {
  final TextEditingController? emailController;

  const EmailTextFromField({@required this.emailController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintText: "example@ot-software.com",
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Color(0xFF919191),
        ),
        labelText: "Email Id",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Email is required";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
    );
  }
}
