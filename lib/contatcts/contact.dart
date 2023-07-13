import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Campuscontact {
  final String name;
  final String phone;
  final String Designation;
  final String email;

  Campuscontact(
      {required this.name,
      required this.phone,
      required this.Designation,
      required this.email});
}

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream =
        FirebaseFirestore.instance.collection('campus_contacts').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        title: Text('campus_contacts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Campuscontact> contacts = snapshot.data!.docs
              .map((doc) => Campuscontact(
                    name: doc['Name'],
                    phone: doc['Number'],
                    Designation: doc['Designation'],
                    email: doc['Email'],
                  ))
              .toList();

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              Campuscontact contact = contacts[index];
              return ListTile(
                title: Text(
                  contact.name,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(contact.Designation),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {
                        launch('tel:${contact.phone}');
                      },
                    ),
                    IconButton(
                        icon: Icon(Icons.email),
                        onPressed: () async {
                          Uri mail = Uri.parse("mailto:${contact.email}");
                          if (await launchUrl(mail)) {}
                        }),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
