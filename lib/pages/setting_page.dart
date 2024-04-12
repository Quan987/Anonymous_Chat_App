import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/widgets/user_profile_widget.dart';
import 'package:hw4/widgets/error_box_widget.dart';
import 'package:hw4/widgets/loading_widget.dart';
import 'package:hw4/widgets/submit_button_widget.dart';
import 'package:hw4/widgets/update_user_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _updatePassword = TextEditingController();
  final TextEditingController _updatePasswordConfirm = TextEditingController();
  final TextEditingController _updateDOB = TextEditingController();
  String displayFirstName = '';
  String displayLastName = '';
  String displayUserName = '';
  String email = '';
  String oldPassword = '';
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
    _updatePassword.dispose();
    _updatePasswordConfirm.dispose();
    _updateDOB.dispose();
    super.dispose();
  }

  void getUser() {
    setState(() {
      Stream<QuerySnapshot> usersStream = controller.getUsersCollection();
      usersStream.listen((event) async {
        for (var doc in event.docs) {
          if (controller.getCurrentUserUid() == await doc.get("id")) {
            displayFirstName = await doc.get("fname");
            displayLastName = await doc.get("lname");
            displayUserName = await doc.get("username");
            email = await doc.get("email");
            oldPassword = await doc.get("password");
          }
        }
      });
    });
  }

  Future<void> updateUserLogin(
      String password, String confirmPassword, String dob) async {
    if (password.isEmpty && confirmPassword.isEmpty && dob.isEmpty) {
      return;
    }
    try {
      Stream<QuerySnapshot> usersStream = controller.getUsersCollection();
      String currentUserUid = controller.getCurrentUserUid();
      await for (var snapshot in usersStream) {
        var userdoc =
            snapshot.docs.firstWhere((doc) => doc.get("id") == currentUserUid);
        DocumentReference docRef = userdoc.reference;
        if (dob.isNotEmpty) {
          await docRef.set({"dob": dob}, SetOptions(merge: true));
        }
        if (password.isNotEmpty &&
            password.length >= 6 &&
            password == confirmPassword) {
          AuthCredential cred =
              EmailAuthProvider.credential(email: email, password: oldPassword);
          await controller.getCurrentUser()?.reauthenticateWithCredential(cred);
          await controller.getCurrentUser()?.updatePassword(password);
          await docRef.set({"password": password}, SetOptions(merge: true));
        }
      }
    } on FirebaseException {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => const ErrorBox(
          title: "Error",
          description: "Please re-enter information",
        ),
      );
    }
    _updatePassword.clear();
    _updatePasswordConfirm.clear();
    _updateDOB.clear();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings".toUpperCase()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              setState(() {
                controller.logout();
                Navigator.of(context).pop();
              });
            },
          ),
        ],
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
                      // Text Field

                      UpdateUserTextField(
                        controller: _updatePassword,
                        keyboard: TextInputType.text,
                        textHint: "Enter New Password",
                        textboxHint: "Change Password",
                      ),
                      const SizedBox(height: 20),
                      UpdateUserTextField(
                        controller: _updatePasswordConfirm,
                        keyboard: TextInputType.text,
                        textHint: "Confirm Password",
                        textboxHint: "Confirm Password",
                      ),
                      const SizedBox(height: 20),
                      UpdateUserTextField(
                        controller: _updateDOB,
                        keyboard: TextInputType.text,
                        textHint: "MM-DD-YY (example: 12-1-2000)",
                        textboxHint: "Change Date of Birth",
                      ),
                      const SizedBox(height: 80),
                      MyButton(
                        name: "Update User Info",
                        onTap: () => updateUserLogin(
                          _updatePassword.text.trim(),
                          _updatePasswordConfirm.text.trim(),
                          _updateDOB.text.trim(),
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
