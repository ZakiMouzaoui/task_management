import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;

  const ButtonWidget({Key? key, required this.buttonText, required this.backgroundColor, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20,
            color: textColor
          ),
        ),
      ),
    );
  }
}
