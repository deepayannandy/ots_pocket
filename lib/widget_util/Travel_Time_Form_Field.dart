import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Travel_Time extends StatelessWidget {
  final TextEditingController? nameController;
  const Travel_Time({@required this.nameController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.none,
      maxLength: 50,
      maxLines: null,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(
      //     RegExp('[A-Za-z ]'),
      //   ),
      // ],
      decoration: InputDecoration(
          suffixText: "Hour(s)",
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Travel Time",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Travel Time"),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Travel Time is required";
        }
        return null;
      },
    );
  }
}
