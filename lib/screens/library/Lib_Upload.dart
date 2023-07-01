import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class lib_upload extends StatefulWidget {
  @override
  State<lib_upload> createState() => _lib_uploadState();
}

class _lib_uploadState extends State<lib_upload> {
  TextEditingController bookname = new TextEditingController();

  TextEditingController author = new TextEditingController();

  TextEditingController edition = new TextEditingController();

  int book_count = 0;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Details'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              TextFormField(
                controller: bookname,
                decoration: InputDecoration(hintText: "Enter Book Name"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: author,
                decoration: InputDecoration(hintText: "Enter name of author"),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: edition,
                decoration: InputDecoration(hintText: "Enter Edition"),
              ),
              SizedBox(
                height: 10.0,
              ),
              Title(
                color: Colors.black,
                child: Text('Enter No.of books'),
              ),
              // NumberInputPrefabbed.roundedButtons(
              //   controller: TextEditingController(),
              //   decIconSize: 10,
              //   incIconSize: 10,
              //   incDecBgColor: Colors.amber,
              //   buttonArrangement: ButtonArrangement.incRightDecLeft,
              //   min: -10,
              //   max: 10,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (book_count == 0) {
                            SnackBar(
                                content: Text(
                                    'book count cannot be less than zero'));
                          } else {
                            book_count = book_count - 1;
                          }
                        });

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: Text('book details uploaded successfully'),
                            );
                          },
                        );
                      },
                      child: Icon(Icons.arrow_downward)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 300,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          book_count.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          book_count = book_count + 1;
                        });
                      },
                      child: Icon(Icons.arrow_upward)),
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isloading = true;
                    });
                    await FirebaseFirestore.instance
                        .collection('library')
                        .doc(bookname.text.trim())
                        .set({
                      'name': bookname.text,
                      'author': author.text,
                      'edition': edition.text,
                      'book count': book_count.toString()
                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            child: Container(
                          padding: const EdgeInsets.all(20),
                          child:
                              Text('book deatils were uploaded successfully!'),
                        ));
                      },
                    );
                    setState(() {
                      isloading = false;
                    });
                    // Navigator.of(context).pop();
                  },
                  child: isloading
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                      : Text('submit'))
            ],
          ),
        ),
      ),
    );
  }
}
