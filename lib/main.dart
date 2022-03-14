import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seeu/helper/authenticate.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/view/chatlist_view.dart';
import 'package:seeu/view/signin_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    getUserLoggedInInfo();
    super.initState();
  }

  getUserLoggedInInfo() async{
    await SharedPreference_Functions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        if(value!=null){
          userIsLoggedIn=value;
        }else{
          userIsLoggedIn=false;
        }
      });
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF26A69A),
        primarySwatch: Colors.teal,
      ),
      home: userIsLoggedIn ? const ChatList() : const Signin(),
    );
  }
}

