import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'AddTaskScreen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:test_firebase_note_app/components/todo_card.dart';

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
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  // void TodosStream() async {
  //   await for (var snapchot in _firestore.collection('todos').snapshots()) {
  //     for (var todos in snapchot.docs) {
  //       print(todos.data());
  //     }
  //   }
  // }
  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/images/fond.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 15),
              child: FlatButton(
                onPressed: () {
                  _signOut();
                },
                child: Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text("To do List",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
        ),
        body: Container(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("todos")
                    .where("author", isEqualTo: loggedInUser.uid)
                    .snapshots(),
                builder: (context, snapchot) {
                  if (!snapchot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                  final todos = snapchot.data.docs;
                  List<TodoCard> todoWidgets = [];
                  for (var todo in todos) {
                    final todoTitle = todo.data()['title'];
                    final todoType = todo.data()['type'];
                    final todoDate = todo.data()['date'];
                    final todoTime = todo.data()['time'];
                    final todoCategory = todo.data()['category'];
                    final todoWidget =
                        TodoCard(todoTime, todoTitle, todoCategory, todoDate);
                    todoWidgets.add(todoWidget);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: todoWidgets,
                    ),
                  );
                },
              )
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
                  children: <Widget>[
                    Icon(
                      Icons.house,
                      color: Colors.white,
                      size: 40,
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTaskScreen()));
                      },
                      child: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.add, color: Colors.white, size: 35),
                        backgroundColor: Colors.purple.shade400,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.white, size: 40)
                  ]),
            )),
      ),
    );
  }
}
