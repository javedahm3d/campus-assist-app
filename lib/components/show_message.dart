import 'package:flutter/material.dart';

class ShowMessage{
  void showMessage(String msg , BuildContext context) async{

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              msg.toString(),
              textAlign: TextAlign.center,
            ),
          );
        });

  }
}