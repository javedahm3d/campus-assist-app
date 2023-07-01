import 'package:campus/components/my_button.dart';
import 'package:campus/components/my_textfield.dart';
import 'package:campus/components/square_tile.dart';
import 'package:campus/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final rollNumberController = TextEditingController();
  final departmentController = TextEditingController();
  final semController = TextEditingController();

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign user up method

  Future signUserUp() async {
    //to show loading screen
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //firbase authentication to create new user

    if (emailController.text.isNotEmpty ||
        fullNameController.text.isNotEmpty ||
        passwordController.text.isNotEmpty ||
        departmentController.text.isNotEmpty) {
      if (passwordController.text == confirmPasswordController.text) {
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .then((value) {
            _firestore.collection('users').doc(value.user!.uid).set({
              "name": fullNameController.text,
              "email": emailController.text,
              "Roll Number": rollNumberController.text,
              "department": departmentController.text,
              'sem': semController.text,
              'uid': value.user!.uid,
              'profile image':
                  'https://cdna.artstation.com/p/assets/images/images/053/054/138/large/avetetsuya-studios-alien.jpg?1661309922'
            });
          });
          print('control was here');
          //pop the loading circle
          Navigator.pop(context);
        } on FirebaseAuthException catch (e) {
          //pop the loading circle
          Navigator.pop(context);
          showErrorMessage(e.code.replaceAll('-', " "));
        }
      } else {
        //passwords not matching error

        showErrorMessage("Passwords don't match");
      }
    }
  }

  void showErrorMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),

                // logo

                Container(
                  width: 150,
                  height: 150,
                  child: Image.asset('lib/images/app_logo.png'),
                ),

                const SizedBox(height: 5),

                // welcome back, you've been missed!
                Text(
                  'let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //fullname textfield
                // email textfield
                MyTextField(
                  controller: fullNameController,
                  hintText: 'Full name*',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'email id*',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // Roll Number textfield
                MyTextField(
                  controller: rollNumberController,
                  hintText: 'Roll Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // department textfield
                MyTextField(
                  controller: departmentController,
                  hintText: 'Department*',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // sem textfield
                MyTextField(
                  controller: semController,
                  hintText: 'semester',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password*',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password*',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                // sign up button
                MyButton(text: 'Sign Up', onTap: signUserUp),

                const SizedBox(height: 30),

                // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Or continue with',
                //           style: TextStyle(color: Colors.grey[700]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // const SizedBox(height: 30),

                // // google + apple sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // google button
                //     SquareTile(
                //         onTap: () => AuthService().signInWithGoogle(),
                //         imagePath: 'lib/images/google.png'),

                //     SizedBox(width: 25),

                //     // apple button
                //     SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png')
                //   ],
                // ),

                // const SizedBox(height: 50),

                // already have account? login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have account ?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
