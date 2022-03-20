import 'package:flutter/material.dart';
import 'package:seeu/helper/constants.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/services/auth.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/chatlist_view.dart';
import 'package:seeu/view/signin_view.dart';
import 'package:seeu/widgets/widget.dart';

class SignUp extends StatefulWidget {
  
  const SignUp({ Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formkey = GlobalKey<FormState>();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  TextEditingController usernameTextEdittingController = TextEditingController();
  TextEditingController emailTextEdittingController = TextEditingController();
  TextEditingController passwordTextEdittingController = TextEditingController();

  bool isloading = false;

  signUserUp(){
    if(formkey.currentState!.validate()){

      Map<String, String> userInfoMap = {
        "Name" : usernameTextEdittingController.text,
        "Email" : emailTextEdittingController.text,
      };

      SharedPreference_Functions.saveUserNameSharedPreference(usernameTextEdittingController.text);
      SharedPreference_Functions.saveUserEmailSharedPreference(emailTextEdittingController.text);

      setState(() {
        isloading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEdittingController.text, passwordTextEdittingController.text)
      .then((value){ 
      
        databaseMethods.uploadUserInfoToDatabase(userInfoMap , emailTextEdittingController.text);

        SharedPreference_Functions.saveUserLoggedInSharedPreference(true);
        SharedPreference_Functions.saveSchedulerCreatedOnceSharedPreference(false);

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const ChatList()      
        ));
      
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SeeU')),
        body: isloading ? const Center(child: CircularProgressIndicator()) : Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (enteredValue){
                        return enteredValue!=null && enteredValue.length>3 ? null : "Username should have atleast 4 characters";
                      },
                      controller: usernameTextEdittingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Username"),
                    ),
                    TextFormField(
                      validator: (enteredValue){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(enteredValue!) ? null : "Invalid email id";
                      },
                      controller: emailTextEdittingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Email"),
                    ),
                    TextFormField(
                      validator: (enteredvalue){
                        return enteredvalue!=null && enteredvalue.length>7 ? null : "Password should have atleast 8 characters";
                      },
                      controller: passwordTextEdittingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Password"),
                    ),
                  ],
                ),
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
              GestureDetector(
                onTap: (){
                  signUserUp();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
              
                  ),
                  child: const Text("Sign Up", style: TextStyle(color: Colors.white , fontSize: 21),),
                ),
              ),
              const SizedBox(height: 8,),
              /*Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[400],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text("Sing Up with Google", style: TextStyle(color: Colors.white, fontSize: 21)),
              ),
              const SizedBox(height: 11,),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account? ", style: inputTextStyle()),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Signin()));
  
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Sign In", style: TextStyle(
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
        ),
    );
  }
}