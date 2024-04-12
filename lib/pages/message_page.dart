import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/widgets/loading_widget.dart';
import 'package:hw4/widgets/receiver_box.dart';
import 'package:hw4/widgets/sender_box.dart';
import 'package:hw4/widgets/textfield_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({
    super.key,
    required this.username,
    required this.uid,
    required this.firstname,
    required this.email,
  });

  final String username;
  final String uid;
  final String firstname;
  final String email;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  bool _isLoading = true;
  final TextEditingController _messageController = TextEditingController();
  final FirebaseController controller = FirebaseController.instance;

  void sendMessage(String message) async {
    if (message.isNotEmpty) {
      await controller.sendMessage(widget.uid, message);
      _messageController.clear();
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
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
        title: Text(widget.username),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingWidget()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: controller.getMessage(
                          controller.getCurrentUserUid(), widget.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Error");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const LoadingWidget();
                        }
                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                if (controller.getCurrentUserUid() ==
                                    data["senderID"]) {
                                  return SenderBox(
                                    currentUserId:
                                        controller.getCurrentUserUid(),
                                    senderId: data["senderID"],
                                    message: data["message"],
                                    name: data["senderName"],
                                  );
                                } else {
                                  return ReceiverBox(
                                    currentUserId:
                                        controller.getCurrentUserUid(),
                                    senderId: data["senderID"],
                                    message: data["message"],
                                    name: data["senderName"],
                                  );
                                }
                              })
                              .toList()
                              .cast(),
                        );
                      },
                    ),
                  ),

                  // Send mesage button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: MyTextField(
                            controller: _messageController,
                            isObscure: false,
                            keyboard: TextInputType.text,
                            textHint: "Enter Message",
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => sendMessage(_messageController.text),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
