import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seeu/services/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  int n=0;
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
      /*for (var element in val.docs) {
        setState(() {
          // ignore: avoid_print
        searchSnapshot.insert(0, element.data());
        });
      }
      print(searchSnapshot);*/
    });
  }


  Widget searchList(){
    return n != 0 ? ListView.builder(itemCount: n, shrinkWrap: true, itemBuilder :(context, index) {
      return SearchTile(userName: searchSnapshot[index]['Name'], userEmail: searchSnapshot[index]['Email']);
    }) : Container();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SeeU")),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
                      padding: EdgeInsets.all(16),
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
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  const SearchTile({ Key? key , required this.userName , required this.userEmail }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
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
          Spacer(flex: 5,),
          Icon(Icons.message_rounded , color: Colors.teal[600] , size: 27,),
      ],
      )
    );
  }
}