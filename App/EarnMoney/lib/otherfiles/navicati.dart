// ignore_for_file: prefer_const_constructors
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:earnmoney/screens/home.dart';
import 'package:earnmoney/screens/leads.dart';
import 'package:earnmoney/screens/referandearn.dart';
import '../screens/account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'widgets.dart';

class BottomNavigation extends StatefulWidget {


  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      new FirebaseAnalyticsObserver(analytics: analytics);

  int currentindex = 2;

  final screens = [
    Leadsadded(),
    Task(val: ''),
    Home(),
    Referandearn(),
    Account(analytics: analytics, observer: observer),
  ];

  @override
  Widget build(BuildContext context) {
    if (user!.isEmpty) {
      return LoginScr();
    } else {
      return Scaffold(
        backgroundColor: MainColor,
        body: screens[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 20,
            backgroundColor: BackColor,
            unselectedItemColor: Color.fromARGB(255, 164, 221, 149),
            showUnselectedLabels: true,
            selectedItemColor: MainColor,
            currentIndex: currentindex,
            onTap: (index) {
              setState(() => currentindex = index);
            },


            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_rounded), label: 'Leads'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.sackDollar), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.bullhorn), label: 'Refer&earn'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 25,
                  ),
                  label: 'Account'),
            ]),
      );
    }
  }
}
