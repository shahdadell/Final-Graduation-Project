import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // استوردنا عشان FilteringTextInputFormatter
import 'package:graduation_project/Theme/theme.dart';

class TextFiledSignup extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextInputType type;
  final TextInputAction action;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool password;
  final List<TextInputFormatter>? inputFormatters; // أضفنا inputFormatters

  const TextFiledSignup({
    super.key,
    required this.text,
    required this.type,
    required this.action,
    required this.icon,
    required this.controller,
    required this.validator,
    this.password = false,
    this.inputFormatters, // أضفنا inputFormatters
  });

  @override
  State<TextFiledSignup> createState() => _TextFiledSignupState();
}

class _TextFiledSignupState extends State<TextFiledSignup> {
  bool isObscured = true;

  void togglePasswordVisibility() {
    setState(() {
      isObscured = !isObscured;
    });

    if (!isObscured) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isObscured = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: MyTheme.blackColor),
      obscureText: widget.password ? isObscured : false,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.type,
      textInputAction: widget.action,
      inputFormatters: widget.inputFormatters, // أضفنا inputFormatters
      decoration: InputDecoration(
        label: Text(
          widget.text,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: Color(0xffF87146)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffb80505), width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffb80505), width: 1.2),
        ),
        suffixIcon: widget.password
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: togglePasswordVisibility,
              )
            : Icon(widget.icon, color: Colors.grey),
      ),
    );
  }
}
