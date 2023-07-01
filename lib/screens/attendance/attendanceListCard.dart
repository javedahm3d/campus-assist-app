import 'package:campus/screens/attendance/attendanceVar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendaceListCard extends StatefulWidget {
  final name;
  final uid;
  final Roll;
  const AttendaceListCard(
      {super.key, required this.name, required this.Roll, required this.uid});

  @override
  State<AttendaceListCard> createState() => _AttendaceListCardState();
}

class _AttendaceListCardState extends State<AttendaceListCard> {
  var userData;
  bool istapped = false;
  bool ispresentcounterInitiated = false;

  @override
  void initState() {
    // print(widget.snap['name']);
    // print(widget.name);
    // TODO: implement initState
    super.initState();
    // presentList.add(widget.uid);
    print('my list');
    print(presentList);

    // getdata();
  }

  // getdata()  {

  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: InkWell(
        onTap: () {
          setState(() {
            istapped = !istapped;
            if (istapped) {
              ispresentcounterInitiated = true;
              absentList.add(widget.uid);
              print(absentList);
              presentList.remove(widget.uid);
              print(presentList);
              // context.read<MyIntProvider>().absentmarked();
              // absentCount += 1;
              // PresentCount -= 1;
              // print(absentCount);
            } else {
              if (ispresentcounterInitiated) {
                presentList.add(widget.uid);
                absentList.remove(widget.uid);
                // context.read<MyIntProvider>().presentmarked();
              }
            }
          });
        },
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: istapped ? Colors.white : Color.fromARGB(255, 41, 255, 48),
              border: Border.all(
                  color: istapped
                      ? Colors.grey.shade700
                      : Color.fromARGB(255, 235, 255, 236))),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      // widget.snap['name'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      widget.Roll,
                      // widget.snap['name'],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
