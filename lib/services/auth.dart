import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seeu/modal/user.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {

    appUser? _userfromUser(User user){
      return user!=null ? appUser(userId: user.uid) : null;
    }

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromUser(user!);
        
    }catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {

    appUser? _userfromUser(User user){
      return user!=null ? appUser(userId: user.uid) : null;
    }

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromUser(user!);
        
    }catch(e){
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  } 



}