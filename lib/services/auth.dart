import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_applicationtest/model/user.dart';
import 'package:flutter_applicationtest/services/data.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on Firebase User
  UserModel _UserModelFromUser(User? user){
    return UserModel(UID: user!.uid);
  }

  // auth change user stream
  Stream<UserModel> get user {
    return _auth.authStateChanges()
      .map((User? user) => _UserModelFromUser(user));
  }

  // sing in anonymous
  Future signInAnonymous() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user!;
      return _UserModelFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassowrd(TextEditingController email, TextEditingController pwd) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(email: email.text, password: pwd.text);
      User user = res.user!;  
      return _UserModelFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // register with email and password
  Future registerWithEmailAndPassowrd(TextEditingController email, TextEditingController pwd) async {
    try {
      UserCredential res = await _auth.createUserWithEmailAndPassword(email: email.text, password: pwd.text);
      User user = res.user!;
      user.sendEmailVerification(); 
      await DataService(UID: user.uid).createCart(email.text.toString(), []);
      return _UserModelFromUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      print("signing out");
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}