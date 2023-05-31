import 'package:campus/screens/events/comment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        width: double.infinity,
        // height: 400,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Row(children: [
                CircleAvatar(
                  radius: 27,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'username',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                PopupMenuButton(
                    child: Icon(Icons.more_vert),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    itemBuilder: (context) => [
                          PopupMenuItem(child: Text('edit class')),
                          PopupMenuItem(
                              onTap: () async {}, child: Text('delete class')),
                        ])
              ]),
            ),

            // post image
            Container(
              color: Colors.blue,
              height: 350,
              width: double.infinity,
            ),

            // GestureDetector(
            //   onDoubleTap: () async {
            //     // FireStoreMethods().likePost(
            //     //     widget.snap['postId'], user.uid, widget.snap['likes']);
            //     setState(() {
            //       isAnimating = true;
            //     });
            //   },
            //   child: ZoomOverlay(
            //     modalBarrierColor: Colors.black12, // optional
            //     minScale: 0.5, // optional
            //     maxScale: 3.0, // optional
            //     twoTouchOnly: true,
            //     animationDuration: const Duration(milliseconds: 300),
            //     animationCurve: Curves.fastOutSlowIn,
            //     child: Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.45,
            //           child: Image(
            //             image: NetworkImage(widget.snap['postURL']),
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //         AnimatedOpacity(
            //           duration: const Duration(milliseconds: 200),
            //           opacity: isAnimating ? 1 : 0,
            //           child: LikeAnimation(
            //             child: const Icon(
            //               Icons.favorite,
            //               color: Color.fromRGBO(255, 255, 255, 1),
            //               size: 130,
            //             ),
            //             isAnimating: isAnimating,
            //             duration: const Duration(
            //               milliseconds: 400,
            //             ),
            //             onEnd: () {
            //               setState(() {
            //                 isAnimating = false;
            //               });
            //             },
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            Row(
              children: [
                SizedBox(width: 5),
                Icon(
                  CupertinoIcons.heart,
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(),
                      )),
                  child: Icon(
                    CupertinoIcons.chat_bubble,
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),

                Spacer(),
                //bookmark
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.bookmark,
                      size: 30,
                    ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                ExpandableText(
                  'discription  ajhg ixca icwgsichihwcc  uahiudsah \n c owdh oiwa c ca    ashadjhkjshd ',
                  prefixText: 'username',
                  prefixStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  expandText: 'show more',
                  collapseText: 'show less',
                  maxLines: 3,
                  linkColor: Colors.blue,
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CommentScreen()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'View all  comments..',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
