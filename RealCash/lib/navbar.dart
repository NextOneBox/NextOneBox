import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cash/HomePage.dart';

import 'Tasksoffer.dart';
import 'Profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'Widget.dart';
import 'referearn/ReferFriend.dart';

// // this is navbar c

class Bottomapp extends StatefulWidget {
  @override
  _BottomappState createState() => _BottomappState();
}

class _BottomappState extends State<Bottomapp> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  var pagesdata = [

    homepage(),
    Taskoffers(),
    // LeaderBoard(),
   ReferFriend(),

    ProfilePage()
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: c1,
      body: Center(
        child: pagesdata.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: c6,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: c1,
            iconSize: 20,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            tabs: [
           
              GButton(
                icon: FontAwesomeIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: FontAwesomeIcons.gift,
                text: 'Tasks',
              ),
              GButton(
                icon: FontAwesomeIcons.share,
                text: 'Refer',
              ),
              GButton(
                icon: FontAwesomeIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
