import 'dart:typed_data';

import 'package:campus/screens/profile/image_pick.dart';
import 'package:campus/screens/profile/my_profile_textfields.dart';
import 'package:campus/screens/profile/upload_method.dart';
import 'package:campus/services/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../widgets/my_appbar.dart';
import '../../widgets/navigation_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isenable = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController RollNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController DepartmentController = TextEditingController();
  TextEditingController semController = TextEditingController();
  var snap;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool isLoading = false;
  Uint8List? _image;
  String photourl = '';

  @override
  void initState() {
    getdata();

    // TODO: implement initState
    super.initState();
  }

  getdata() async {
    snap = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    setState(() {
      nameController.text = snap.data()!['name'];
      RollNumberController.text = snap.data()!['Roll Number'];
      emailController.text = snap.data()!['email'];
      DepartmentController.text = snap.data()!['department'];
      semController.text = snap.data()!['sem'];
      photourl = snap.data()!['profile image'];
    });

    // print(snap.data()!['name']);
  }

  editImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });

    String photoURL =
        await StorageMethod().uploadImageToStorage('ProfilePics', _image!);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'profile image': photoURL});

    setState(() {
      photourl = snap.data()!['profile image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: MyNavigationDrawer(),
      body: photourl == ''
          ? Center(
              child: CircularPercentIndicator(radius: 30),
            )
          : SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        //profile image
                        Stack(children: [
                          CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(photourl)),
                          Positioned(
                            child: InkWell(
                              onTap: () {
                                // ImagePicker imagePicker = ImagePicker();
                                // imagePicker.pickImage(source: ImageSource.gallery);
                                editImage();
                              },
                              child: Icon(
                                Icons.add_circle,
                                color: Colors.grey.shade400,
                                size: 30,
                              ),
                            ),
                            top: 70,
                            left: 60,
                          )
                        ]),

                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            'Student at: \nGoa Engineering College',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //user detailes
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       labelText: 'name',
                  //     ),
                  //   ),
                  // ),
                  MyProfileTextField(
                    controller: nameController,
                    labelText: 'name',
                    isenanle: isenable,
                  ),
                  MyProfileTextField(
                    controller: RollNumberController,
                    labelText: 'Roll Number',
                    isenanle: isenable,
                  ),
                  MyProfileTextField(
                    controller: emailController,
                    labelText: 'email',
                    isenanle: isenable,
                  ),
                  MyProfileTextField(
                    controller: DepartmentController,
                    labelText: 'Department',
                    isenanle: isenable,
                  ),
                  MyProfileTextField(
                    controller: semController,
                    labelText: 'semester',
                    isenanle: isenable,
                  ),

                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            isenable = !isenable;
                            if (!isenable) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });

                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .update({
                                "name": nameController.text,
                                "email": emailController.text,
                                "Roll Number": RollNumberController.text,
                                "department": DepartmentController.text,
                                'sem': semController.text,
                              });

                              Navigator.pop(context);
                            }
                          });
                        },
                        child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: isenable
                                ? Center(
                                    child: Text(
                                    'save changes',
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))
                                : Center(
                                    child: Text('edit profile',
                                        style: GoogleFonts.aBeeZee(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold))))),
                  ),

                  Center(
                    child: isenable
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                isenable = !isenable;
                              });
                              initState();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          )
                        : null,
                  )
                ],
              )),
            ),
    );
  }
}
