
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallet/model/kid.dart';
import 'dart:async';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  /// Query a subcollection
  Stream<List<Kid>> streamKids(FirebaseUser user) {
    var ref = _db.collection('Kids').document(user.uid).collection('kids');

    return ref.snapshots().map((list) =>
        list.documents.map((doc) => Kid.fromFirestore(doc)).toList());
  }

  Future<void> createKid(FirebaseUser user, String name, String birthday, String image, String gender) {
    return _db
        .collection('Kids')
        .document(user.uid)
        .collection('kids')
        .document()
        .setData({
          'name': name,
          'image': image,
          'userUID': user.uid,
          'gender': gender,
          'birthday': birthday
        });
  }

  Future<void> removeWeapon(FirebaseUser user, String id) {
    return _db
        .collection('heroes')
        .document(user.uid)
        .collection('weapons')
        .document(id)
        .delete();
  }
}