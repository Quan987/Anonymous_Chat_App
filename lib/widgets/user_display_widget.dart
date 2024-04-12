import 'package:flutter/material.dart';
import 'package:hw4/pages/message_page.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class UserDisplay extends StatefulWidget {
  const UserDisplay({
    super.key,
    required this.firstName,
    required this.userName,
    required this.email,
    required this.uid,
  });

  final String firstName;
  final String userName;
  final String email;
  final String uid;

  @override
  State<UserDisplay> createState() => _SingleUserDisplayState();
}

class _SingleUserDisplayState extends State<UserDisplay> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MessagePage(
              username: widget.userName,
              uid: widget.uid,
              firstname: widget.firstName,
              email: widget.email,
            ),
          ),
        );
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber[800],
            child: Image.asset(
              'assets/images/login-profile.png',
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            toBeginningOfSentenceCase(widget.firstName),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Username: ${widget.userName}",
            maxLines: 2,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
