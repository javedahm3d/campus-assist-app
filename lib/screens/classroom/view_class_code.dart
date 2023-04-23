import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewClassCode extends StatefulWidget {
  final snap;
  const ViewClassCode({super.key, required this.snap});

  @override
  State<ViewClassCode> createState() => _ViewClassCodeState();
}

class _ViewClassCodeState extends State<ViewClassCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.snap['class id']),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                final data = ClipboardData(text: widget.snap['class id']);
                Clipboard.setData(data);
              },
              child: Text(
                'copy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ))
        ],
      )),
    );
  }
}
