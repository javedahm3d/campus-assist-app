import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileTextField extends StatelessWidget {
  final String labelText;
  final controller;
  final bool isenanle;
  const MyProfileTextField(
      {super.key,
      required this.controller,
      required this.isenanle,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextField(
        readOnly: !isenanle,
        controller: controller,
        style: isenanle
            ? GoogleFonts.aBeeZee(fontSize: 18)
            : GoogleFonts.aBeeZee(fontSize: 18, color: Colors.grey),
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
