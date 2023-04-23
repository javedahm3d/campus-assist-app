// import 'package:flutter/material.dart';

// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});

//   @override
//   State<AttendanceScreen> createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       appBar: AppBar(
//         title: Text('Class name'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//             CircleAvatar(
//               radius: 50,
//             ),
//             SizedBox(height: 20),
//             Text(
//               'student name',
//               style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             SizedBox(height: 10),
//             Text(
//               '191104032',
//               style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.2,
//             ),
//             InkWell(
//                 onTap: () {},
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.45,
//                   height: 60,
//                   color: Colors.green,
//                   child: Center(
//                       child: Text(
//                     'Present',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   )),
//                 )),
//             SizedBox(height: 35),
//             InkWell(
//                 onTap: () {},
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.45,
//                   height: 60,
//                   color: Colors.black,
//                   child: Center(
//                       child: Text(
//                     'Absent',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   )),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
