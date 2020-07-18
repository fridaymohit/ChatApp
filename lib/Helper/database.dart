import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod{
 
  getUserbyName(String username) async{
      
      return await Firestore.instance.collection("users").where("name" ,isEqualTo : username).getDocuments();
  
  }

  getUserbyEmail(String email) async{
      
      return await Firestore.instance.collection("users").where("email" ,isEqualTo : email).getDocuments();
  
  }

  uploadUserInfo(userMap){

      String docId = userMap["email"];

      Firestore.instance.collection("users").document(docId).setData(userMap);
  }

  createChatRoom(String chatRoomId , chatRoomMap){

    Firestore.instance.collection("chatRoom").document(chatRoomId).setData(chatRoomMap);
    
  }

  addChat(String chatRoomId,messageMap){

    Firestore.instance.collection("chatRoom").document(chatRoomId).collection("chats").add(messageMap);
  }

 getChat(String chatRoomId) async{
    return await Firestore.instance.collection("chatRoom").document(chatRoomId).collection("chats").orderBy("time").snapshots();
  }

  getChatRoom(String username) async{
    return await Firestore.instance.collection("chatRoom").where("users",arrayContains: username).snapshots();
  }

  verifyUser(String email) async{


    await Firestore.instance.collection('users').document(email).setData({"isVerified" : true},merge : true);
      
  }

}