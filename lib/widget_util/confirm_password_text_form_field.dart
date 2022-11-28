import 'package:flutter/material.dart';

class ConfirmPasswordTextFormField extends StatelessWidget {
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;

  const ConfirmPasswordTextFormField(
      {@required this.passwordController,
      @required this.confirmPasswordController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      controller: confirmPasswordController,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 12,
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFF000000),
      ),
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: Color(0xFF919191),
        ),
        labelText: "Confirm Password",
        //suffixIcon: InkWell(onTap: vis, child: const Icon(Icons.visibility))
      ),
      validator: (value) {
        RegExp regex = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if (value!.isEmpty) {
          return "Confirm password is required";
        } else if (!regex.hasMatch(value)) {
          return ("Password should have upper,lower,digit and Special character ");
        } else if (value.trim() != passwordController?.text.trim()) {
          return "Confirm password should be same as password";
        }
        return null;
      },
    );
  }
}
