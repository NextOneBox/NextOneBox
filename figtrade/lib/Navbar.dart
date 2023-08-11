import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:figtrade/Profile_Page.dart';
import 'package:figtrade/widget.dart';


import 'History_Page.dart';
import 'Home_Page.dart';
import 'otherfiles/invite.dart';

class Bottomapp extends StatefulWidget {
  Bottomapp({
    Key? key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _BottomappState();
  }
}

class _BottomappState extends State<Bottomapp> {
  var pagesdata = [ReferFriend(), Home_Page(), History_Page(), Profile_Page()];
  int currentindex = 1;
  onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c6,
      body: pagesdata[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: c6,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentindex,
        onTap: onTap,
        selectedItemColor: c3,
        unselectedItemColor: Colors.grey[700],
        selectedLabelStyle: TextStyle(color: Colors.green),
        // showUnselectedLabels: false,
        selectedFontSize: 13,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shortcut_sharp,
              size: 20,
            ),
            label: "Share",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 20,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                // ignore: deprecated_member_use
                FontAwesomeIcons.history,
                size: 20,
              ),
              label: "History"),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                size: 18,
              ),
              label: "Account"),
        ],
      ),
    );
  }
}
