import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.textHint,
    required this.isObscure,
    required this.keyboard,
  });

  final TextEditingController controller;
  final String textHint;
  final bool isObscure;
  final TextInputType keyboard;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(height: 1.2),
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboard,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: textHint,
      ),
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
