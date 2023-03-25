import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';

class POTextFormField extends StatelessWidget {
  final TextEditingController? pocontroller;
  final List<String>? hints;
  const POTextFormField({
    @required this.pocontroller,
    @required this.hints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchField(
      controller: pocontroller,
      searchInputDecoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Select PO#",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Select PO#"),
      validator: (value) {
        if (value!.isEmpty) {
          return "PO# is required";
        }
        return null;
      },
      suggestions: hints!.map((e) => SearchFieldListItem(e)).toList(),
      maxSuggestionsInViewPort: 6,
    );
  }
}
