import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:seeu/helper/authenticate.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/services/auth.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/chatroom_view.dart';
import 'package:seeu/view/search.dart';
import 'package:seeu/view/signin_view.dart';

class ChatList extends StatefulWidget {
  const ChatList({ Key? key }) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  Stream? chatroomsStream;

  Widget ChatroomsList(){
    return StreamBuilder(
      stream: chatroomsStream,
      builder: (context ,AsyncSnapshot snapshot){
        if(snapshot.data!=null){
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context , index){
              return ChatroomTile(
                chatroomId: snapshot.data.docs[index]["Chatroom_id"] , 
                username: (snapshot.data.docs[index]["Users"][0]==Constants.myName)? 
                snapshot.data.docs[index]["Users"][1] : snapshot.data.docs[index]["Users"][0]
                );
            });
        }else{
          return Container();
        }
      });
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await SharedPreference_Functions.getUserNameSharedPreference()) as String;

    databaseMethods.getAllChatrooms(Constants.myName).then((value){
      setState(() {
        chatroomsStream = value;
      });
    });
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
      body: ChatroomsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen(),));
          },
        child: const Icon(Icons.search_rounded),
      )
      
    );
  }
}

class ChatroomTile extends StatelessWidget {
  final String username;
  final String chatroomId;
  const ChatroomTile({ Key? key , required this.username , required this.chatroomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Chatroom(chatRoomId: chatroomId,)      
        ));
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF80CBC4),
            Color(0xFFB2EBF2)
          ]),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0), 
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(0))
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: const RadialGradient(colors: [
                  Color(0xFF00897B),
                  Color(0xFF00897B)]
                ),
                borderRadius: BorderRadius.circular(30)
              ),
              child : Text(username.substring(0,1).toUpperCase() , style: const TextStyle(color: Colors.white , fontSize: 21 , fontStyle: FontStyle.italic))
            ),
            const SizedBox(width: 12),
            Text(
              username,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),)
          ],
        ),
        
      ),
    );
  }
}