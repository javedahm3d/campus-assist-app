import 'dart:ui';

import 'package:campus/components/square_grid_box.dart';
import 'package:campus/screens/campus_annoucements/annoucements_list_screen.dart';
import 'package:campus/screens/classroom/class_list_page.dart';
import 'package:campus/screens/events/feed_screen.dart';
import 'package:campus/screens/profile/profile_page.dart';
import 'package:campus/widgets/my_appbar.dart';
import 'package:campus/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                          'Userame',
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
                          'SEM 7 | ETC A | 191104032',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
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
                          ],
                        )
                      ],
                    ),
                  ),

                  //profile picture
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 20),
                    child: InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      )),
                      child: Container(
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://cdna.artstation.com/p/assets/images/images/053/054/138/large/avetetsuya-studios-alien.jpg?1661309922'),
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
                                height: 150,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.deepPurple,
                                    Color.fromARGB(255, 123, 165, 255)
                                  ]),
                                  color: Color.fromARGB(100, 68, 137, 255),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //latest news
                        InkWell(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnnoucementScreen(),
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: <Widget>[
                                  ClipRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 2, sigmaY: 2),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height: 430,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Color.fromARGB(139, 0, 0, 0),
                                            border: Border.all(
                                                color: Colors.white, width: 2),
                                            backgroundBlendMode:
                                                BlendMode.colorBurn),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // alignment: Alignment.topLeft,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    height: 430,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            Color.fromARGB(134, 255, 255, 255),
                                            Colors.grey.shade600
                                          ]),
                                      color: Color.fromARGB(100, 68, 137, 255),
                                      borderRadius: BorderRadius.circular(30),
                                    ),

                                    //camous annoucements
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
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          )),
                                          Divider(
                                            color: Colors.white,
                                            thickness: 2,
                                          ),
                                          Container(
                                            height: 350,
                                            child: ListView.builder(
                                              itemCount: 7,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 18),
                                                  child: Text(
                                                    "> " +
                                                        '2023 jun - july results are published',
                                                    style: GoogleFonts.aBeeZee(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
                                    logo: AssetImage(
                                        'lib/images/library_logo.png'),
                                    title: 'Library',
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ClassListPage(),
                                    )),
                                  ),
                                  SquareGridTile(
                                    logo: AssetImage(
                                        'lib/images/results_logo.png'),
                                    title: 'Results',
                                    onTap: () => Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ClassListPage(),
                                    )),
                                  ),
                                  SquareGridTile(
                                    logo: AssetImage(
                                        'lib/images/events_logo.png'),
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
