import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../profile/upload_method.dart';

class CaptionScreen extends StatefulWidget {
  Uint8List? image;
  CaptionScreen({super.key, required this.image});

  @override
  State<CaptionScreen> createState() => _CaptionScreenState();
}

class _CaptionScreenState extends State<CaptionScreen> {
  final TextEditingController discriptionController = TextEditingController();
  bool isLoading = false;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String username = '';
  String userPhoto = '';
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
      userPhoto = userSnap.data()!['profile image'];
    });
  }

  @override
  void dispose() {
    super.dispose();
    discriptionController.dispose();
  }

  //post image function
  void postImage() async {
    setState(() {
      isLoading = true;
    });
    String id = const Uuid().v1();
    try {
      String photoURL = await StorageMethod()
          .uploadImageToStorage('events/$id', widget.image!);

      FirebaseFirestore.instance.collection('event posts').doc(id).set({
        'post id': id,
        'username': username,
        'userphoto': userPhoto,
        'postURL': photoURL,
        'caption': discriptionController.text,
        'publish time': DateTime.now(),
        'likes': [],
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void clearImage() {
    discriptionController.clear();
    setState(() {
      widget.image = null;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          leading: IconButton(
              onPressed: () => clearImage(),
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'posting to Events',
            style: GoogleFonts.aBeeZee(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              isLoading
                  ? const LinearProgressIndicator()
                  : const Padding(padding: EdgeInsets.only(top: 0)),
              const Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //image display
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(350, 350)),
                    child: AspectRatio(
                      aspectRatio: 457 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: MemoryImage(widget.image!),
                          fit: BoxFit.scaleDown,
                          alignment: FractionalOffset.topCenter,
                        )),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),
                  //caption for the post
                  Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 300),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(CupertinoIcons.text_append),
                            labelText: 'enter caption here',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          controller: discriptionController,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  InkWell(
                    onTap: () => postImage(),
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          'Post',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
