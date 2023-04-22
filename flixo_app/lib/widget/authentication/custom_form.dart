import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(
      {required this.controller,
      required this.hintText,
      required this.labelText,
      required this.field,
      required this.validator,
      required this.obscureText,
      super.key});
  final String hintText;
  final TextEditingController controller;
  final String labelText;
  final ValueNotifier<String> field;
  final String? Function(String?)? validator;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText
      ,
      autocorrect: true,
      cursorColor: Colors.black,
      textAlign: TextAlign.left,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        helperMaxLines: 1,
        fillColor: Colors.white,
        labelText: labelText,
        focusColor: const Color(0xFF00BDC6),
      ),
      onSaved: (value) => field.value = value!,
    );
  }
}
