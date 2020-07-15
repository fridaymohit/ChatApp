import 'package:firebase_auth/firebase_auth.dart';
import 'user.dart';


class AuthMethod{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBase(FirebaseUser user){

    return user!=null ? new User(userId: user.uid) : null;
  }

  Future signInEmail(String email,String password) async {

    AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);

    return _userFromFireBase(result.user); 
  }

  Future signUpEmail(String email,String password) async {

    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email,password: password);

    return _userFromFireBase(result.user);

  }
  
  Future resetPassword(String email) async {
   
    return await _auth.sendPasswordResetEmail(email: email);
  
  }

  Future signOut() async{

    return await _auth.signOut();
    
  }

}