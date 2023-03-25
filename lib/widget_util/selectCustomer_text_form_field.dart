import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';

class CustomerTextFormField extends StatelessWidget {
  final TextEditingController? customerController;
  final List<String>? hints;
  const CustomerTextFormField(
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
          hintText: "Select Client",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF919191),
          ),
          labelText: "Client Name"),
      validator: (value) {
        if (value!.isEmpty) {
          return "Customer Name is required";
        }
        return null;
      },
      suggestions: hints!.map((e) => SearchFieldListItem(e)).toList(),
      maxSuggestionsInViewPort: 6,
    );
  }
}
