import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/widgets/loading_widget.dart';
import 'package:hw4/controllers/navbar_controller.dart';
import 'package:hw4/widgets/user_display_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return Scaffold(
      drawer: const NavBarController(),
      appBar: AppBar(
        title: Text("Message Board".toUpperCase()),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingWidget()
          : StreamBuilder<QuerySnapshot>(
              stream: _userStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                final userDoc = snapshot.data?.docs;
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: userDoc!.length,
                  itemBuilder: (context, index) {
                    if (controller.getCurrentUserUid() !=
                        userDoc[index]["id"]) {
                      return UserDisplay(
                        firstName: userDoc[index]["fname"],
                        userName: userDoc[index]["username"],
                        email: userDoc[index]["email"],
                        uid: userDoc[index]["id"],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
              }),
    );
  }
}
