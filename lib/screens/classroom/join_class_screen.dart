import 'package:campus/components/my_textfield.dart';
import 'package:campus/screens/classroom/class_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoinClassScreen extends StatefulWidget {
  const JoinClassScreen({super.key});

  @override
  State<JoinClassScreen> createState() => _JoinClassScreenState();
}

class _JoinClassScreenState extends State<JoinClassScreen> {
  TextEditingController classCode = TextEditingController();
  bool isButtonActive = false;
  var userData;

  @override
  void initState() {
    super.initState();
    classCode.addListener(() {
      setState(() {
        isButtonActive = classCode.text.isNotEmpty;
      });
    });
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
    classCode.dispose();
  }

  getdata() async {
    userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    print(userData.data()!['Roll Number'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(children: [
            SizedBox(height: 200),
            Text(
              'Please enter class code :',
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            SizedBox(height: 30),
            MyTextField(
                controller: classCode, hintText: 'code', obscureText: false),
            SizedBox(height: 30),
            InkWell(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection('classes')
                    .doc(classCode.text.trim())
                    .update({
                  'members': FieldValue.arrayUnion(
                      // [userData.data()!['Roll Number'].toString()]
                      [FirebaseAuth.instance.currentUser!.uid])
                });

                DocumentSnapshot<Map<String, dynamic>> classSnap =
                    await FirebaseFirestore.instance
                        .collection('classes')
                        .doc(classCode.text.trim())
                        .get();

                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ClassScreen(
                    snap: classSnap,
                    isOwner: false,
                  ),
                ));
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    color: isButtonActive ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    'Join',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
