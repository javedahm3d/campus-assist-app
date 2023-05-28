import 'package:campus/screens/attendance/attendance_screen.dart';
import 'package:campus/screens/attendance/attendance_students_list_screen.dart';
import 'package:campus/screens/classroom/class_post_card.dart';
import 'package:campus/screens/classroom/upload_post_screen.dart';
import 'package:campus/screens/classroom/view_class_code.dart';
import 'package:campus/widgets/navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                    child: widget.isOwner ? Text('edit class') : null),
                PopupMenuItem(value: 2, child: Text('view class code')),
              ],
              onSelected: (value) {
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
