import 'package:flutter/material.dart';

class ButtonUtil extends StatelessWidget {
  final Color textcolour;
  final Color backgroundColor;
  final Color bordercolor;
  double borderRadius;
  String? text;
  IconData? icon;
  double size;
  bool isIcon;

  ButtonUtil(
      {super.key,
        required this.textcolour,
        required this.backgroundColor,
        required this.bordercolor,
        required this.borderRadius,
        this.text,
        required this.size,
        this.isIcon = false,
        required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: isIcon == false
            ? Text(text!,
            style: TextStyle(
                fontSize: size,
                color: textcolour,
                fontWeight: FontWeight.bold))
            : Icon(
          icon,
          color: textcolour,
          size: size,
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: bordercolor, width: 1.0),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}