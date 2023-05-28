import 'package:campus/cards/classroom_card.dart';
import 'package:campus/screens/classroom/create_class.dart';
import 'package:campus/screens/classroom/join_class_screen.dart';
import 'package:campus/widgets/my_appbar.dart';
import 'package:campus/widgets/navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClassListPage extends StatefulWidget {
  ClassListPage({super.key});

  @override
  State<ClassListPage> createState() => _ClassListPageState();
}

class _ClassListPageState extends State<ClassListPage> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isOwner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),

      // actions: [
      //     IconButton(
      //       onPressed: signUserOut,
      //       icon: const Icon(Icons.logout),
      //     )

      //body
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
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  //checking if its owner
                  var data = snapshot.data!.docs[index].data();
                  print(data['owner uid']);
                  // print(user.uid);
                  if (data['owner uid'] == user.uid) {
                    isOwner = true;
                  } else {
                    isOwner = false;
                  }

                  return ClassroomCard(
                    snap: snapshot.data!.docs[index].data(),
                    isOwner: isOwner,
                  );
                });
          }),

      //drawer
      drawer: MyNavigationDrawer(),

      //floating
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: SizedBox(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                    .copyWith(topRight: Radius.circular(20)),
              ),
              context: context,
              builder: (context) {
                return Container(
                  height: 100,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10).copyWith(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CreateClassScreen()));
                          },
                          child: Text(
                            'create class',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade800),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => JoinClassScreen()));
                          },
                          child: Text(
                            'join class',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade800),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
