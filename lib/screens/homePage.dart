import 'dart:ui';

import 'package:campus/components/square_grid_box.dart';
import 'package:campus/contacts/contacts_listPage.dart';
import 'package:campus/screens/library/listview.dart';
import 'package:campus/screens/campus_annoucements/annoucements_list_screen.dart';
import 'package:campus/screens/classroom/class_list_page.dart';
import 'package:campus/screens/events/feed_screen.dart';
import 'package:campus/screens/fees/upi_payment.dart';
import 'package:campus/screens/profile/profile_page.dart';
import 'package:campus/screens/results/results_main_page.dart';
import 'package:campus/widgets/my_appbar.dart';
import 'package:campus/widgets/navigation_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var snap;
  String name = '';
  String roll = '';
  String department = '';
  String sem = '';
  String photoURL = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    // snap = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .get();
  }

  getdata() async {
    snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      name = snap.data()!['name'];
      department = snap.data()!['department'];
      roll = snap.data()!['Roll Number'];
      sem = snap.data()!['sem'];
      photoURL = snap.data()!['profile image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyNavigationDrawer(),
      body: SafeArea(
          child: Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: Column(
          children: [
            //homepage header
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Goa Engineering College',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$department',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'SEM $sem | $roll',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              //attendance
                              Container(
                                width: 95,
                                height: 95,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color.fromARGB(50, 255, 255, 255),
                                          Color.fromARGB(120, 255, 255, 255)
                                        ]),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.white)),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: new CircularPercentIndicator(
                                        header: Text('Attendance',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        radius: 30,
                                        lineWidth: 7,
                                        percent: 0.8,
                                        center: Text(
                                          '80%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        progressColor: Colors.white,
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        backgroundColor: Colors.transparent,
                                        animation: true,
                                        animationDuration: 2500,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),

                              //due fees
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UPI_PAYMENT(),
                                    )),
                                child: Container(
                                  width: 95,
                                  height: 95,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(50, 255, 255, 255),
                                            Color.fromARGB(120, 255, 255, 255)
                                          ]),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.white)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 12),
                                        child: Text(
                                          'Fees Due',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        '420',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Spacer(),
                  // profile picture
                  Padding(
                    padding: const EdgeInsets.only(right: 15, top: 20),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      )),
                      child: Container(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(photoURL),
                          )),
                    ),
                  )
                ],
              ),
            ),

            //lowerbody
            Expanded(
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/images/doodle_bg.png'),
                        fit: BoxFit.cover),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Container(
                        //   height: 30,
                        //   width: double.infinity ,
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topCenter,
                        //       end: Alignment.bottomCenter,
                        //       colors: [Colors.white , Color.fromARGB(0, 255, 255, 255)]
                        //       )
                        //   ),
                        // ),
                        SizedBox(height: 10),

                        //gridview

                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(15),
                        //     child: GridView.builder(
                        //       reverse: true,
                        //       itemCount: 6,
                        //       gridDelegate:
                        //           SliverGridDelegateWithFixedCrossAxisCount(
                        //         crossAxisCount: 2,
                        //         crossAxisSpacing: 15,
                        //         mainAxisSpacing: 20,
                        //       ),
                        //       itemBuilder: (context, index) {
                        //         return SquareGridTile();
                        //       },
                        //     ),
                        //   ),
                        // )

                        //statistics graph
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Stack(
                            children: <Widget>[
                              ClipRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                // height: 150,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.deepPurple,
                                    Color.fromARGB(255, 123, 165, 255)
                                  ]),
                                  color: Color.fromARGB(100, 68, 137, 255),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Center(
                                      child: Image.asset(
                                        'lib/images/graph.png',
                                        width: 310,
                                        height: 150,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '-------coming soon-------',
                                        style: GoogleFonts.roboto(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.07,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //camous annoucements

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 2, sigmaY: 2),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 442,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color:
                                                  Color.fromARGB(139, 0, 0, 0),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              backgroundBlendMode:
                                                  BlendMode.colorBurn),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // alignment: Alignment.topLeft,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 442,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color.fromARGB(
                                                  134, 255, 255, 255),
                                              Colors.grey.shade600
                                            ]),
                                        color:
                                            Color.fromARGB(100, 68, 137, 255),
                                        borderRadius: BorderRadius.circular(30),
                                      ),

                                      child: InkWell(
                                        onTap: () => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              AnnoucementScreen(),
                                        )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                'Campus\n Announcements',
                                                style: GoogleFonts.aBeeZee(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              )),
                                              Divider(
                                                color: Colors.white,
                                                thickness: 2,
                                              ),
                                              Container(
                                                height: 350,
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'Campus announcements')
                                                        .snapshots(),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot<
                                                                    Map<String,
                                                                        dynamic>>>
                                                            snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      }
                                                      return ListView.builder(
                                                          itemCount: snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length >
                                                                  7
                                                              ? 7
                                                              : snapshot.data!
                                                                  .docs.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          3),
                                                              child: Text(
                                                                "> ${snapshot.data!.docs[index].data()['title']}",
                                                                style: GoogleFonts.aBeeZee(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            );
                                                          });
                                                    }),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //contacts
                                InkWell(
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ContactsListPage(),
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height: 75,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(colors: [
                                            Color.fromARGB(138, 167, 167, 167),
                                            Colors.grey
                                          ]),
                                          color:
                                              Color.fromARGB(78, 134, 134, 134),
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          border: Border.all(
                                              color: Colors.white, width: 4)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12),
                                            child: Image.asset(
                                                'lib/images/contact.png'),
                                          ),
                                          Text(
                                            'Contacts',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                SquareGridTile(
                                  logo: AssetImage(
                                      'lib/images/app_logo_black_border.png'),
                                  title: 'classrooms',
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ClassListPage(),
                                  )),
                                ),
                                SquareGridTile(
                                  logo:
                                      AssetImage('lib/images/library_logo.png'),
                                  title: 'Library',
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => LibraryListScreen(),
                                  )),
                                ),
                                SquareGridTile(
                                  logo:
                                      AssetImage('lib/images/results_logo.png'),
                                  title: 'Results',
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => ResultsMainPage(),
                                  )),
                                ),
                                SquareGridTile(
                                  logo:
                                      AssetImage('lib/images/events_logo.png'),
                                  title: 'events',
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => const FeedScreen(),
                                  )),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
