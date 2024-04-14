import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/widgets/group_widget.dart';
import 'package:hw4/widgets/loading_widget.dart';

class GroupChatMessagePage extends StatefulWidget {
  const GroupChatMessagePage({super.key});

  @override
  State<GroupChatMessagePage> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<GroupChatMessagePage> {
  bool _isLoading = true;
  final controller = FirebaseController.instance;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Chat Room".toUpperCase()),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingWidget()
          : const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    GroupChat(
                      title: "game room",
                      imagelink: 'assets/images/room-game.png',
                      roomType: 'roomgame',
                    ),
                    SizedBox(height: 20),
                    GroupChat(
                      title: "business room",
                      imagelink: 'assets/images/room-business.png',
                      roomType: 'roombusiness',
                    ),
                    SizedBox(height: 20),
                    GroupChat(
                      title: "public health room",
                      imagelink: 'assets/images/room-health.png',
                      roomType: 'roomhealth',
                    ),
                    SizedBox(height: 20),
                    GroupChat(
                      title: "study room",
                      imagelink: 'assets/images/room-study.png',
                      roomType: 'roomstudy',
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
