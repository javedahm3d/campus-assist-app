import 'package:flutter/material.dart';

import '../../widgets/my_appbar.dart';
import '../../widgets/navigation_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: MyNavigationDrawer(),
      body: SafeArea(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
