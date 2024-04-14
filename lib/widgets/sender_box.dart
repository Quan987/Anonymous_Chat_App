import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderBox extends StatelessWidget {
  const SenderBox({
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
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.amber[800],
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          )),
                    ),
                  ),
                  const SizedBox(width: 4),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.amber[800],
                    child: Image.asset(
                      'assets/images/login-profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  toBeginningOfSentenceCase(name),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 124, 123, 123),
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
