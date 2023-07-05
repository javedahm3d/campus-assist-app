import 'package:campus/screens/attendance/attendanceListCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SpecificAttendance extends StatefulWidget {
  final snap;
  final className;
  final classId;
  const SpecificAttendance({
    super.key,
    required this.snap,
    required this.classId,
    required this.className,
  });

  @override
  State<SpecificAttendance> createState() => _SpecificAttendanceState();
}

class _SpecificAttendanceState extends State<SpecificAttendance> {
  var listsnap;
  // var usersnap;

  List present = [];
  List absent = [];
  List combined = [];
  // List presentROLL = [];
  // List absentROLL = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  getdata() async {
    listsnap = await FirebaseFirestore.instance
        .collection('classes')
        .doc(widget.classId)
        .collection('attendance')
        .doc(widget.snap['time'])
        .get();

    setState(() {
      present = listsnap.data()!['present list'];
      absent = listsnap.data()!['absent list'];
      combined = present + absent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "${widget.className} - ( ${widget.snap['time']} )",
          softWrap: true,
        ),
      ),
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: ListView.builder(
                itemCount: combined.length,
                itemBuilder: (context, index) {
                  String uid = combined[index];
                  // print(widget.members[index]);

                  print('present lenght : ${present.length}');
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return ListTile(
                          title: Text('Error: ${snapshot.error}'),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        String userName = snapshot.data!.get('name');
                        String rollnumber = snapshot.data!.get('Roll Number');

                        //present list card design

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index < present.length
                                    ? Color.fromARGB(255, 41, 255, 48)
                                    : Colors.red,
                                border: Border.all(
                                    color: Color.fromARGB(255, 235, 255, 236))),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  userName,
                                  // widget.snap['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Text(
                                  rollnumber,
                                  // widget.snap['name'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 25,
                                )
                              ],
                            ),
                          ),
                        );
                      }

                      return ListTile(
                        title: Text('Loading...'),
                      );
                    },
                  );
                },
              )),
        ],
      ),
    );
  }
}
