import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DesignationTextFormField extends StatelessWidget {
  final TextEditingController? designationController;
  const DesignationTextFormField(
      {@required this.designationController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: designationController,
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
          hintText: "Designation",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Designation"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Designation is required";
        } else if (value.length < 2) {
          return "Designation length should be at list 2";
        }
        return null;
      },
    );
  }
}
