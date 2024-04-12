import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.userName,
  });

  final String firstName;
  final String lastName;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.amber[800],
              child: Image.asset(
                'assets/images/login-profile.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${toBeginningOfSentenceCase(firstName)} ${toBeginningOfSentenceCase(lastName)}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
