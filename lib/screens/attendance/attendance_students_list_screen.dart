import 'package:campus/screens/attendance/attendanceListCard.dart';
import 'package:campus/screens/attendance/attendanceVar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceScreen extends StatefulWidget {
  final className;
  final classId;
  final List members;
  const AttendanceScreen(
      {super.key,
      required this.className,
      required this.classId,
      required this.members});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int abs = 0;
  bool istapped = false;
  var userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.members);
  }

  getdata(index) async {
    userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.members[index])
        .get();

    print(widget.members[index]);
    print(userData.data()!['name']);
    print(userData.data()!['Roll Number']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.className,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.members.length,
              itemBuilder: (context, index) {
                getdata(index);

                return AttendaceListCard(
                  memberuid: widget.members[index],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0)
                          .copyWith(right: 60, left: 60),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //present count
                            Row(
                              children: [
                                Text(
                                  "Present  ",
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                Text(
                                  "60",
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            // absent count
                            Row(
                              children: [
                                Text(
                                  "Absent  ",
                                  style: TextStyle(color: Colors.grey.shade800),
                                ),
                                Text(
                                  absentCount.toString(),
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        width: 160,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
