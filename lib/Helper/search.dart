import 'package:chatapp/Helper/chat.dart';
import 'package:chatapp/Helper/constants.dart';
import 'package:chatapp/Helper/database.dart';
import 'package:chatapp/Helper/sharedData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class searchScreen extends StatefulWidget {
  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {

  QuerySnapshot querySnapshot;
  TextEditingController searchText = new TextEditingController();
  DataBaseMethod dataBaseMethod = new DataBaseMethod();

  startConversation(String username2){
    List<String> users = [constants.myName,username2];
    String chatRoomId = getChatRoomId(users[0],users[1]);
    
    Map<String,dynamic> chatRoomMap = {
      "users" : users,
      "chatRoomId" : chatRoomId
    };
    dataBaseMethod.createChatRoom(chatRoomId, chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => ChatScreen(username2,chatRoomId)
    ));
     }

  Widget userListTile(username,email){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      
    
      child : Row(
        children: <Widget>[
          Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children: <Widget>[
              
              Text(username,style: TextStyle(fontWeight: FontWeight.bold),),
              Text(email,style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
          Spacer(),
          GestureDetector(

            onTap:(){

              startConversation(username);
            } ,
          child : Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Text("message",style:  TextStyle(color: Colors.white)),
          )
          )
        ],
      )
    );

  }

  Widget searchList(){
    return querySnapshot!=null&&querySnapshot.documents!=null ? ListView.builder(
      shrinkWrap: true,
      itemCount: querySnapshot.documents.length,
      itemBuilder: (context , index){
        if(querySnapshot.documents[index].data["isVerified"]==true) return userListTile(querySnapshot.documents[index].data["name"], querySnapshot.documents[index].data["email"]);
      },
    ) : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

    appBar: AppBar(
      title: Text("Chat Room"),
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
    child: Column(
      children: <Widget>[
        Container(
          color: Color(0xFF444152),
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 5),
        child : Row(
          children: <Widget>[
            Expanded(
             child : TextField(
               controller: searchText,
               cursorColor: Colors.black,
               decoration: new InputDecoration(
                 hintText: "search username",
                 hintStyle: TextStyle(
                   color: Colors.white24
                 ),
                 border: InputBorder.none,
              
                
               ),
            )),
            GestureDetector(
              onTap: () {
                if(searchText!=null) dataBaseMethod.getUserbyName(searchText.text).then((val){
                  setState(() {
                    querySnapshot = val;
                  });
                });
                searchText.text = "";
              },
            child : Container(
             height: 40,
             width: 40,
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [
                   const Color(0x36FFFFFF),
                   const Color(0x0FFFFFFF)
                 ]
               ),
                borderRadius: BorderRadius.circular(40)
             ), 
            
            child : Icon(Icons.search)
            )
            )
          ],
        )
        ),
        searchList()
      ],
    ),
    )  
    );
  }
}


String getChatRoomId(String a,String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }
    else return  "$a\_$b";
}