import 'package:flutter/material.dart';
import 'package:oop_lab22/person.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing app',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: WelcomePage(title: 'Drawing board'),
    );
  }
}
