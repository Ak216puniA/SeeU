import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: const Text('SeeU'),

  );
}

InputDecoration textfieldInputDecoration(String text){
  return InputDecoration(
    hintText: text,
    hintStyle: TextStyle(
    color: Colors.black26
    ),
    focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black87)
    ),
    enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.black26)
    ),
  );
}

TextStyle inputTextStyle(){
  return TextStyle(
    color: Colors.black87,
    fontSize: 18
  );
}