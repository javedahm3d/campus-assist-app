import 'dart:ffi';

import 'package:campus/screens/campus_annoucements/annoucement_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: Colors.orangeAccent.shade100,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Campus Annoucements',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Campus announcements')
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        AnnoucemntBody(snap: snapshot.data!.docs[index].data()),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1, vertical: 2.5),
                    child: Card(
                      color: Colors.lightBlue.shade100,
                      child: SizedBox(
                        width: double.infinity,
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(15)
                              .copyWith(bottom: 5, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.docs[index].data()['title'],
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                softWrap: true,
                              ),
                              Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  snapshot.data!.docs[index]
                                      .data()['published time']
                                      .toString()
                                      .substring(0, 10)
                                      .replaceAll('-', '/'),
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
