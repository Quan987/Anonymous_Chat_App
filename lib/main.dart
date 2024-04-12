import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hw4/firebase_options.dart';
import 'package:hw4/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Homework 4",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: Colors.amber[800],
        elevation: 2,
        shadowColor: Colors.grey,
        foregroundColor: Colors.white,
      )),
      home: SplashPage(),
    );
  }
}