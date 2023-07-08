import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';

class PostScreen extends StatefulWidget {
  final snap;
  final attachments;
  const PostScreen({super.key, required this.snap, this.attachments});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late Future<ListResult> postFiles;
  Map<int, double> downloadProgressIndicator = {};
  // bool filealreadyexist = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      postFiles = FirebaseStorage.instance
          .ref(
              'class posts/${widget.snap['class Id']}/${widget.snap['post Id']}')
          .listAll();
    });
  }

  checkFileExists() {}

  downloadFile(Reference ref, int index) async {
    final url = await ref.getDownloadURL();
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/${ref.name}';
    print('mobile path    :' + path);
    print(url);

    bool fileExist = await File(path).exists();

    if (fileExist) {
      OpenFile.open(path);
    } else {
      await Dio().download(
        url,
        path,
        onReceiveProgress: (count, total) {
          double progress = count / total;
          setState(() {
            downloadProgressIndicator[index] = progress;
          });
        },
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
          .showSnackBar(SnackBar(content: Text('Downloaded ${ref.name}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            widget.snap['class'],
            style: TextStyle(color: Colors.black),
          )),
      body: Card(
        child: Container(
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 20, color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.snap['title']),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    widget.snap['body'],
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Divider(
                    thickness: 1,
                  ),

                  //attachments are shown here
                  FutureBuilder<ListResult>(
                    future: postFiles,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final files = snapshot.data!.items;

                        print(files);

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];
                            double? progress = downloadProgressIndicator[index];
                            return Padding(
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.grey.shade500),
                                  ),
                                  child: InkWell(
                                    onTap: () => downloadFile(file, index),
                                    child: ListTile(
                                        leading:
                                            Icon(Icons.attach_file_outlined),
                                        title: Text(
                                          file.name,
                                          style:
                                              GoogleFonts.roboto(fontSize: 15),
                                        ),
                                        // trailing: progress == 1.0
                                        //     ? IconButton(
                                        //         onPressed: () {},
                                        //         icon: Icon(Icons.file_open))
                                        //     : IconButton(
                                        //         splashColor:
                                        //             Colors.orangeAccent,
                                        //         onPressed: () =>
                                        //             downloadFile(file, index),
                                        //         icon: Icon(Icons.download)),
                                        subtitle: progress != null
                                            ? LinearProgressIndicator(
                                                value: progress,
                                                backgroundColor:
                                                    Colors.orangeAccent,
                                              )
                                            : null),
                                  ),
                                ));
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Text(
                            'some error occured while loading attachments');
                      } else {
                        return LinearProgressIndicator();
                      }
                    },
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: attachments.length,
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: const EdgeInsets.all(6.0),
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.02,
                  //         height: MediaQuery.of(context).size.height * 0.07,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             border: Border.all(color: Colors.grey.shade700)),
                  //       ),
                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
