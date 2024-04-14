import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/pages/register_page.dart';
import 'package:hw4/widgets/error_box_widget.dart';
import 'package:hw4/widgets/submit_button_widget.dart';
import 'package:hw4/widgets/textfield_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final controller = FirebaseController.instance;

  void login(BuildContext context, String email, String password) async {
    if (email.isEmpty && password.isEmpty ||
        email.isNotEmpty && password.isEmpty ||
        email.isEmpty && password.isNotEmpty) {
      return showDialog(
        context: context,
        builder: (context) => const ErrorBox(
          title: "Error",
          description: "Please enter both email and password",
        ),
      );
    }
    try {
      await controller.getAuthentication().signInWithEmailAndPassword(
            email: email,
            password: password,
          );
    } on FirebaseAuthException {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => const ErrorBox(
          title: "Error",
          description: "Please enter email and password correctly",
        ),
      );
    }
    _email.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login".toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 200,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Image.asset('assets/images/chat.png'),
                ),
                MyTextField(
                  controller: _email,
                  isObscure: false,
                  keyboard: TextInputType.text,
                  textHint: "Enter Email",
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: _password,
                  isObscure: true,
                  keyboard: TextInputType.visiblePassword,
                  textHint: "Enter Password",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    InkWell(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      ),
                      child: Text(
                        "Register Here!",
                        style: TextStyle(
                          color: Colors.blue[600],
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue[600],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                MyButton(
                  name: "Login",
                  onTap: () => login(context, _email.text, _password.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
