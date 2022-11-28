import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SsnNewTextFormField extends StatelessWidget {
  final TextEditingController? ssnController1;
  final TextEditingController? ssnController2;
  final TextEditingController? ssnController3;

  const SsnNewTextFormField(
      {@required this.ssnController1,
      @required this.ssnController2,
      @required this.ssnController3,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: ssnController1,
            keyboardType: TextInputType.number,
            maxLength: 3,
            maxLines: null,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF000000),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp('[0-9]'),
              ),
            ],
            decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: "xxx",
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF919191),
                ),
                labelText: "SSN"),
            validator: (value) {
              if (value!.isEmpty) {
                return "SSN is required";
              } else if (value.length < 3) {
                return "SSN length should be at list 3";
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextFormField(
            controller: ssnController2,
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLines: null,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF000000),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp('[0-9]'),
              ),
            ],
            decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: "xx",
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF919191),
                ),
                labelText: "SSN"),
            validator: (value) {
              if (value!.isEmpty) {
                return "SSN is required";
              } else if (value.length < 2) {
                return "SSN length should be at list 2";
              }
              return null;
            },
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextFormField(
            controller: ssnController3,
            keyboardType: TextInputType.number,
            maxLength: 4,
            maxLines: null,
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFF000000),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp('[0-9]'),
              ),
            ],
            decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                hintText: "xxxx",
                hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF919191),
                ),
                labelText: "SSN"),
            validator: (value) {
              if (value!.isEmpty) {
                return "SSN is required";
              } else if (value.length < 4) {
                return "SSN length should be at list 4";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
