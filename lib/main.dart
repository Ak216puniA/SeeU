import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seeu/view/signin_view.dart';
import 'package:seeu/view/signup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF26A69A),
        primarySwatch: Colors.teal,
      ),
      home: const SignUp(),
    );
  }
}

