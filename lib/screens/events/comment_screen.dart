import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),

      //body
      body: StreamBuilder(
        builder: (context, snapshot) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text('username',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'my comment',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),

      //post comments
      bottomSheet: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
            .copyWith(bottom: 30),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(''),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextField(
                  // controller: commentController,
                  decoration: InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    // borderSide: BorderSide(
                    // width: 1, color: Colors.grey
                    // )
                    // ),
                    hintText: 'comment as usernamr',
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  print('post pressed');
                },
                icon: Icon(CupertinoIcons.paperplane))
          ],
        ),
      )),
    );
  }
}
