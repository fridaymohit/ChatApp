 import 'package:chatapp/Helper/authenticate.dart';
import 'package:chatapp/Helper/chat.dart';
import 'package:chatapp/Helper/constants.dart';
import 'package:chatapp/Helper/database.dart';
import 'package:chatapp/Helper/search.dart';
import 'package:chatapp/Helper/sharedData.dart';
import 'package:chatapp/Helper/signIn.dart';
import 'package:chatapp/service/auth.dart';
import 'package:flutter/material.dart';

 class chatRoom extends StatefulWidget {
   @override
   _chatRoomState createState() => _chatRoomState();
 }
 
 class _chatRoomState extends State<chatRoom> {

   Widget chatList(){
   return 
   StreamBuilder(
     stream: chatRoomList,
     builder: (context,snapshot){
       if((snapshot.data!=null)&&(snapshot.data.documents!=null)){
       return ListView.builder(
         itemCount: snapshot.data.documents.length,
         itemBuilder: (context,index){
          return ChatRoomTile(snapshot.data.documents[index].data["chatRoomId"],snapshot.data.documents[index].data["users"]);
         } ,
       );
       }
       else return Container();
     },
   );
 }


   @override
   void initState(){
     getInfo();
      getChatRoomList(constants.myName);
     super.initState();
   }

    getChatRoomList(String username) {
      dataBaseMethod.getChatRoom(constants.myName).then((val){
      setState(() {
        chatRoomList = val;
      });
    });
    }
   getInfo() async{
    
    constants.myName = await sharedMethod.getNamePreference();
   }

   AuthMethod authMethod = new AuthMethod();
   DataBaseMethod dataBaseMethod = new DataBaseMethod();
   Stream chatRoomList;
    
   
   @override
   Widget build(BuildContext context) {
     return Scaffold(
    resizeToAvoidBottomPadding: false,

    appBar: AppBar(
      title: Text("Chat Room"),
      actions: <Widget>[
        GestureDetector(
          onTap: (){
            sharedMethod.setLogInPreference(false);
            authMethod.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Authenticate()
            ));
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.exit_to_app),
          ),
        )
      ], 
    ),  
    floatingActionButton:  FloatingActionButton(
      child : Icon(Icons.search),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => searchScreen()
        ));
      },
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
    child: chatList(),
    )
     );
   }
 }

 class ChatRoomTile extends StatelessWidget {

   final String chatRoomId;
   final List users;
   ChatRoomTile(this.chatRoomId,this.users);

  String getUser2(){
    if(users[0]==constants.myName) return users[1];
    else return users[0];
  }

   @override
   Widget build(BuildContext context) {
     return GestureDetector(
     onTap: (){
       Navigator.push(context,MaterialPageRoute(
         builder: (context) => ChatScreen(getUser2(), chatRoomId)
       ));
     },   
     child : Container(
       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
       padding: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
       decoration: BoxDecoration(
         gradient: LinearGradient(
          colors:[Color(0x1AFFFFFF) , Color(0x1AFFFFFF)]
           
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(30)
        )
       ),
       child : Row(
         children: <Widget>[
           Container(
             height: 40,
             width: 40,
             alignment: Alignment.center,
             decoration: BoxDecoration(
               color: Colors.blue,
               borderRadius: BorderRadius.circular(40)
             ),
             child: Text("${getUser2().substring(0,1).toUpperCase()}",style: TextStyle(
               fontWeight: FontWeight.w600,
               fontSize: 20,
             ),),
           ),
           SizedBox(width: 8,),
            Text(getUser2(),style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400
            ),)
         ],
       )
       
     )
     );
   }
 }