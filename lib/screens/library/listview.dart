import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Lib_Upload.dart';
import 'libraryCard.dart';

class LibraryListScreen extends StatefulWidget {
  @override
  State<LibraryListScreen> createState() => _LibraryListScreenState();
}

class _LibraryListScreenState extends State<LibraryListScreen> {
  List _allResults = [];
  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    print(_searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var booksSnapshot in _allResults) {
        var name = booksSnapshot['name'].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(booksSnapshot);
        }
      }
    } else {
      showResults = List.from(_allResults);
    }

    setState(() {
      _resultList = showResults;
    });
  }

  getbooksStream() async {
    var data = await FirebaseFirestore.instance
        .collection('library')
        .orderBy('name')
        .get();

    setState(() {
      _allResults = data.docs;
      print(_allResults);
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getbooksStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orangeAccent,
        title: CupertinoSearchTextField(
          controller: _searchController,
          backgroundColor: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('library')
              .where('name', isGreaterThanOrEqualTo: _searchController.text)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot);
            return ListView.builder(
                //  print(snapshot)
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) =>
                    libraryCard(context, snapshot.data!.docs[index].data()));
          }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: SizedBox(
      //   height: 45,
      //   width: 45,
      //   child: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: (() {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => lib_upload(),
      //       ));
      //     }),
      //   ),
      // ),
    );
  }
}
