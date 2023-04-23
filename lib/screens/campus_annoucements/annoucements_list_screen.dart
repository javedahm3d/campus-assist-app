import 'dart:ffi';

import 'package:campus/screens/campus_annoucements/annoucement_body.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnoucementScreen extends StatefulWidget {
  const AnnoucementScreen({super.key});

  @override
  State<AnnoucementScreen> createState() => _AnnoucementScreenState();
}

class _AnnoucementScreenState extends State<AnnoucementScreen> {
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AnnoucemntBody(),
            )),
            child: Card(
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Padding(
                  padding:
                      const EdgeInsets.all(15).copyWith(bottom: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'annoucement title',
                        style: GoogleFonts.roboto(fontSize: 17),
                        softWrap: true,
                      ),
                      Spacer(),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text('published date'))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
