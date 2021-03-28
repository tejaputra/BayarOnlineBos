import 'package:e_payment/data/DatabaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_payment/data/Account.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthAccount{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /*Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged
        //.map((FirebaseUser))
  }*/
  //create object base on firebase user
  Account _AccountFromFireBaseUser(FirebaseUser account){
    return account != null ? Account(uid: account.uid) : null;
  }

  //auth change account stream
  Stream<Account> get account{
    return _auth.onAuthStateChanged
        .map(_AccountFromFireBaseUser);
  }

  //getting uid
  String getCurrentUID(BuildContext context)  {
    try {
      final user = Provider.of<Account>(context);
      if (user.uid != null) {
        return user.uid;
      } else {
        return "empty";
      }
    } catch (e){
      print(e.toString());
      return 'kosong';
    }
  }

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser account = result.user;
      return _AccountFromFireBaseUser(account);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in with email + password
  Future signInWEmailandPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser account = result.user;
      return _AccountFromFireBaseUser(account);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email + password
  Future registerWEmailandPassword(String email,String password, String nickname ) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser account = result.user;

      //create database for new user
      await DatabaseService(uid: account.uid).newUserData(nickname, 0);

      return _AccountFromFireBaseUser(account);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}