
import 'package:flutter/material.dart';
import 'package:seeu/helper/sharedPreference_functions.dart';
import 'package:seeu/services/auth.dart';
import 'package:seeu/services/database.dart';
import 'package:seeu/view/chatlist_view.dart';
import 'package:seeu/view/signup_view.dart';
import 'package:seeu/widgets/widget.dart';

class Signin extends StatefulWidget {  


  const Signin({ Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final formkey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods=DatabaseMethods();

  bool isLoading = false;
  var signInQuerySnapshot;

  // ignore: non_constant_identifier_names
  SignUserIn(){
    if(formkey.currentState!.validate()){
    SharedPreference_Functions.saveUserEmailSharedPreference(emailTextEditingController.text);

    databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val){
      signInQuerySnapshot = val.docs[0]['Name'];

      SharedPreference_Functions.saveUserNameSharedPreference(signInQuerySnapshot);
    });

    setState(() {
      isLoading = true;
    });

    authMethods.signInWithEmailAndPassword(emailTextEditingController.text , passwordTextEditingController.text).then((val) {
      if(val!=null){
         SharedPreference_Functions.saveUserLoggedInSharedPreference(true);
         Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const ChatList()      
        ));
      }else{
        const snackBar = SnackBar(content: Text("User not registered"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SeeU')),
        body: isLoading ? const Center(child: CircularProgressIndicator()) : Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (enteredValue){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(enteredValue!) ? null : "Invalid email id";
                      },
                      controller: emailTextEditingController,
                      style: inputTextStyle(),
                      decoration: textfieldInputDecoration("Email"),
                    ),
                    TextFormField(
                      validator: (enteredvalue){
                        return enteredvalue!=null && enteredvalue.length>7 ? null : "Password should have atleast 8 characters";
                      },
                      controller: passwordTextEditingController,
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
                    GestureDetector(
                      onTap: (){
                        SignUserIn();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30),
                            
                        ),
                        child: const Text("Sign In", style: TextStyle(color: Colors.white , fontSize: 21),),
                      ),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text("Sign Up", style: TextStyle(
                              color: Colors.black87, fontSize: 17,
                              decoration: TextDecoration.underline,
                              )
                            ),
                          ),
                        )
                      ],                          
                    )
                  ],
                ),
              ),
            ]  
          ),
        )  
    );
  }
}