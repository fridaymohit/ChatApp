 import 'package:chatapp/Helper/signIn.dart';
import 'package:chatapp/service/auth.dart';
import 'package:flutter/material.dart';

 class chatRoom extends StatefulWidget {
   @override
   _chatRoomState createState() => _chatRoomState();
 }
 
 class _chatRoomState extends State<chatRoom> {

   AuthMethod authMethod = new AuthMethod();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
    resizeToAvoidBottomPadding: false,

    appBar: AppBar(
      title: Text("Chat Room"),
      actions: <Widget>[
        GestureDetector(
          onTap: (){
            authMethod.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => SignInScreen()
            ));
          },
        )
      ], 
    ),  
    body : Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [Color(0xFF444152), Color(0xFF6f6c7d)], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
    )
     );
   }
 }