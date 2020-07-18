import 'package:chatapp/Helper/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';


class AuthMethod{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  DataBaseMethod dataBaseMethod = new DataBaseMethod();

  User _userFromFireBase(FirebaseUser user){

    return user!=null ? new User(userId: user.uid) : null;
  }

  Future signInEmail(String email,String password) async {

    try{

    AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);

    if(result==null) return null;

    if(!result.user.isEmailVerified) return null;

    QuerySnapshot val = await dataBaseMethod.getUserbyEmail(email);

      if(val.documents[0].data["isVerified"]==false)  dataBaseMethod.verifyUser(email);
    

    return _userFromFireBase(result.user);
    }
    catch(e){

    } 
  }

  Future signUpEmail(String email,String password,String username) async {

        
    QuerySnapshot val = await dataBaseMethod.getUserbyEmail(email);
         
      if(!val.documents.isEmpty){
         return new User(userId : "___");
      }
    

    val = await dataBaseMethod.getUserbyName(username);
     
      if(!val.documents.isEmpty){
         return new User(userId : "_+_");
      }
    
    try{

    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);

    await result.user.sendEmailVerification();

    return _userFromFireBase(result.user);

    

    }
    catch(e){

    }
  }
  
  Future resetPassword(String email) async {
    
    try{
    return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){

    }
  }

  Future signOut() async{
    try{
    return await _auth.signOut();
    }
    catch(e){
      
    }
  }

}