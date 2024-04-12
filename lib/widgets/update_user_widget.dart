import 'package:flutter/material.dart';

class UpdateUserTextField extends StatelessWidget {
  const UpdateUserTextField({
    super.key,
    required this.controller,
    required this.keyboard,
    required this.textHint,
    required this.textboxHint,
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String textHint;
  final String textboxHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textboxHint.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          style: const TextStyle(height: 1.2),
          controller: controller,
          keyboardType: keyboard,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: textHint,
          ),
        ),
      ],
    );
  }
}
