import 'package:flutter/material.dart';
import 'package:seeu/helper/authenticate.dart';
import 'package:seeu/services/auth.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/chatlist_view.dart';
import 'package:seeu/view/signin_view.dart';
import 'package:seeu/widgets/widget.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  const SignUp.a({ Key? key, required this.toggle }) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formkey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController usernameTextEdittingController = new TextEditingController();
  TextEditingController emailTextEdittingController = new TextEditingController();
  TextEditingController passwordTextEdittingController = new TextEditingController();

  bool is_loading = false;

  signUpLoading(){
    if(formkey.currentState!.validate()){

      Map<String, String> userInfoMap = {
        "Name" : usernameTextEdittingController.text,
        "Email" : emailTextEdittingController.text,
      };

      setState(() {
        is_loading = true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEdittingController.text, passwordTextEdittingController.text)
      .then((value){ 
        print("$value");

        databaseMethods.uploadUserInfoToDatabase(userInfoMap);

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatList()      
        ));
      
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SeeU')),
        body: is_loading ? Container (
          child: Center(child: CircularProgressIndicator()),
        ) : Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (entered_value){
                        return entered_value!=null && entered_value.length>3 ? null : "Username should have atleast 4 characters";
                      },
                      controller: usernameTextEdittingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Username"),
                    ),
                    TextFormField(
                      validator: (entered_value){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(entered_value!) ? null : "Invalid email id";
                      },
                      controller: emailTextEdittingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Email"),
                    ),
                    TextFormField(
                      validator: (entered_value){
                        return entered_value!=null && entered_value.length>7 ? null : "Password should have atleast 8 characters";
                      },
                      controller: passwordTextEdittingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Password"),
                    ),
                  ],
                ),
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
              GestureDetector(
                onTap: (){
                  signUpLoading();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 17),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
              
                  ),
                  child: Text("Sign Up", style: TextStyle(color: Colors.white , fontSize: 21),),
                ),
              ),
              SizedBox(height: 8,),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text("Sing Up with Google", style: TextStyle(color: Colors.white, fontSize: 21)),
              ),
              SizedBox(height: 11,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account? ", style: inputTextStyle()),
                  GestureDetector(
                    onTap: (){
                      widget.toggle;
  
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Sign In", style: TextStyle(
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