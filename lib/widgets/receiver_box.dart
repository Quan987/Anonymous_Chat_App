import 'package:flutter/material.dart';

class ReceiverBox extends StatelessWidget {
  const ReceiverBox({
    super.key,
    required this.currentUserId,
    required this.senderId,
    required this.message,
    required this.name,
  });

  final String currentUserId;
  final String senderId;
  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.amber[800],
            child: Image.asset(
              'assets/images/login-profile.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
                color: Colors.amber[800],
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}