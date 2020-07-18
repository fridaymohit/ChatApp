import 'package:chatapp/Helper/authenticate.dart';
import 'package:chatapp/Helper/chatRoom.dart';
import 'package:chatapp/Helper/sharedData.dart';
import 'package:flutter/material.dart';
import 'Helper/signIn.dart';
import 'loader/loader1.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isUserLogIn = false;
  @override
  void initState() {
    getLogInState();
    super.initState();
  }

  getLogInState() async{
    await sharedMethod.getLogInPreference().then((val){
      setState(() {
        isUserLogIn = val;
      });
    });
  }

  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      
      home: isUserLogIn !=null ? isUserLogIn ? chatRoom() : Authenticate() : Authenticate(),
    );
  }
}

class Loading extends StatefulWidget {
 
  final Color backgroundColor1= Color(0xFF444152);
  final Color backgroundColor2 = Color(0xFF6f6c7d);
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [widget.backgroundColor1, widget.backgroundColor2], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column( 
        children : <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
          ),
          ColorLoader(
      color1: Colors.redAccent,
      color2: Colors.deepPurple,
      color3: Colors.green,
    )
        ]
      )
    ) ;
  }
}