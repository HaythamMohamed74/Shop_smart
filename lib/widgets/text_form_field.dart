import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      this.hintText,
      this.validator,
      this.obscure = false,
      this.prefix,
      this.customSuffix,
      this.onChanged});

  final TextEditingController controller;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool obscure;
  final Icon? prefix;
  final Widget? customSuffix;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      obscureText: obscure,
      // onSaved: onSaved,
      decoration: InputDecoration(
          hintText: (hintText),
          prefixIcon: prefix,
          suffixIcon: customSuffix,
          // suffix: customSuffix,
          // suffixIcon: GestureDetector(
          //   onTap: () {},
          //   child: Icon(sufix),
          //   // color: Colors.blue, // Set the color to blue
          // ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
