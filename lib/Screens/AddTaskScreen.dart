import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_firebase_note_app/components/type_button.dart';
import 'package:test_firebase_note_app/constants.dart';
import 'package:test_firebase_note_app/components/time_button.dart';
import 'package:test_firebase_note_app/components/category_button.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _firestore = FirebaseFirestore.instance;
  String title;
  bool importantButtonState = true;
  bool plannedButtonState = false;
  String type;
  String category;
  bool foodButtonState = false;
  bool workoutButtonState = false;
  bool workButtonState = false;
  bool designButtonState = false;
  bool runButtonState = false;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay(hour: 00, minute: 00);
  String dayDate;
  String _dayTime;
  String dateTitle = 'Select a date';
  String timeTitle = 'Select Time';
  


  void setCategoryButtonState() {
    foodButtonState = false;
    workoutButtonState = false;
    workButtonState = false;
    designButtonState = false;
    runButtonState = false;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
      context: context,
      initialDate: date,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date)
      setState(() {
        //print(new DateFormat.yMMMd().format(new DateTime.now()));
        date = picked;
        dayDate = DateFormat.Md().format(date);
        dateTitle = dayDate;
        
      });
  }
  Future<Null> _selectTime(BuildContext context) async {
  final TimeOfDay picked = await showTimePicker(
    builder: (context, child) {
        return Theme(
          data: ThemeData.dark(), // This will change to light theme.
          child: child,
        );
      },
    context: context,
    initialTime: time,
  );
  if (picked != null)
    setState(() {
      time = picked;
      _dayTime = '${time.hour}:${time.minute}';
      timeTitle = _dayTime;
    });}


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kWalpaper,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Create \nNew task',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold)),
              TextField(
                style: TextStyle(color: Colors.grey.shade700) ,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey.shade700),
                    hintText: "  Task Title",
                    fillColor: Color(0xFF292E3C)),
                onChanged: (value) {
                  title = value;
                },
              ),
              Text('Type', style: kTextDecoration),
              Row(
                children: [
                  TypeButton(
                    type: 'Important',
                    fonction: () => setState(() {
                      importantButtonState = !importantButtonState;
                      plannedButtonState = !plannedButtonState;
                      type = 'important';
                    }),
                    size: 98,
                    colour: importantButtonState
                        ? Color(0xFF3532B6)
                        : Colors.transparent,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  TypeButton(
                    type: 'Planned',
                    fonction: () => setState(() {
                      plannedButtonState = !plannedButtonState;
                      importantButtonState = !importantButtonState;
                      type = 'planned';
                    }),
                    size: 88,
                    colour: plannedButtonState
                        ? Color(0xFF3532B6)
                        : Colors.transparent,
                  )
                ],
              ),
              Text('Choose date & time', style: kTextDecoration),
              Row(
                children: [
                  TimeButton(
                    dateTitle,
                    FontAwesomeIcons.calendar,
                    () => _selectDate(context),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TimeButton(
                    timeTitle, 
                    FontAwesomeIcons.clock, 
                    () => _selectTime(context),
                    )
                ],
              ),
              Text('Category', style: kTextDecoration),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CategoryButton(
                          colour: Color(0xFFFE6D6E),
                          title: 'Food',
                          size: 70,
                          fonction: () => setState(() {
                            setCategoryButtonState();
                            foodButtonState = !foodButtonState;
                            category = 'Food';
                          }),
                          borderColor: foodButtonState
                              ? Colors.grey.shade700
                              : Colors.transparent,
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        CategoryButton(
                          colour: Color(0xFFF19731),
                          title: 'Workout',
                          size: 90,
                          fonction: () => setState(() {
                            setCategoryButtonState();
                            workoutButtonState = !workoutButtonState;
                            category = 'Workout';
                          }),
                          borderColor: workoutButtonState
                              ? Colors.grey.shade700
                              : Colors.transparent,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        CategoryButton(
                          colour: Color(0xFF6457FF),
                          title: 'Work',
                          size: 70,
                          fonction: () => setState(() {
                            setCategoryButtonState();
                            workButtonState = !workButtonState;
                            category = 'Work';
                          }),
                          borderColor: workButtonState
                              ? Colors.grey.shade700
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CategoryButton(
                        colour: Color(0xFF234EBC),
                        title: 'Design',
                        size: 80,
                        fonction: () => setState(() {
                          setCategoryButtonState();
                          designButtonState = !designButtonState;
                          category = 'Design';
                        }),
                        borderColor: designButtonState
                            ? Colors.grey.shade700
                            : Colors.transparent,
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      CategoryButton(
                        colour: Color(0xFF2BC8D9),
                        title: 'Run',
                        size: 64,
                        fonction: () => setState(() {
                          setCategoryButtonState();
                          runButtonState = !runButtonState;
                          category = 'Run';
                        }),
                        borderColor: runButtonState
                            ? Colors.grey.shade700
                            : Colors.transparent,
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage("lib/images/button_fond.png"),
                        fit: BoxFit.cover)),
                child: FlatButton(
                    onPressed: () {
                      // print(title);
                      // print(type);
                      // print(category);
                      // print(dayDate);
                      // print(_dayTime);
                      _firestore.collection('todos').add({
                        'title' : title,
                        'type' : type,
                        'date' : dayDate,
                        'time' : _dayTime,
                        'category' : category
                      });
                      Navigator.pop(context);
                      
                      
                    },
                    child: Text('Create Task', style: kTextDecoration)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
