import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/widgets/user_profile_widget.dart';
import 'package:hw4/widgets/loading_widget.dart';
import 'package:hw4/widgets/submit_button_widget.dart';
import 'package:hw4/widgets/update_user_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _updateFirstName = TextEditingController();
  final TextEditingController _updateLastName = TextEditingController();
  final TextEditingController _updateUsername = TextEditingController();
  String displayFirstName = '';
  String displayLastName = '';
  String displayUserName = '';
  bool _isLoading = true;
  final FirebaseController controller = FirebaseController.instance;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        getUser();
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _updateFirstName.dispose();
    _updateLastName.dispose();
    _updateUsername.dispose();
    super.dispose();
  }

  void getUser() {
    Stream<QuerySnapshot> usersStream = controller.getUsersCollection();
    usersStream.listen((event) async {
      for (var doc in event.docs) {
        if (controller.getCurrentUserUid() == await doc.get("id")) {
          displayFirstName = await doc.get("fname");
          displayLastName = await doc.get("lname");
          displayUserName = await doc.get("email");
          setState(() {});
        }
      }
    });
  }

  Future<void> updateUserProfile(
      String firstname, String lastname, String username) async {
    if (firstname.isEmpty && lastname.isEmpty && username.isEmpty) {
      return;
    }
    try {
      Stream<QuerySnapshot> usersStream = controller.getUsersCollection();
      usersStream.listen((event) async {
        for (var doc in event.docs) {
          if (controller.getCurrentUserUid() == doc.get("id")) {
            DocumentReference docRef = doc.reference;
            if (firstname.isNotEmpty) {
              await docRef.update({"fname": firstname});
            }
            if (lastname.isNotEmpty) {
              await docRef.update({"lname": lastname});
            }
            if (username.isNotEmpty) {
              await docRef.update({"username": username});
            }
          }
        }
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }
    _updateFirstName.clear();
    _updateLastName.clear();
    _updateUsername.clear();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".toUpperCase()),
        centerTitle: true,
      ),
      body: _isLoading
          ? const LoadingWidget()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Center(
                  child: Column(
                    children: [
                      UserProfile(
                        firstName: displayFirstName,
                        lastName: displayLastName,
                        userName: displayUserName,
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 12),
                      // Text Form Field
                      UpdateUserTextField(
                        controller: _updateFirstName,
                        keyboard: TextInputType.name,
                        textHint: "Enter First Name",
                        textboxHint: "Change First Name",
                      ),
                      const SizedBox(height: 20),
                      UpdateUserTextField(
                        controller: _updateLastName,
                        keyboard: TextInputType.name,
                        textHint: "Enter Last Name",
                        textboxHint: "Change Last Name",
                      ),
                      const SizedBox(height: 20),
                      UpdateUserTextField(
                        controller: _updateUsername,
                        keyboard: TextInputType.name,
                        textHint: "Enter Username",
                        textboxHint: "Change Username",
                      ),
                      const SizedBox(height: 80),
                      MyButton(
                        name: "Change Profile",
                        onTap: () => updateUserProfile(
                          _updateFirstName.text,
                          _updateLastName.text,
                          _updateUsername.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
