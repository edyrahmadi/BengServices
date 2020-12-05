import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final String btnText;

  AddButton({this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey[200],
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(5.0) //         <--- border radius here
            ),
      ),
      child: Center(
        child: Text(
          "$btnText",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
