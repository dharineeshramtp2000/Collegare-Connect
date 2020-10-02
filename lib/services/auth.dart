//
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//
//
//class AuthService {
//  final FirebaseAuth _auth = FirebaseAuth.instance;
//
//  // ignore: deprecated_member_use
//  User _userFromFirebaseUser(FirebaseUser user) {
//    return user != null ? User(uid: user.uid) : null;
//  }
//
//  Future signInWithEmailAndPassword(String email, String password) async {
//    try {
//      AuthResult result = await _auth.signInWithEmailAndPassword(
//          email: email, password: password);
//      FirebaseUser user = result.user;
//      return _userFromFirebaseUser(user);
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }
//
//  Future signUpWithEmailAndPassword(String email, String password) async {
//    try {
//      AuthResult result = await _auth.createUserWithEmailAndPassword(
//          email: email, password: password);
//      FirebaseUser user = result.user;
//      return _userFromFirebaseUser(user);
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }
//
//  Future resetPass(String email) async {
//    try {
//      return await _auth.sendPasswordResetEmail(email: email);
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }
//
//
//  Future signOut() async {
//    try {
//      return await _auth.signOut();
//    } catch (e) {
//      print(e.toString());
//      return null;
//    }
//  }
//}
