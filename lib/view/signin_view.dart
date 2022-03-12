import 'package:flutter/material.dart';
import 'package:seeu/widgets/widget.dart';

class Signin extends StatefulWidget {  
  final Function toggle;
  // ignore: use_key_in_widget_constructors
  const Signin(this.toggle);

  const Signin.a({ Key? key, required this.toggle }) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SeeU')),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
              const SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text("Forgot Password ?", style: inputTextStyle(),),
              ),
              ),
              const SizedBox(height: 10,),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 17),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),

                ),
                child: const Text("Sign In", style: TextStyle(color: Colors.white , fontSize: 21),),
              ),
              const SizedBox(height: 8,),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text("Sing In with Google", style: TextStyle(color: Colors.white, fontSize: 21)),
              ),
              const SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Donot have an account? ", style: inputTextStyle()),
                  GestureDetector(
                    onTap: (){
                      widget.toggle;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Sign Up", style: TextStyle(
                        color: Colors.black87, fontSize: 17,
                        decoration: TextDecoration.underline,
                        )
                      ),
                    ),
                  )
                ],

              )


            ]  
          ),
        )  
    );
  }
}