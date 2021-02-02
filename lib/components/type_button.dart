import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  final String type;
  final Function fonction;
  final double size;
  Color colour;
  TypeButton({this.type, this.fonction, this.size ,this.colour = const Color(0xFF3532B6)} );
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: size,
      child: FlatButton(
        child: Text(
          type,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: fonction,
      ),
      decoration: BoxDecoration(
          border:  Border.all(color: Colors.grey.shade700),
          borderRadius: BorderRadius.circular(15),
          color: colour),
    );
  }
}
