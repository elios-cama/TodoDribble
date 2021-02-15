import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_firebase_note_app/Screens/home_screen.dart';
import 'Login_Screen.dart';
import 'package:test_firebase_note_app/components/log_container.dart';
import 'package:test_firebase_note_app/google_sign_in.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/fond.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage("lib/images/logo.jpg")),
              Text(
                'Organize your works',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  "Let's organize your works with priority and do everything without stress",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              LogContainer(FontAwesomeIcons.facebook, 'Continue with Facebook',
                  Colors.blue, null),
              LogContainer(
                  FontAwesomeIcons.google, 'Continue with Google', Colors.white,
                  () {
                signInWithGoogle().whenComplete(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                });
              }),
              LogContainer(FontAwesomeIcons.envelope, 'Continue with email',
                  Colors.purple, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
