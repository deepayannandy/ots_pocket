import 'package:flutter/material.dart';

class CertificateidTextFormField extends StatelessWidget {
  final TextEditingController? nameController;
  const CertificateidTextFormField({@required this.nameController, Key? key})
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
      decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Certification Id",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Certification Id"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Certification Id is required";
        } else if (value.length < 4) {
          return "Certification Id length should be at list 4";
        }
        return null;
      },
    );
  }
}
