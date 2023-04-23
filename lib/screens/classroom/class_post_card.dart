import 'package:campus/screens/classroom/post_screen.dart';
import 'package:campus/screens/events/comment_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassPostCard extends StatefulWidget {
  final snap;
  const ClassPostCard({super.key, required this.snap});

  @override
  State<ClassPostCard> createState() => _ClassPostCardState();
}

class _ClassPostCardState extends State<ClassPostCard> {
  var attachments;

  @override
  void initState() {
    super.initState();
    setState(() {
      attachments = widget.snap['attachments'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
      child: Card(
        elevation: 2,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // border: Border.all(color: Colors.grey.shade700)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      radius: 22,
                    ),
                  ),
                  DefaultTextStyle(
                    style: GoogleFonts.roboto(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['creator'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat.MMMd()
                              .format(widget.snap['published time'].toDate()),
                          style: TextStyle(color: Colors.grey.shade800),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  PopupMenuButton(
                      child: Icon(Icons.more_vert),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) => [
                            PopupMenuItem(onTap: () {}, child: Text('edit ')),
                            PopupMenuItem(
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('classes')
                                      .doc(widget.snap['class Id'])
                                      .collection('class posts')
                                      .doc(widget.snap['post Id'])
                                      .delete();

                                  await FirebaseStorage.instance
                                      .ref()
                                      .child(
                                          'class posts/${widget.snap['class Id']}/${widget.snap['post Id']}')
                                      .delete();
                                },
                                child: const Text('delete ')),
                          ])
                ],
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PostScreen(
                    snap: widget.snap,
                    attachments: attachments,
                  ),
                )),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DefaultTextStyle(
                    style: GoogleFonts.aBeeZee(color: Colors.black),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap['title'],
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.snap['body'],
                          maxLines: 7,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.paperclip,
                              size: 20,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              '  ' +
                                  attachments!.length.toString() +
                                  '  attachments',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey.shade700),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentScreen(),
                )),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    'add class comment',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
