import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project/models/myuser.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object from firebase user

  MyUser? _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid):null;
  }

  // Auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
      .map((User? user) => _userFromFirebaseUser(user!));
  }

  // Sign In Anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in With Email


  // Register with Email


  // Sign Out

  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}