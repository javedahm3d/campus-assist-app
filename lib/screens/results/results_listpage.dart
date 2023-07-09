import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class ResultsListPage extends StatefulWidget {
  final sem;
  final dept;
  const ResultsListPage({super.key, required this.sem, required this.dept});

  @override
  State<ResultsListPage> createState() => _ResultsListPageState();
}

class _ResultsListPageState extends State<ResultsListPage> {
  get downloadProgressIndicator => null;

  downloadFile(String url, String fileName) async {
    print('inside download function');
    print(fileName);
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/$fileName';
    print('mobile path    :' + path);

    bool fileExist = await File(path).exists();

    if (fileExist) {
      OpenFile.open(path);
    } else {
      await Dio().download(
        url,
        path,
        deleteOnError: true,
      );

      OpenFile.open(path);

      if (url.contains('.mp4')) {
        await GallerySaver.saveVideo(path, toDcim: true);
      }
      if (url.contains('.jpg')) {
        await GallerySaver.saveImage(path, toDcim: true);
      } else {
        // await fi
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Downloaded $fileName')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text('${widget.dept} (${widget.sem})')),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/doodle_bg.png'),
                  fit: BoxFit.cover)),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('results')
                .doc(widget.sem)
                .collection(widget.dept)
                .orderBy('RC', descending: true)
                .snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                // shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    child: InkWell(
                      onTap: () {
                        // print(snapshot.data!.docs[index].data()['FileURL']);
                        Reference ref = FirebaseStorage.instance
                            .ref('results/${widget.sem}/${widget.dept}');
                        downloadFile(
                            snapshot.data!.docs[index].data()['FileURL'],
                            "${snapshot.data!.docs[index].data()['RC']}-${widget.dept}-${widget.sem}.pdf");
                      },
                      child: Card(
                        color: Colors.lightBlue.shade200,
                        child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(
                                child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  snapshot.data!.docs[index]
                                      .data()['RC']
                                      .toString(),
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                              ),
                            ))),
                      ),
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
