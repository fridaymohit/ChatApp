import 'package:chatapp/Helper/signIn.dart';
import 'package:chatapp/Helper/signUp.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIN = true;

  void toggleShow(){
    setState(() {
      showSignIN = !showSignIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIN){
      return SignInScreen(toggleShow);
    }
    else{
      return SignUpScreen(toggleShow);
    }
  }
}