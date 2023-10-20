import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:youget/HomePage.dart';



import 'Login_screen.dart';



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

var purple50 = c6;
var white = c6;
var black = c3;
var purple = c1;
var elecolor = c6;
double elevation = 20;



class AuthService {
  handleAuthState() {
    if (account!.isNotEmpty) {
      return homepage();
    } else {
      return Loginscreen();
    }
  }
}

var totalbalance = account?.get(0)['ballance'];
Color c3 = Colors.black;
Color c1 = Color.fromARGB(255, 11, 137, 239);
Color dc = Color.fromARGB(255, 11, 137, 239);
Color c6 = Colors.white;
Box? limits = Hive.box('limits');
Box? VIP = Hive.box('VIP');
var textstyle = TextStyle(color: c3, fontWeight: FontWeight.w500);

Widget sh(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sw(double width) {
  return SizedBox(
    width: width,
  );
}
