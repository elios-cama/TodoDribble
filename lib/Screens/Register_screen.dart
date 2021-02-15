import 'package:flutter/material.dart';
import 'package:test_firebase_note_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/fond.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image(image: AssetImage("lib/images/logo.jpg")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Sign up!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your email')),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            userName = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your User name')),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                              hintText: 'Enter your password')),
                    ],
                  ),
                  Container(
                    height: 30,
                    width: 55,
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF8927F6),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    child: FlatButton(
                      // onPressed: () async {
                      //   setState(() {
                      //     showSpinner = true;
                      //   });
                      //   try {
                      //     final newUser =
                      //         await _auth.createUserWithEmailAndPassword(
                      //             email: email, password: password);
                      //     if (newUser != null) {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => HomeScreen()));
                      //     }
                      //     setState(() {
                      //       showSpinner = false;
                      //     });
                      //   } catch (e) {
                      //     print(e);
                      //   }
                      // },
                      onPressed: () async {
                        // Register user by firebase auth
                        final User user = (await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password))
                            .user;

                        /* store users data in firestore database */
                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user.uid).set({ 'username': userName});
                        print(user.uid);

                         Navigator.push(context,  MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
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
}
