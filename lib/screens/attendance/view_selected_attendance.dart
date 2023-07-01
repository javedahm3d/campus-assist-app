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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.className} - ( ${widget.snap['time']} )",
          softWrap: true,
        ),
      ),
    );
  }
}
