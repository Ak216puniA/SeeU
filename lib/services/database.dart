import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("Users").where("Name", isEqualTo: username).get();
  }

  uploadUserInfoToDatabase(userMap){
    FirebaseFirestore.instance.collection("Users").add(userMap);
  }
}