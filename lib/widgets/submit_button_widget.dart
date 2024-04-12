import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.name,
    required this.onTap,
  });

  final String name;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[800],
        foregroundColor: Colors.white,
        shape: const BeveledRectangleBorder(),
        elevation: 2,
      ),
      child: Text(name.toUpperCase()),
    );
  }
}
