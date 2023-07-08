import 'dart:io';

import 'package:campus/screens/results/results_listpage.dart';
import 'package:campus/widgets/my_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:results_page/Cards/reusable_card.,/ dart';

class ResultsMainPage extends StatefulWidget {
  @override
  State<ResultsMainPage> createState() => _ResultsMainPageState();
}

class _ResultsMainPageState extends State<ResultsMainPage> {
  // String requiredCourse = '';
  String requiredSemester = '';
  String requiredDepartment = '';

  // List revisedCourses = [
  //   {'title': 'RC 07-08', 'value': '1'},
  //   {'title': 'RC 16-17', 'value': '2'},
  //   {'title': 'RC 19-20', 'value': '3'},
  // ];
  // String defaultCourse = '';

  List departments = [
    {'title': 'Civil Engineering', 'value': '01'},
    {'title': 'Mechanical Engineering', 'value': '02'},
    {'title': 'Electrical and Electronics Engineering', 'value': '03'},
    {'title': 'Electronics and Telecommunication Engineering', 'value': '04'},
    {'title': 'Computer Engineering', 'value': '05'},
    {'title': 'Information Technology', 'value': '06'},
  ];
  String defaultDepartment = '';

  List semester = [
    {'title': 'Semester 1', 'value': '01'},
    {'title': 'Semester 2', 'value': '02'},
    {'title': 'Semester 3', 'value': '03'},
    {'title': 'Semester 4', 'value': '04'},
    {'title': 'Semester 5', 'value': '05'},
    {'title': 'Semester 6', 'value': '06'},
    {'title': 'Semester 7', 'value': '07'},
    {'title': 'Semester 8', 'value': '08'},
  ];
  String defaultSemester = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Results',
      //     style: GoogleFonts.aBeeZee(fontSize: 22, fontWeight: FontWeight.bold),
      //   ),
      // ),
      appBar: MyAppBar(),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/images/doodle_bg.png'),
                fit: BoxFit.cover)),
        child: Container(
          // width: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('lib/images/doodle_bg.png'),
          //       fit: BoxFit.cover),
          //   color: Colors.white,
          // ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                      width: 200,
                      height: 200,
                      child: Image(
                          image: AssetImage('lib/images/results_logo.png'))),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select your Department and semester and click continue',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //shape: BoxShape.circle,
                      color: Colors.orangeAccent,
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: Colors.orangeAccent[200],
                            isDense: true,
                            value: defaultDepartment,
                            isExpanded: true,
                            menuMaxHeight: 350,
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  'Select Department',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                  ),
                                ),
                                value: "",
                              ),
                              ...departments.map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem(
                                    child: Text(e['title']), value: e['value']);
                              }).toList(),
                            ],
                            onChanged: (deptValue) {
                              setState(() {
                                defaultDepartment = deptValue!;
                                requiredDepartment = defaultDepartment;
                                requiredDepartment = requiredDepartment
                                    .replaceAll('01', 'Civil Engineering');
                                requiredDepartment = requiredDepartment
                                    .replaceAll('02', 'Mechanical Engineering');
                                requiredDepartment =
                                    requiredDepartment.replaceAll('03',
                                        'Electrical and Electronics Engineering');
                                requiredDepartment = requiredDepartment.replaceAll(
                                    '04',
                                    'Electronics and Telecommunication Engineering');
                                requiredDepartment = requiredDepartment
                                    .replaceAll('05', 'Computer Engineering');
                                requiredDepartment = requiredDepartment
                                    .replaceAll('06', 'Information Technology');
                              });
                              //print('selected value $value');
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      //shape: BoxShape.circle,
                      color: Colors.orangeAccent,
                    ),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: Colors.orangeAccent[200],
                            isDense: true,
                            value: defaultSemester,
                            isExpanded: true,
                            menuMaxHeight: 350,
                            items: [
                              DropdownMenuItem(
                                child: Text(
                                  'Select Semester',
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18,
                                  ),
                                ),
                                value: "",
                              ),
                              ...semester.map<DropdownMenuItem<String>>((e) {
                                return DropdownMenuItem(
                                    child: Text(e['title']), value: e['value']);
                              }).toList(),
                            ],
                            onChanged: (semValue) {
                              setState(() {
                                defaultSemester = semValue!;
                                requiredSemester = defaultSemester;
                                requiredSemester = requiredSemester.replaceAll(
                                    '01', 'Semester 1');
                                requiredSemester = requiredSemester.replaceAll(
                                    '02', 'Semester 2');
                                requiredSemester = requiredSemester.replaceAll(
                                    '03', 'Semester 3');
                                requiredSemester = requiredSemester.replaceAll(
                                    '04', 'Semester 4');
                                requiredSemester = requiredSemester.replaceAll(
                                    '05', 'Semester 5');
                                requiredSemester = requiredSemester.replaceAll(
                                    '06', 'Semester 6');
                              });
                              //print('selected value $value');
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (defaultDepartment == '' || defaultSemester == '') {
                        fillContents(context);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultsListPage(
                              sem: requiredSemester, dept: requiredDepartment),
                        ));

                        // var snap = FirebaseFirestore.instance.collection('results').doc(defaultSemester).collection(defaultDepartment)
                      }
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        'continue',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 22, color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fillContents(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(color: Colors.black87),
      ),
      content: Text(
        "Please select all details",
        style: TextStyle(color: Colors.black87),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(primary: Colors.orange),
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
