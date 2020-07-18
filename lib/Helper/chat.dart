

import 'dart:async';

import 'package:chatapp/Helper/constants.dart';
import 'package:chatapp/Helper/database.dart';
import 'package:chatapp/Helper/sharedData.dart';
import 'package:chatapp/loader/loader1.dart';
import 'package:chatapp/service/auth.dart';
import 'package:flutter/material.dart';

import 'authenticate.dart';

class ChatScreen extends StatefulWidget {

  final Color backgroundColor1= Color(0xFF444152);
  final Color backgroundColor2 = Color(0xFF6f6c7d);
  final username2;
  final chatRoomId;
  

  ChatScreen(this.username2,this.chatRoomId);
  
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

 AuthMethod authMethod = new AuthMethod();
 DataBaseMethod dataBaseMethod = new DataBaseMethod();
 TextEditingController messageText = new TextEditingController();
 Stream chatStream;
 ScrollController _controller = ScrollController();




 Widget chatList(){
   return 
   StreamBuilder(
     stream: chatStream,
     builder: (context,snapshot){
       if(snapshot.data!=null){
       return ListView.builder(
         controller: _controller,
         itemCount: snapshot.data.documents.length,
         itemBuilder: (context,index){
          return ChatTile(snapshot.data.documents[index].data["message"],snapshot.data.documents[index].data["sendBy"] == constants.myName);
         } ,
       );
       }
       else return Container();
     },
   );
 }

  scrollToBottom(){
    Timer(
      Duration(milliseconds: 300),
      () => _controller
     .jumpTo(_controller.position.maxScrollExtent));
  }
  
  @override
  void initState() {
    dataBaseMethod.getChat(widget.chatRoomId).then((val){
        setState(() {
     chatStream = val;
    });
    });
    scrollToBottom();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.username2),
    ),  
      body: SingleChildScrollView( 
        child : Container(
          padding: EdgeInsets.only(top: 10),
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
      child: Stack(
       children: <Widget>[
         new Container(
           height: MediaQuery.of(context).size.height*0.85 ,
          width: MediaQuery.of(context).size.width,
          child : chatList(),
         ),
          Container(
          alignment: Alignment.bottomCenter,
          child: Container(
          color: Color(0xFF444152),
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 5),
        child : Row(
          children: <Widget>[
            Expanded(
             child : TextField(
               controller: messageText,
               cursorColor: Colors.black,
               decoration: new InputDecoration(
                 hintText: "message",
                 hintStyle: TextStyle(
                   color: Colors.white24
                 ),
                 border: InputBorder.none,
              
                
               ),
            )),
            GestureDetector(
              onTap: () {
                if(messageText.text.isNotEmpty){
                dataBaseMethod.addChat(widget.chatRoomId, {"message" :messageText.text ,"sendBy" : constants.myName,"time" : DateTime.now().millisecondsSinceEpoch});
                messageText.text = "";
                }
              scrollToBottom();
              },
            child : Container(
             height: 50,
             width: 50,
            child : Icon(Icons.send)
            )
            )
          ],
        )
        ),
      
    )  
        ],
      ),
    ),
      )
    );

  }
}

class ChatTile extends StatelessWidget {

  final message;
  final bool isSentByMe; 
  ChatTile(this.message,this.isSentByMe);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding : EdgeInsets.only(left: isSentByMe ? 0 : 16 , right: isSentByMe ? 16 : 0),
      width: MediaQuery.of(context).size.width,
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child : Container(
      margin: EdgeInsets.symmetric(vertical : 5),
      padding : EdgeInsets.symmetric(horizontal : 24,vertical : 14),
      decoration: BoxDecoration(
        
        gradient: LinearGradient(
          colors: isSentByMe ?
          [Color(0xff007EF4) , Color(0xff2A75BC)] :
          [Color(0x1AFFFFFF) , Color(0x1AFFFFFF)]
        ),
        borderRadius: isSentByMe ? BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomLeft: Radius.circular(23)
        ) : BorderRadius.only(
          topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)
        )

      ),
    
      child: Text(message ,style: TextStyle(
        color: Colors.white,
        fontSize: 17
      ),),
    )
    );
  }
}