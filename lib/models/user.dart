import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String rollNumber;
  final String uid;
  final String name;
  final String email;
  final String department;
  final String profile_image;
  final String sem;

  User({
    required this.rollNumber,
    required this.uid,
    required this.name,
    required this.email,
    required this.department,
    required this.profile_image,
    required this.sem,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      rollNumber: snapshot["Roll Number"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      profile_image: snapshot["profile image"],
      name: snapshot["name"],
      sem: snapshot["sem"],
      department: snapshot["department"],
    );
  }

  Map<String, dynamic> toJason() => {
        'email': email,
        'uid': uid,
        'name': name,
        'Roll Number': rollNumber,
        'department': department,
        'sem': sem,
        'profile_image': profile_image,
      };
}
