import 'package:campus/components/my_button.dart';
import 'package:campus/components/my_textfield.dart';
import 'package:campus/components/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      //pop the loading circle
      Navigator.pop(context);

      
      ShowMessage().showMessage("link to reset password for your account is sent to your email id ",context);

    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      ShowMessage().showMessage(e.code.replaceAll('-', " "), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                child: Text(
                  "       dont worry.\nwe've got your back!",
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Image.asset('lib/images/app_logo.png'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: SafeArea(
              child: Center(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Enter your email id so that we can send you a link to reset your password.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
              controller: _emailController,
              hintText: 'email id',
              obscureText: false),
          const SizedBox(height: 30),
          MyButton(onTap: passwordReset, text: 'Send link'),
        ]),
      ))),
    );
  }
}
