import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key});

  @override
  State<ChatRoomPage> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoomPage> {
  bool _isLoading = true;
  final controller = FirebaseController.instance;
  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection("users").snapshots();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
