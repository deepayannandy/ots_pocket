import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityTextFormField extends StatelessWidget {
  final TextEditingController? quantityNumberController;

  const QuantityTextFormField(
      {@required this.quantityNumberController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: quantityNumberController,
      keyboardType: TextInputType.number,
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
          hintText: "99",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Available Quantity"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Available Quantity is required";
        }
        return null;
      },
    );
  }
}
