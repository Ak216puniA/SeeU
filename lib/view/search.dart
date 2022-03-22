
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/chatroom_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  int n=0;
  // ignore: prefer_typing_uninitialized_variables
  var searchSnapshot;

  startSearch(){
    databaseMethods.getUserByUsername(searchTextEditingController.text.trim()).then((val){
      // ignore: prefer_typing_uninitialized_variables
      n=val.docs.length;
      // ignore: deprecated_member_use
      searchSnapshot = List<QueryDocumentSnapshot<Map<String, dynamic>>>.filled(n, val.docs[0]);
      setState(() {
        for(int i=1 ; i<n ; i++){
        searchSnapshot[i]=val.docs[i];
      }
      });
    });
  }

  getChatroomId(String username1 , String username2){
  if(username1.length!=username2.length){
    if(username1.length<username2.length){
      return username1+"_"+username2;
    }else{
      return username2+"_"+username1;
    }
  }else{
    bool b=false;
    for(int i=0 ; i<username1.length && b==false ; i++){
      if(username1.codeUnitAt(i)!=username2.codeUnitAt(i)){
        if(username1.codeUnitAt(i)<username2.codeUnitAt(i)){
          return username1+"_"+username2;
        }else{
          return username2+"_"+username1;
        }
      }
    }
    if(b==false) return null;
  }
  }

  createChatroomAndStartConvo(String userName){

      List<String> users = [userName, Constants.myName];
      
      String chatroomId = getChatroomId(userName, Constants.myName);

      Map<String, dynamic> chatroomMap;
      
      chatroomMap = { "Users" : users , "Chatroom_id" : chatroomId };
     
      databaseMethods.createChatroom(chatroomId, chatroomMap);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Chatroom(chatRoomId: chatroomId, theOtherUser: userName,)));
  }

  Widget searchList(){
    return n != 0 ? ListView.builder(itemCount: n, shrinkWrap: true, itemBuilder :(context, index) {
      return searchTile(userName: searchSnapshot[index]['Name'], userEmail: searchSnapshot[index]['Email']);
    }) : Container();
  }

  Widget searchTile({required String userName , required String userEmail}){

   return GestureDetector(
      onTap: (){
        // ignore: unrelated_type_equality_checks
        if(userEmail != SharedPreference_Functions.getUserEmailSharedPreference()){
            createChatroomAndStartConvo(userName);
        }else{
          // ignore: non_constant_identifier_names
          const snackBar = SnackBar(content: Text("You cannot create a chatroom with yourself"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName, 
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),  
                ),
                Text(
                  userEmail,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ), 
                ),
              ],
            ),
            const Spacer(flex: 5,),
            Icon(Icons.message_rounded , color: Colors.teal[600] , size: 27,),
        ],
        )
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SeeU")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            color: Colors.teal[100],
            child: Row(
              children: [
                Expanded (
                  child: TextField(
                    controller: searchTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Search Username...",
                      hintStyle: TextStyle(
                        color: Colors.teal[300],
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      
                      border: InputBorder.none
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    startSearch();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal[200],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(Icons.search_outlined, color: Colors.teal[900] , size: 24,)
                  ),
                ),
              ],
            ),
          ),
          searchList(),
        ],),
    );
  }
}