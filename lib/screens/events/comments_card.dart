import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';

class CommentsCard extends StatefulWidget {
  final snap;
  const CommentsCard({super.key, required this.snap});

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  bool showDeleteIcon = false;

  Future<void> likeComment(
      String postId, String commentId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await firebaseFirestore
            .collection('event posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await firebaseFirestore
            .collection('event posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () async {
        await likeComment(widget.snap['postId'], widget.snap['commentId'], uid,
            widget.snap['likes']);
      },
      onTap: () {
        setState(() {
          showDeleteIcon = false;
        });
      },
      onLongPress: () {
        if (widget.snap["uid"] == uid) {
          setState(() {
            showDeleteIcon = true;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        color: showDeleteIcon ? Colors.lightBlue.shade100 : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.snap['profileImage']),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.snap['username'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        DateFormat.yMMMd().format(widget.snap['date'].toDate()),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpandableText(
                    widget.snap['comment'],
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 3,
                    linkColor: Colors.blue,
                  ),
                ),
              ],
            )),
            Row(
              children: [
                Container(
                  child: showDeleteIcon
                      ? IconButton(
                          onPressed: () async {
                            print('delete tapped');
                            await FirebaseFirestore.instance
                                .collection('event posts')
                                .doc(widget.snap['postId'])
                                .collection('comments')
                                .doc(widget.snap['commentId'])
                                .delete();
                          },
                          icon: Icon(Icons.delete))
                      : Stack(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await likeComment(
                                    widget.snap['postId'],
                                    widget.snap['commentId'],
                                    uid,
                                    widget.snap['likes']);
                              },
                              icon: widget.snap['likes'].contains(uid)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 20,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      size: 20,
                                    ),
                              alignment: Alignment.topRight,
                            ),
                            Positioned(
                              bottom: 6,
                              left: 26,
                              child: Text(
                                "${widget.snap['likes'].length}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
