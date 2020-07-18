import 'package:chatapp/service/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class forgetPass extends StatefulWidget {
  
  final Color backgroundColor1= Color(0xFF444152);
  final Color backgroundColor2 = Color(0xFF6f6c7d);
  final Color highlightColor = Color(0xfff65aa3);
  final Color foregroundColor= Colors.white;


  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {

  TextEditingController emailTextEditingController = new TextEditingController();
  AuthMethod authMethod = new AuthMethod();
  final formkey = GlobalKey<FormState>();
  

  resetPass(){

      if((EmailValidator.validate(emailTextEditingController.text))&&(formkey.currentState.validate())){
        authMethod.resetPassword(emailTextEditingController.text);
      }
      else{
        showDialogue("Provide valid Email Address");
      }
  }


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      body : Container(
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
        children: <Widget>[
           Form(
           key : formkey,   
           child : new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0,top: 150 ),
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
          
          ),
          Padding(
             padding: EdgeInsets.only(
             bottom: MediaQuery.of(context).viewInsets.bottom)),
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
                      resetPass(),
                     
                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(color: widget.foregroundColor),
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