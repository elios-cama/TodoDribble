import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Color colour;
  final String title;
  final double size;
  final Function fonction;
  Color borderColor; 
  CategoryButton({this.colour, this.title, this.size, this.fonction, this.borderColor});

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: size,
      height: 43,
      child: FlatButton(
        onPressed: fonction,
        color: colour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
              color: borderColor,
              width: 3),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        
      ),
    );
  }
}
