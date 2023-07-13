import 'package:campus/screens/classroom/class_comment_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../events/comments_card.dart';

class ClassCommentScreen extends StatefulWidget {
  final snap;
  const ClassCommentScreen({super.key, required this.snap});

  @override
  State<ClassCommentScreen> createState() => _ClassCommentScreenState();
}

class _ClassCommentScreenState extends State<ClassCommentScreen> {
  final TextEditingController commentController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String username = '';
  String userphoto = '';
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  var userSnap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    userSnap = await _firebaseFirestore.collection('users').doc(uid).get();

    setState(() {
      username = userSnap.data()!['name'];
      userphoto = userSnap.data()!['profile image'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  Future<String> postComment(String classId, String postId, String comment,
      String uid, String username, String profileImage) async {
    String res = 'some error occured';
    try {
      if (comment.isNotEmpty) {
        String commentId = const Uuid().v1();
        await firebaseFirestore
            .collection('classes')
            .doc(classId)
            .collection('class posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'classId': classId,
          'postId': postId,
          'commentId': commentId,
          'profileImage': profileImage,
          'username': username,
          'uid': uid,
          'date': DateTime.now(),
          'comment': comment,
          'likes': [],
        });
        res = 'posted!';
      } else {
        res = "please enter your comment";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('classes')
            .doc(widget.snap['class Id'])
            .collection('class posts')
            .doc(widget.snap['post Id'])
            .collection('comments')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => ClassCommentCard(
                    snap: snapshot.data!.docs[index].data(),
                  ));
        },
      ),
      bottomSheet: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
            .copyWith(bottom: 30),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(userphoto),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    // borderSide: BorderSide(
                    // width: 1, color: Colors.grey
                    // )
                    // ),
                    hintText: 'comment as $username',
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  print('pressed');
                  await postComment(
                      widget.snap['class Id'],
                      widget.snap['post Id'],
                      commentController.text,
                      uid,
                      username,
                      userphoto);

                  setState(() {
                    commentController.text = '';
                  });
                },
                icon: Icon(CupertinoIcons.paperplane))
          ],
        ),
      )),
    );
  }
}
