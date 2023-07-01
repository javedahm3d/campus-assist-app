// import 'package:flutter/material.dart';

// class BookDeatilsScreen extends StatefulWidget {
//   final snap;
//   const BookDeatilsScreen({super.key, required this.snap});

//   @override
//   State<BookDeatilsScreen> createState() => _BookDeatilsScreenState();
// }

// class _BookDeatilsScreenState extends State<BookDeatilsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orangeAccent,
//         title: const Text(
//           'Book Details',
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//                 width: 150,
//                 child: ElevatedButton(onPressed: () {}, child: Text('Update'))),
//           )
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             child: Center(
//               child: Image.network(
//                 'https://cdn.img.gen.in/kottayam/booksdeal/30738/Portfolio.jpg?biz=2596&width=300&v=20210619032514',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             decoration: BoxDecoration(color: Colors.white),
//             height: 300,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Card(
//               child: Container(
//                 width: double.infinity,
//                 height: 150,
//                 margin: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(25),
//                     ),
//                     Text(
//                       'book name : ${widget.snap['name']}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       'edition : ${widget.snap['edition']}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       'author name : ${widget.snap['author']}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     Text(
//                       'number of books : ${widget.snap['book count']} ',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             child: widget.snap['book count'] == '0'
//                 ? ElevatedButton(onPressed: () {}, child: Text('set reminder'))
//                 : null,
//           ),
//           PopupMenuButton(
//               child: Icon(Icons.more_vert),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               itemBuilder: (context) => [
//                     PopupMenuItem(onTap: () {}, child: Text('update')),
//                   ])
//         ],
//       ),
//     );
//   }
// }
