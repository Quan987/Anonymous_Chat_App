import 'package:flutter/material.dart';
import 'package:hw4/controllers/firebase_controller.dart';
import 'package:hw4/services/login_register_service.dart';
import 'package:hw4/widgets/submit_button_widget.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  final controller = FirebaseController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework 4".toUpperCase()),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 80),
            child: Image.asset('assets/images/logo.png'),
          ),
          Text(
            "Welcome to My Chat App",
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.amber[800],
              letterSpacing: 1.4,
            ),
          ),
          const SizedBox(height: 80),
          MyButton(
            name: "Start App",
            onTap: () => {
              controller.logout(),
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginRegisterService(),
              )),
            },
          ),
        ],
      ),
    );
  }
}
