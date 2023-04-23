import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

    @override
 Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
          // titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(children: [
            Text('Campus' , style: TextStyle(
              color: Colors.black, fontSize: 20 , fontWeight: FontWeight.bold
            ),),
            Text('Assist' , style: TextStyle(
              color: Colors.blue, fontSize: 20 , fontWeight: FontWeight.bold
            ),),
          ],),
    );
  }
}