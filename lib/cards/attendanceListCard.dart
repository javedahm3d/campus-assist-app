import 'package:campus/screens/attendance/attendanceVar.dart';
import 'package:flutter/material.dart';

class AttendaceListCard extends StatefulWidget {
  const AttendaceListCard({super.key});

  @override
  State<AttendaceListCard> createState() => _AttendaceListCardState();
}

class _AttendaceListCardState extends State<AttendaceListCard> {
  bool istapped = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: InkWell(
        onTap: () {
          setState(() {
            istapped = !istapped;
            if (istapped) {
              absentCount += 1;
              PresentCount -= 1;
              print(absentCount);
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
                      'firts last',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '191104032',
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
