import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JTTextFormField extends StatelessWidget {
  final TextEditingController? jtController;
  const JTTextFormField({@required this.jtController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: jtController,
      keyboardType: TextInputType.name,
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
          hintText: "JT",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Task"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Task is required";
        } else if (value.length < 8) {
          return "Task length should be at list 6";
        }
        return null;
      },
    );
  }
}
