import 'package:flutter/material.dart';
import 'package:seeu/widgets/widget.dart';

class Signin extends StatefulWidget {
  const Signin({ Key key }) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SeeU')),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextField(
                style: inputTextStyle(),
                decoration: textfieldInputDecoration("Email"),
              ),
              TextField(
                style: inputTextStyle(),
                decoration: textfieldInputDecoration("Password"),
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text("Forgot Password ?", style: inputTextStyle(),),
              ),
              ),
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 17),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),

                ),
                child: Text("Sign In", style: TextStyle(color: Colors.white , fontSize: 21),),
              ),
              SizedBox(height: 8,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Sing In with Google", style: TextStyle(color: Colors.white, fontSize: 21)),
              ),
              SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Donot have an account? ", style: inputTextStyle()),
                  Text("Sign Up", style: TextStyle(
                    color: Colors.black87, fontSize: 17,
                    decoration: TextDecoration.underline,
                    )
                  )
                ],

              )


            ]  
          ),
        )  
    );
  }
}