import 'package:flutter/material.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
      ),
      title: Text(
        title.toUpperCase(),
        style: const TextStyle(letterSpacing: 2),
      ),
      onTap: onTap,
    );
  }
}
