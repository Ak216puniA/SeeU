import 'package:flutter/material.dart';
import 'package:seeu/view/signin_view.dart';
import 'package:seeu/view/signup_view.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({ Key? key }) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool onSignInPage = false;

  void toggleView(){
    setState(() {
      onSignInPage = !onSignInPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(onSignInPage){
      return Signin(toggleView);
    }else{
      return SignUp(toggleView);
    }
  }
}