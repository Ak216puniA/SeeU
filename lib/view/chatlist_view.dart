import 'package:flutter/material.dart';
import 'package:seeu/helper/authenticate.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/services/auth.dart';
import 'package:seeu/view/search.dart';
import 'package:seeu/view/signin_view.dart';

class ChatList extends StatefulWidget {
  const ChatList({ Key? key }) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  AuthMethods authMethods = AuthMethods();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await SharedPreference_Functions.getUserNameSharedPreference()) as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeeU'),
        actions: [
          GestureDetector(
            onTap: (){
              SharedPreference_Functions.saveUserLoggedInSharedPreference(false);
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Signin()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.exit_to_app_rounded),
            ),
          )          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
          },
        child: const Icon(Icons.search_rounded),
      )
      
    );
  }
}