import 'package:flutter/material.dart';
import 'package:test_firebase_note_app/constants.dart';
import 'Register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showspinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/fond.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ModalProgressHUD(
          inAsyncCall: showspinner,
                  child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
                        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Image(image: AssetImage("lib/images/logo.jpg")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Sign in',
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
                    margin: EdgeInsets.only(top: 15 , bottom: 15),
                    decoration: BoxDecoration(
                      color: Color(0xFF8927F6),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    child: FlatButton(
                      onPressed: () async{
                        setState(() {
                          showspinner = true;
                        });
                        try{
                          final newUser = await  _auth.signInWithEmailAndPassword(email: email, password: password);
                          if(newUser != null){
                            await Navigator.push(context,  MaterialPageRoute(builder: (context) => HomeScreen()));
                          }
                          setState(() {
                          showspinner = false;
                        });
                        }catch(e){
                          print(e);
                          setState(() {
                            showspinner = false;
                          });
                        }
                        
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF3532B6)
                    ),
                    child: FlatButton(
                      
                      onPressed: (){
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                      }, 
                      child: Text('No account yet? Register now!', style: 
                      TextStyle(color: Colors.white))
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
