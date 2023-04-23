import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnoucemntBody extends StatefulWidget {
  const AnnoucemntBody({super.key});

  @override
  State<AnnoucemntBody> createState() => _AnnoucemntBodyState();
}

class _AnnoucemntBodyState extends State<AnnoucemntBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
              'Title',
              style: GoogleFonts.aBeeZee(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text('body')
          ],
        ),
      )),
    );
  }
}
