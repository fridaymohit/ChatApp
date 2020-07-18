import 'package:chatapp/Helper/chatRoom.dart';
import 'package:chatapp/Helper/database.dart';
import 'package:chatapp/Helper/sharedData.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'signIn.dart';
import 'package:chatapp/loader/loader1.dart';
import 'package:chatapp/service/auth.dart';


class SignUpScreen extends StatefulWidget{

   final Color backgroundColor1= Color(0xFF444152);
  final Color backgroundColor2 = Color(0xFF6f6c7d);
  final Color highlightColor = Color(0xfff65aa3);
  final Color foregroundColor= Colors.white;
  final Function toggle;

  SignUpScreen(this.toggle);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  bool isLoading = false;
  

  AuthMethod authMethod = new AuthMethod();
  DataBaseMethod dataBaseMethod = new DataBaseMethod();

  

  signUp(){

    if((EmailValidator.validate(emailTextEditingController.text))&&(formKey.currentState.validate())){
     setState(() {
        isLoading = true;
      });
    
    authMethod.signUpEmail(emailTextEditingController.text , passwordTextEditingController.text,usernameTextEditingController.text).then((val){
     
       if(val.userId=="_+_"){
          showDialogue("Warning","This Username is already taken");
        }
        else if(val.userId=="___"){
          
          showDialogue("Warning","This email is already registered");
        }
        else {
        Map<String,dynamic> map = {
          "email" : emailTextEditingController.text,
          "name" : usernameTextEditingController.text,
          "isVerified" : false,
        };
        dataBaseMethod.uploadUserInfo(map);
        showDialogue("Info", "verify your email and Log In");
        
    }
    setState(() {
      isLoading = false;
    });
    
    });
  }
  
  }
showDialogue(String type,String alert) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: widget.backgroundColor1,
        title: Text(type ,style: TextStyle(
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
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}   


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    resizeToAvoidBottomPadding: false,  
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
    ) :  Container(
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
            padding: const EdgeInsets.only(top: 130.0, bottom: 50.0),
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

            key: formKey,
            child: Column(
              children: [
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
                    Icons.account_circle,
                    color: widget.foregroundColor,
                  ),
                ),
                new Expanded(
                  child: TextFormField(
                    validator: (val){
                      return val.isEmpty || val.length <5 || !RegExp(r'^\S*$').hasMatch(val) ? "length should be > 4" : null;
                    },
                    controller: usernameTextEditingController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'username',
                      hintStyle: TextStyle(color: widget.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      hintText: 'Email',
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
                    controller: passwordTextEditingController ,
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
                      signUp()
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: widget.foregroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
         SizedBox(height : 20),
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
                      "Already have account? Signin now",
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


