import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor, borderColor;
  final double sizeButton;
  final double sizeFont;
  const RoundedButton({
    Key? key,
    this.sizeButton = 0.7,
    required this.text,
    this.sizeFont = 14,
    required this.press,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.borderColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(29),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * sizeButton,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: () => press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          textStyle: TextStyle(
              color: textColor,
              fontSize: sizeFont,
              fontWeight: FontWeight.w500)),
    );
  }
}
