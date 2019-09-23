import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wallet/model/user.dart';

class UserRepo {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final userRef = Firestore.instance.collection('Users');

  UserRepo({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String firstName, String lastName, String phoneNum, String uid}) async {
    return await userRef.document(uid).setData(
      {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNum': phoneNum
      }
    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return (await _firebaseAuth.currentUser());
  }
  Future<User> getUserData(String uid) async {
  final DocumentSnapshot userRecord = await userRef.document(uid).get();
  return User.fromDocument(userRecord);
  }
  Future<String> getUserId() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
  Future<bool> isCompleted(String uid) async {
  final DocumentSnapshot userRecord = await userRef.document(uid).get();
  return userRecord.data.isNotEmpty;
  }
}