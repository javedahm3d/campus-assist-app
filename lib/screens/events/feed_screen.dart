import 'package:campus/screens/classroom/class_post_card.dart';
import 'package:campus/screens/events/post_card.dart';
import 'package:campus/widgets/my_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  void signUserOut() async {
    // final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Events',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.add_circled,
                size: 30,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('classes').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                // itemCount: snapshot.data!.docs.length,
                itemCount: 5,
                itemBuilder: (context, index) => PostCard());
          }),
    );
  }
}
