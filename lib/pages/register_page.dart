import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/pages/login_page.dart';
import 'package:hw4/widgets/submit_button_widget.dart';
import 'package:hw4/widgets/textfield_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final controller = FirebaseController.instance;

  void registers(BuildContext context, String firstname, String lastname,
      String username, String email, String password) async {
    if (firstname.isEmpty ||
        lastname.isEmpty ||
        username.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Please enter all information"),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
    try {
      await controller.addUserController(
        firstname,
        lastname,
        username,
        email,
        password,
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
    _firstName.clear();
    _lastName.clear();
    _userName.clear();
    _email.clear();
    _password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register".toUpperCase()),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: MyTextField(
                        controller: _firstName,
                        isObscure: false,
                        keyboard: TextInputType.text,
                        textHint: "First Name",
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyTextField(
                        controller: _lastName,
                        isObscure: false,
                        keyboard: TextInputType.text,
                        textHint: "Last Name",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: _userName,
                  isObscure: false,
                  keyboard: TextInputType.text,
                  textHint: "Username",
                ),
                const SizedBox(height: 20),
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
                    const Text("Already have an account? "),
                    InkWell(
                      onTap: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                      child: Text(
                        "Login Here!",
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
                  name: "Register",
                  onTap: () => registers(
                    context,
                    _firstName.text,
                    _lastName.text,
                    _userName.text,
                    _email.text,
                    _password.text,
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
