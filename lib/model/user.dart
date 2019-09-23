import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User(
      {this.name,
      this.id,
      this.photoUrl,
      this.email,
      this.isPaid,
      this.phoneNum
      });

  final String email;
  final String id;
  final String photoUrl;
  final String name;
  final String phoneNum;
  final bool isPaid;


  factory User.fromDocument(DocumentSnapshot document) {
    return new User(
      email: document['email'],
      name: document['name'],
      photoUrl: document['photoUrl'],
      isPaid: document['isComplete'],
      phoneNum: document['phoneNum'],
      id: document.documentID,
    );
  }
}