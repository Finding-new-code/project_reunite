
import 'package:flutter/material.dart';
import 'package:project_reunite/constants/appcolor.dart';

class TextfieldUI extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const TextfieldUI({Key? key,required this.controller,required this.hintText,required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Appcolor.lightAppColor, width: 3),
        ), enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Appcolor.darkAppColor, width: 3),
        ),
        contentPadding: const EdgeInsets.all(22),
      ),
    );
  }
}
