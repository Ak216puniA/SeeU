import 'package:flutter/material.dart';
import 'package:seeu/helper/authenticate.dart';
import 'package:seeu/services/auth.dart';
import 'package:seeu/view/search.dart';

class ChatList extends StatefulWidget {
  const ChatList({ Key? key }) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeeU'),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.exit_to_app_rounded),
            ),
          )          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
          },
        child: Icon(Icons.search_rounded),
      )
      
    );
  }
}