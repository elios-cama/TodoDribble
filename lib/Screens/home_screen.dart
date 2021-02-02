import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddTaskScreen.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final _auth = FirebaseAuth.instance;

  String messageText;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
     return Container(
      decoration: BoxDecoration(
        image : DecorationImage(
          image: AssetImage("lib/images/fond.png"),
          fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 15),
              child: ClipRRect(
                
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'lib/images/photomdb.jpg', 
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  ),
                
              ),
            )
          ],
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text("Today's schedule", style: TextStyle(fontSize: 35, fontWeight : FontWeight.bold, color : Colors.white)),
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
        ),
        body: Container(
          child: Column(
            children: [
              // Expanded(
              //   child: TaskList(),
              //   ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children : <Widget>[
                Icon(Icons.house, color: Colors.white, size: 40,),
                FlatButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
                    },

                    child: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.add, color: Colors.white,size: 35),
                    backgroundColor: Colors.purple.shade400,
                    ),
                ),
                Icon(Icons.settings, color: Colors.white,size: 40)
              ]
            ),
          )
  ),
      ),
    );
  }
}