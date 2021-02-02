import 'package:flutter/material.dart';
class TimeButton extends StatelessWidget {
  String title;
  final IconData icon;
  final Function onPressed;
  TimeButton(this.title, this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        height: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade700),
            color: Colors.transparent),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey.shade700,
            ),
            SizedBox(width: 7,),
            Text(title, style: TextStyle(color: Colors.grey.shade700),)
          ],
        ),
      ),
    );
  }
}
