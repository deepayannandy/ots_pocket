import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';

class EmployeeTextFormField extends StatelessWidget {
  final TextEditingController? customerController;
  final List<String>? hints;
  const EmployeeTextFormField(
      {@required this.customerController, @required this.hints, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchField(
      controller: customerController,
      searchInputDecoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintText: "Select Employee",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Employee Name"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Employee Name is required";
        }
        return null;
      },
      suggestions: hints!.map((e) => SearchFieldListItem(e)).toList(),
      maxSuggestionsInViewPort: 6,
    );
  }
}
