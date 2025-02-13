import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sizer/sizer.dart';


class FormBuilderCustom extends StatelessWidget {
  final String name;
  final bool obscureText;
  final String hintText;
  final String? Function(String?)? validator;
  final IconData? icon;
  final TextInputType  keytype;
  final dynamic initialValue;

  const FormBuilderCustom({super.key, 
  required this.name, 
  required this.obscureText, 
  required this.hintText, 
  this.validator, 
  this.icon,
  required this.keytype,
  this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: initialValue,
      name: name,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red, fontSize: 15.sp),
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue
          ),
          borderRadius: BorderRadius.circular(60)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue
          ),
          borderRadius: BorderRadius.circular(60)
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue
          ),
          borderRadius: BorderRadius.circular(60)
        ),
        suffixIcon: Icon(icon, color:Colors.white),
        fillColor: Colors.cyan,
        filled: true
      ),
      validator: validator,
      keyboardType: keytype,
    );
  }
}