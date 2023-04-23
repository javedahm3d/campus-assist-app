import 'package:campus/screens/classroom/class_list_page.dart';
import 'package:campus/screens/homePage.dart';
import 'package:campus/screens/schedule_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyNavigationDrawer extends StatefulWidget {
  const MyNavigationDrawer({super.key});

  @override
  State<MyNavigationDrawer> createState() => _MyNavigationDrawerState();
}

class _MyNavigationDrawerState extends State<MyNavigationDrawer> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  //signuser out
  Future signUserOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }

  getData() async {
    var snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();

    name = snap.data()!['name'];
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [buildHeader(context), buildMenuItems(context)],
          )),
        ),
      );

  Widget buildHeader(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0)
              .copyWith(bottomRight: Radius.circular(50))),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(0)
                .copyWith(bottomRight: Radius.circular(50))),
        child: Column(
          children: [
            SizedBox(height: 30),
            //avatar
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjEkZGk1Cl3wt_AwYxUQnT_2YDUzEBvLQXFQ&usqp=CAU'),
              radius: 40,
            ),

            //emailid
            Text(
              _auth.currentUser!.email.toString(),
              style: TextStyle(color: Colors.white),
            ),

            SizedBox(height: 5),

            InkWell(
              child: Text('view profile',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onTap: () {},
            ),

            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

//drawer items
  Widget buildMenuItems(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //homepage
          ListTile(
            leading: const Icon(CupertinoIcons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),

          //classes
          ListTile(
            leading: const Icon(CupertinoIcons.home),
            title: const Text('classes'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ClassListPage()));
            },
          ),

          //schedule
          ListTile(
            leading: const Icon(CupertinoIcons.calendar),
            title: const Text('my schedule'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ScheduleScreen()));
            },
          ),

//signout option
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('signout'),
            onTap: () async {
              await signUserOut();
            },
          ),
        ],
      ),
    );
  }
}
