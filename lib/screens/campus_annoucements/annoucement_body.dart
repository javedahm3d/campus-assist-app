import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnoucemntBody extends StatefulWidget {
  final snap;
  const AnnoucemntBody({super.key, required this.snap});

  @override
  State<AnnoucemntBody> createState() => _AnnoucemntBodyState();
}

class _AnnoucemntBodyState extends State<AnnoucemntBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Campus Annoucements',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              widget.snap['title'],
              style: GoogleFonts.aBeeZee(
                  fontSize: 21, fontWeight: FontWeight.bold),
            ),
            Text(
              'Date: ${widget.snap['published time'].toString().substring(0, 16).replaceAll('-', '/').replaceAll(' ', '  Time:')}',
              style: GoogleFonts.aBeeZee(
                  fontSize: 14, fontWeight: FontWeight.w300),
            ),
            Divider(),
            Text(
              widget.snap['body'],
              style:
                  GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.w400),
            )
          ],
        ),
      )),
    );
  }
}
