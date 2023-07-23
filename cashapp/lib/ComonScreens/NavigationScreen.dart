import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:cashapp/AppScreens/referandearn.dart';

import 'package:flutter/material.dart';


class BottomNavigation extends StatefulWidget {


   BottomNavigation({super.key, });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  final _widgetOptions = [
 
    const Task(val: ''),
    const Home(),
    const Referandearn(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    
    if (user.isEmpty) {
      return const LoginScr();
    } else {
      
      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: const Color.fromARGB(255, 165, 180, 185),
                gap: 8,
                activeColor: Colors.blueAccent,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: const Color.fromARGB(255, 10, 71, 121),
                tabs: const [
              
                  GButton(
                    icon: LineIcons.gifts,
                    text: 'Offer',
                  ),
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.wavyMoneyBill,
                    text: 'Refer',
                  ),
                  GButton(
                    icon: LineIcons.user,
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
        ),
      );
    }
  }
}
