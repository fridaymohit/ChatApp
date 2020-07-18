import 'package:chatapp/Helper/database.dart';
import 'package:chatapp/Helper/forgetPass.dart';
import 'package:chatapp/Helper/sharedData.dart';
import 'package:chatapp/loader/loader1.dart';
import 'package:chatapp/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chatRoom.dart';
import 'signUp.dart';
import 'package:email_validator/email_validator.dart';



class SignInScreen extends StatefulWidget{

 final Color backgroundColor1= Color(0xFF444152);
  final Color backgroundColor2 = Color(0xFF6f6c7d);
  final Color highlightColor = Color(0xfff65aa3);
  final Color foregroundColor= Colors.white;

  final Function toggle;

  SignInScreen(this.toggle);
  
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  AuthMethod authMethod = new AuthMethod();
  DataBaseMethod dataBaseMethod = new DataBaseMethod();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  final formkey = GlobalKey<FormState>();
  QuerySnapshot querySnapshot;
  bool isLoading = false;



 showDialogue(String alert) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: widget.backgroundColor1,
        title: Text('Warning' ,style: TextStyle(
          color: Colors.white,
        ),textAlign: TextAlign.center,),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(alert , style: TextStyle(
                color: Colors.white
              ),),
              
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}   
  



  signIn(){

      if((EmailValidator.validate(emailTextEditingController.text))&&(formkey.currentState.validate())){

        sharedMethod.setEmailPreference(emailTextEditingController.text);
        setState(() {
          isLoading = true;
        });
        authMethod.signInEmail(emailTextEditingController.text, passwordTextEditingController.text).then((val){
            if(val!=null){
              sharedMethod.setLogInPreference(true);
              dataBaseMethod.getUserbyEmail(emailTextEditingController.text).then((val){
                  setState(() {
                    querySnapshot = val;
                  });
                  sharedMethod.setNamePreference(querySnapshot.documents[0].data["name"]);
              });
              
               Navigator.pushReplacement(context,
         MaterialPageRoute( builder: (context) => chatRoom()) );
            }
            else{
              showDialogue("wrong username or password");
            }
              
              setState(() {
                isLoading = false;
              });
            
        });

      }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    resizeToAvoidBottomPadding: false,
    resizeToAvoidBottomInset: false,
    
    body : isLoading ? Container(
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
    ) : Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.centerLeft,
          end: new Alignment(1.0, 0.0), // 10% of the width, so there are ten blinds.
          colors: [widget.backgroundColor1, widget.backgroundColor2], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: ListView(
        
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 130.0, bottom: 55.0),
            child: Center(
              child: new Column(
                children: <Widget>[
                  Container(
                    height: 128.0,
                    width: 128.0,
                    child: new CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: widget.foregroundColor,
                      radius: 100.0,
                      child: new Text(
                        "(-_-)",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: widget.foregroundColor,
                          width: 1.0,
                        ),
                        shape: BoxShape.circle,
                        
                      ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: new Text(
                      "Chat App",
                      style: TextStyle(color: widget.foregroundColor),
                    ),
                  )
                ],
              ),
            ),
          ),
          Form(
          key : formkey,  
          child : Column(
          children: <Widget>[  
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: widget.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.alternate_email,
                    color: widget.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextFormField(
                    validator: (val){
                      return RegExp(r'^\S*$').hasMatch(val) ? null : "Provide valid email";
                    },
                    controller: emailTextEditingController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'email',
                      hintStyle: TextStyle(color: widget.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: widget.foregroundColor,
                    width: 0.5,
                    style: BorderStyle.solid),
              ),
            ),
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding:
                      EdgeInsets.only(top: 10.0, bottom: 10.0, right: 00.0),
                  child: Icon(
                    Icons.lock_open,
                    color: widget.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextFormField(
                    validator: (val) {
                      return val.length <8 || !RegExp(r'^\S*$').hasMatch(val) ? "Password length should be >=8 " : null;
                    },
                    controller: passwordTextEditingController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'password',
                      hintStyle: TextStyle(color: widget.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
           Padding(
             padding: EdgeInsets.only(
             bottom: MediaQuery.of(context).viewInsets.bottom))
          ]
          )
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 30.0),
            alignment: Alignment.center,
            
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: widget.highlightColor,
                    
                    onPressed: () => {
                      signIn()
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(color: widget.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),

          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.transparent,
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => forgetPass()
                      ))
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: widget.foregroundColor.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
         SizedBox(height: 20,),

          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0, bottom: 20.0),
            alignment: Alignment.center,
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: new FlatButton(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    color: Colors.transparent,
                    onPressed: () => widget.toggle(),
                    child: Text(
                      "Don't have an account? Create One",
                      style: TextStyle(color: widget.foregroundColor.withOpacity(0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}


