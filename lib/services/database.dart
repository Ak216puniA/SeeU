import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seeu/helper/constants.dart';

class DatabaseMethods{
  
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("Users").where("Name", isEqualTo: username).get();
  }

   Future<QuerySnapshot<Map<String, dynamic>>> getUserByUserEmail(String useremail) async{
    return await FirebaseFirestore.instance.collection("Users").where("Email", isEqualTo: useremail).get();
  }

  uploadUserInfoToDatabase(userMap , String userEmail){
    FirebaseFirestore.instance.collection("Users").doc(userEmail).set(userMap);
  }

  createChatroom(String chatroomId, chatroomMap){
    FirebaseFirestore.instance.collection("Chatrooms").doc(chatroomId).set(chatroomMap)
    .catchError((e){ print(e.toString());});
  }

  addChatMessageToDatabase(String chatroomId , chatMap){
    FirebaseFirestore.instance.collection("Chatrooms").doc(chatroomId).collection("Chats").add(chatMap);
  }

  uploadScheduleToDatabase(schedulemap , String userEmail){  
    FirebaseFirestore.instance.collection("Users").doc(userEmail).set(schedulemap, SetOptions(merge: true));
  }

  getChatMessagesFromDatabase(String chatroomId) async{
   // ignore: await_only_futures
   return await FirebaseFirestore.instance.collection("Chatrooms").doc(chatroomId).collection("Chats").orderBy("TimeStamp",descending: false).snapshots();
  }

  getAllChatrooms(String username) async{
    // ignore: await_only_futures
    return await FirebaseFirestore.instance.collection("Chatrooms").where("Users", arrayContains: username).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getChatroomDocument(String chatRoomId) async {
    return await FirebaseFirestore.instance.collection("Chatrooms").doc(chatRoomId).get();
  }

  getDocument(String userEmail) async{
    return await FirebaseFirestore.instance.collection("Users").doc(userEmail).get();
  }

  getUserConsentOnSharingSchedule(String chatRoomId) async{
    return await FirebaseFirestore.instance.collection("Chatrooms").doc(chatRoomId).get();
  }

  updateUserConsentOnSharingSchedule(String chatRoomId , bool currentConsent) async{
    await FirebaseFirestore.instance.collection("Chatrooms").doc(chatRoomId).update({Constants.myName+"Allows": !currentConsent});
  }
}