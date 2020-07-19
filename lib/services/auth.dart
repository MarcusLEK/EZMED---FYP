import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmed/models/user.dart';
import 'package:ezmed/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  // starting with "_" means private, only usable in this file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user)); -> same as below
      .map(_userFromFirebaseUser);
  }

  // Sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // check user type here then pass data into _userFromFirebase
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register patient with email & password
  Future registerPatient(String queue, String email, String password, String name, String ic, String contact) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      String docID = user.uid;

      // // create a new doc for user with uid
      await DatabaseService(uid: user.uid).updatePatientData(docID, queue, name, ic, contact);
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  // register staff
  Future registerStaff(String email, String password, String name, String contact) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateStaffData(name, contact);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  } 

  // register doctor
  Future registerDoctor(String email, String password, String name, String contact) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateDoctorData(name, contact);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // send password reset link
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true; 
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

}