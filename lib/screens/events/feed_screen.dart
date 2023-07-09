import 'dart:typed_data';

import 'package:campus/screens/classroom/class_post_card.dart';
import 'package:campus/screens/events/caption_screen.dart';
import 'package:campus/screens/events/post_card.dart';
import 'package:campus/widgets/my_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../profile/image_pick.dart';
// import 'package:image_picker/image_picker.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Uint8List? _image;
  final TextEditingController discriptionController = TextEditingController();
  bool isLoading = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    super.dispose();
    discriptionController.dispose();
  }

//showing galley or camera option using dialog box
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("create a post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _image = file;
                  });
                },
                child: const Text(
                  "take photo",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _image = file;
                  });
                  routetoCaption();
                },
                child: const Text(
                  "select image from gallery",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              //cancel
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "cancel",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          );
        });
  }

  routetoCaption() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CaptionScreen(image: _image),
    ));
  }

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
          // add post
          IconButton(
              onPressed: () {
                _selectImage(context);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => CaptionScreen(image: _image!),
                // ));
              },
              icon: Icon(
                CupertinoIcons.add_circled,
                size: 30,
                color: Colors.white,
              ))
        ],
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('event posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                // itemCount: snapshot.data!.docs.length,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                      snap: snapshot.data!.docs[index].data(),
                      uid: uid,
                    ));
          }),
    );
  }
}
