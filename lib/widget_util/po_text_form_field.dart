import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class POFormField extends StatelessWidget {
  final TextEditingController? poController;
  const POFormField({@required this.poController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: poController,
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
          hintText: "PO",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "PO#"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "PO is required";
        } else if (value.length < 8) {
          return "PO length should be at list 6";
        }
        return null;
      },
    );
  }
}
