import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("Users").where("Name", isEqualTo: username).get();
  }

   Future<QuerySnapshot<Map<String, dynamic>>> getUserByUserEmail(String useremail) async{
    return await FirebaseFirestore.instance.collection("Users").where("Email", isEqualTo: useremail).get();
  }

  uploadUserInfoToDatabase(userMap){
    FirebaseFirestore.instance.collection("Users").add(userMap);
  }

  createChatroom(String chatroomId, chatroomMap){
    FirebaseFirestore.instance.collection("Chatrooms").doc(chatroomId).set(chatroomMap)
    .catchError((e){ print(e.toString());});
  }
}