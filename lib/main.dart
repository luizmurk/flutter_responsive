import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:outlook/constants.dart';
import 'package:outlook/screens/main/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    new MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Varela Round', cardColor: Colors.white),
      home: MainScreen(),
    );
  }
}
