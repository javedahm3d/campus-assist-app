import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String fullName;
  final List followings;
  final String photoURL;

  User({
    required this.email,
    required this.uid,
    required this.fullName,
    required this.followings,
    required this.photoURL,
  });


static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoURL: snapshot["photoURL"],
      fullName: snapshot["fullName"],
      followings: snapshot["followings"],
    );
  }

  Map<String, dynamic> toJason() => {
        'email': email,
        'uid': uid,
        'fullName': fullName,
        'followings': followings,
        'photoURL': photoURL,
      };
}
