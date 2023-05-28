import 'package:campus/screens/attendance/attendance_screen.dart';
import 'package:campus/screens/attendance/attendance_students_list_screen.dart';
import 'package:campus/screens/classroom/class_list_page.dart';
import 'package:campus/screens/classroom/class_post_card.dart';
import 'package:campus/screens/classroom/upload_post_screen.dart';
import 'package:campus/screens/classroom/view_class_code.dart';
import 'package:campus/screens/homePage.dart';
import 'package:campus/widgets/navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  final snap;
  final bool isOwner;
  const ClassScreen({super.key, this.snap, required this.isOwner});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            widget.snap['class'],
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            PopupMenuButton(
              child: Icon(Icons.more_vert),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: 1,
                    child: widget.isOwner
                        ? Text('edit class')
                        : Text('leave class')),
                PopupMenuItem(value: 2, child: Text('view class code')),
              ],
              onSelected: (value) {
                if (value == 1) {
                  print("1 pressed");
                  // Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Leaving Class'),
                        content: Text("Are You Sure Want To Proceed ?"),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "YES",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                onTap: () async {
                                  //Put your code here which you want to execute on Yes button click.
                                  await FirebaseFirestore.instance
                                      .collection('classes')
                                      .doc(widget.snap['class id'])
                                      .update({
                                    'members': FieldValue.arrayRemove(
                                        // [userData.data()!['Roll Number'].toString()]
                                        [
                                          FirebaseAuth.instance.currentUser!.uid
                                        ])
                                  });
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             ClassListPage()),
                                  //     (route) => false);

                                  Navigator.popUntil(context,
                                      (Route<dynamic> route) => route.isFirst);
                                },
                              ),
                              InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "NO",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                onTap: () {
                                  //Put your code here which you want to execute on No button click.
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                }
                if (value == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewClassCode(snap: widget.snap),
                      ));
                }
              },
            )
          ],
        ),
        body: Center(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('classes')
              .doc(widget.snap['class id'])
              .collection('class posts')
              .orderBy('published time', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            print(snapshot);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ClassPostCard(
                  snap: snapshot.data!.docs[index].data(),
                );
              },
            );
          },
        )),
        drawer: const MyNavigationDrawer(),

        //floating button
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: SizedBox(
            height: 40,
            width: 40,
            child: widget.isOwner
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: (() {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))
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
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => UploadPostScreen(
                                            classId: widget.snap['class id']
                                                .toString(),
                                            classname: widget.snap['class']
                                                .toString()),
                                      ));
                                    },
                                    child: Text(
                                      'upload post',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade800),
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
                                            builder: (context) =>
                                                AttendanceScreen(
                                              className: widget.snap['class'],
                                              classId: widget.snap['class id'],
                                              members: widget.snap['members'],
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      'take attendance',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  )
                : null));
  }
}
