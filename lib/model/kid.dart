import 'package:cloud_firestore/cloud_firestore.dart';

class Kid {
  final String id;
  final String name;
  final String image;
  final String birthday;
  final String gender;

  Kid({ this.id, this.name, this.image, this.birthday, this.gender });

  factory Kid.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;
    
    return Kid(
      id: doc.documentID,
      name: data['name'] ?? '',
      image: data['image'] ?? '',
      birthday: data['birthday'] ?? '',
      gender: data['gender'] ?? ''
    );
  }

}