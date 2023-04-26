// ignore_for_file: prefer_const_constructors

import 'package:MyChatAi/App/home.dart';
import 'package:MyChatAi/App/image.dart';
import 'package:MyChatAi/App/voic.dart';
import 'package:MyChatAi/OtherFiles/referandearn.dart';
import '../App/chat.dart';

import '../OtherFiles/account.dart';

import 'widgets.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentindex = 2;

  final screens = [
    ImageGenerate(),
    VoiceScreen(),
    Home(),
    ChatPage(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    if (account.isEmpty) {
      return LoginScr();
    } else {
      return Scaffold(
        body: screens[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 20,
            showUnselectedLabels: true,
            selectedLabelStyle: texSty,
            backgroundColor: Color.fromARGB(255, 227, 242, 223),
            unselectedItemColor: MainColor,
            selectedItemColor: MainColor,
            currentIndex: currentindex,
            onTap: (index) {
              setState(() => currentindex = index);
            },

            // ignore: prefer_const_literals_to_create_immutables
            items: [
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.image), label: 'Image'),
              BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Voice'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.house), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.message), label: 'Chat'),
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
