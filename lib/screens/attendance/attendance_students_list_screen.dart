import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceScreen extends StatefulWidget {
  final className;
  final classId;
  const AttendanceScreen(
      {super.key, required this.className, required this.classId});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(3),
            child: Container(
              width: double.infinity,
              height: 140,
              color: Colors.orangeAccent,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // avatar
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CircleAvatar(
                          radius: 30,
                        ),
                      ),

                      //name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12)
                                .copyWith(bottom: 5),
                            child: Text(
                              'javed ahmed',
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            '191104032',
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              //present buttton
                              InkWell(
                                child: Container(
                                  width: 140,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: Center(
                                      child: Text(
                                    'Present',
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white, fontSize: 18),
                                  )),
                                ),
                              ),
                              SizedBox(width: 18),

                              //absent button
                              InkWell(
                                child: Container(
                                  width: 140,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 201, 13, 0),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: Center(
                                      child: Text(
                                    'Absent',
                                    style: GoogleFonts.aBeeZee(
                                        color: Colors.white, fontSize: 18),
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
