import 'package:flutter/material.dart';
class LogContainer extends StatelessWidget {
  final IconData LogIcon;
  final String Title;
  final Color color;
  final Function onPressed;
  LogContainer(this.LogIcon, this.Title, this.color, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.only(left: 15),
        height: 55,
        decoration: BoxDecoration(
            color: Color(0xFF252A37), borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Icon(
                  LogIcon,
                  color: color,
                  size: 30,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
