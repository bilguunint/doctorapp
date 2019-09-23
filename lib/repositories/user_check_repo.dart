import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }
enum UserStatus { Completed, UnCompleted, Uninitialized}
enum KidsStatus { Completed, UnCompleted, Uninitialized}

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;
  KidsStatus _kidsStatus = KidsStatus.Uninitialized;
  UserStatus _userStatus = UserStatus.Uninitialized;
  String _message = 'Мессеж хүлээж байна...';
  String _code = "";

  UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  KidsStatus get kidsStatus => _kidsStatus;
  UserStatus get userStatus => _userStatus;
  FirebaseUser get user => _user;
  String get message => _message;
  String get code => _code;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future setMessage() async{
    _message = 'Мессеж хүлээж байна...';
    print(message);
  }

  registerUser(String name, String birthday, String uid, String phoneNum) {
    Firestore.instance.collection('Users').document(uid)
  .setData({ 'name': name, 'birthday': birthday, 'phoneNum': phoneNum });
  }

  Future userCheck(String userId) async {
    await Firestore.instance.collection("Users").document(userId).get().then((datasnapshot) {
      if(datasnapshot.exists) {
      _userStatus = UserStatus.Completed;
      notifyListeners();
      } else {
      _userStatus = UserStatus.UnCompleted;
      notifyListeners();
      }
    });
  }

  Future kidsCheck(String userId) async {
    await Firestore.instance.collection("Kids").document(userId).get().then((datasnapshot) {
      if(datasnapshot.exists) {
      _kidsStatus = KidsStatus.Completed;
      notifyListeners();
      } else {
      _kidsStatus = KidsStatus.UnCompleted;
      notifyListeners();
      }
    });
  }

  Future verifyPhoneNumber(String verifyId, String phoneNum) async {
   
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) async {
      _message = "Amjilttai";
      notifyListeners();
      _auth.signInWithCredential(phoneAuthCredential);
      
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) async{
    _message = "Amjiltgui";
    notifyListeners();
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      verifyId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      verifyId = verificationId;
    };
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNum,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<bool> signInWithPhone( String verifyId, String smsCode ) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verifyId,
      smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }


  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }

  }

  Future signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    _message = 'Мессеж хүлээж байна...';
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}