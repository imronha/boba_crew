import 'package:boba_crew/models/user.dart';
import 'package:boba_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
    // Following .map does the same thing as above line
    // .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // Sign in anonymously
  // This will be an asyc class that will return a Future, more info at this link ______________
  Future signInAnon() async {
    try {
      // This will not work unless anonymous sign-in is enabled in project authentication
      AuthResult result = await _auth.signInAnonymously();

      FirebaseUser user = result.user;

      // Return custom user object
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and pw
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      // Create new document for the new user with uid and set default new user data
      await DatabaseService(uid: user.uid)
          .updateUserData('New Crew Member', 100, 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut(); // This is a built in method
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
