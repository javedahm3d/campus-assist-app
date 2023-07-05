// import 'package:campus/Library/bookdetails.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bookdetails.dart';

libraryCard(BuildContext context, final snap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BookDeatilsScreen(
          snap: snap,
        ),
      )),
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Color.fromARGB(65, 0, 0, 0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${snap['name']}',
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text('Author : ${snap['author']}'),
              Text('number of books : ${snap['book count']}'),
            ],
          ),
        ),
      ),
    ),
  );
}
