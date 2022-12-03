import 'package:flutter/material.dart';

class AddNameTextFormField extends StatelessWidget {
  final TextEditingController? nameController;
  const AddNameTextFormField({@required this.nameController, Key? key})
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
      inputFormatters: [],
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Item Name",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Item Name"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Name is required";
        } else if (value.length < 4) {
          return "Name length should be at list 6";
        }
        return null;
      },
    );
  }
}
