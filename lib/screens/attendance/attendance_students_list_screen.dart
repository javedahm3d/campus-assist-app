import 'package:campus/screens/attendance/attendanceListCard.dart';
import 'package:campus/screens/attendance/attendanceVar.dart';
import 'package:campus/screens/attendance/view_attendace.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
  int absentcount = 0;
  int presentcount = 0;
  bool istapped = false;
  var userData;
  // Future future = FirebaseFirestore.instance.collection('users').doc(uid).get();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // MyIntProvider present = Provider.of<MyIntProvider>(context, listen: false);
    // present.present = widget.members.length;
    setState(() {
      presentList = List.from(widget.members);
      absentList = [];
      // absentcount = absentList.length;
      // presentcount = presentList.length;
    });

    print(widget.members);
  }

  @override
  Widget build(BuildContext context) {
    // Access the int variable

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.className,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            child: Icon(Icons.more_vert),
            itemBuilder: (context) =>
                [PopupMenuItem(value: 1, child: Text('View attendance'))],
            onSelected: (value) {
              if (value == 1) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewAttendanceScreen(
                          classId: widget.classId,
                          className: widget.className,
                        )));
              }
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: widget.members.length,
            itemBuilder: (context, index) {
              String uid = widget.members[index];
              // print(widget.members[index]);

              print(uid);
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
                    // Access the data using snapshot.data
                    // For example, assuming each document has a 'name' field
                    String userName = snapshot.data!.get('name');
                    String rollnumber = snapshot.data!.get('Roll Number');
                    // if (!presentROLLList.contains(rollnumber)) {
                    //   presentROLLList.add(rollnumber);
                    // }

                    // return ListTile(
                    //   title: Text(userName),
                    // );
                    return AttendaceListCard(
                      name: userName,
                      uid: uid,
                      Roll: rollnumber,
                    );
                  }

                  return ListTile(
                    title: Text('Loading...'),
                  );
                },
              );
            },
          )),

          // for (int i = 0; i < widget.members.length; i++) ...[
          //   getdata(i),
          //   AttendaceListCard(
          //     name: userData.data()!['name'],
          //     Roll: userData.data()!['Roll Number'],
          //   )
          // ],
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
                                  '--',
                                  // '0',
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
                                  '--',
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
                      onTap: () async {
                        print('after submit');
                        // print(presentROLLList);
                        // print(presentList);
                        // print(absentList);

                        await FirebaseFirestore.instance
                            .collection('classes')
                            .doc(widget.classId)
                            .collection('attendance')
                            .doc(DateTime.now().toString().substring(0, 16))
                            .set({
                          'present list': presentList,
                          'absent list': absentList,
                          'time': DateTime.now().toString().substring(0, 16)
                        });

                        absentList = [];
                        presentList = [];
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewAttendanceScreen(
                              classId: widget.classId,
                              className: widget.className),
                        ));
                        // Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'attendance captured',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            });
                      },
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
