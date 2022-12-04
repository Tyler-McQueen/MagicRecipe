import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project/models/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object from firebase user

  MyUser? _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // Sign In Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign in With Email
  Future signinEmailAccount(emailAddress, password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      User? user = credential.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Register with Email
  Future registerEmailAccount(emailAddress, password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      // Create a new user with a email
      final user = <String, dynamic>{
        "DateCreated": Timestamp.now(),
        "email": emailAddress,
        "PantryItem": [],
        "ShoppingItems": [],
        "Recipes": [],
      };
      final userData = credential.user;
      print(userData?.uid);
      db.collection("users").doc(userData?.uid).set(user);
      //print('DocumentSnapshot added with ID: ${doc.id}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
