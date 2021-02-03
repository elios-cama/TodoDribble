import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TodoCard extends StatefulWidget {
  final String title;
  final String category;
  final String time;
  

  TodoCard(this.time, this.title, this.category);

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  IconData icon;

  void chooseIcon(String category){
    print(category);
    switch(category) { 
   case 'Food': { 
     icon = FontAwesomeIcons.hamburger;
   } 
   break; 
  
   case 'Workout': { 
      icon = FontAwesomeIcons.dumbbell; 
   } 
   break; 
    case 'Work': { 
      icon = FontAwesomeIcons.chartLine;
   } 
   break; 
   case 'Design': { 
      icon = FontAwesomeIcons.pencilAlt;
   } 
   break; 
   case 'Run': { 
      icon = FontAwesomeIcons.running; 
   } 
   break; 
   
} 

  }
  @override
  void initState() {
    super.initState();
    chooseIcon(widget.category);
  }
   

  @override
  Widget build(BuildContext context) {
    bool TodoState = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: TodoState, onChanged: null),
        Expanded(
                  child: Container(
            padding: EdgeInsets.all(13),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:  Color(0xFF292E3C)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, size: 30,color: Colors.white,),
                Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                Text(widget.time, style: TextStyle(fontSize: 15, color: Colors.grey.shade700),)
              ],
              ),
          ),
        ),
      ],
    );
  }
}