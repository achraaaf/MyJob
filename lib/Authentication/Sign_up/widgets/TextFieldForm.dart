import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final hintText;
  final prefixIcon;
  final bool obsecuretext;
  final sufixIcon;
  final TextEditingController controller;
  final validationCallback;
  final hideShowPassword;
  const TextFieldForm({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.sufixIcon,
    required this.obsecuretext,
    required this.controller,
    this.validationCallback,
    this.hideShowPassword,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      validator: validationCallback,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
              const TextStyle(fontFamily: 'Futura', color: Color(0xFF3B3B3B)),
          prefixIcon: Icon(prefixIcon),
          suffixIcon:
              IconButton(onPressed: hideShowPassword, icon: Icon(sufixIcon)),
          filled: true,
          fillColor: Colors.black.withOpacity(0.10000000149011612),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 15)),
      obscureText: obsecuretext,
    );
  }
}
