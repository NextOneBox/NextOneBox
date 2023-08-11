import 'package:chatai/App/home.dart';
import 'package:chatai/App/image.dart';
import 'package:chatai/OtherFiles/referandearn.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../App/chat.dart';
import '../OtherFiles/account.dart';
import 'widgets.dart';
import 'package:line_icons/line_icons.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  final _widgetOptions = [
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
                hoverColor: Color.fromARGB(255, 165, 180, 185),
                gap: 8,
                activeColor: Colors.blueAccent,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Color.fromARGB(255, 10, 71, 121),
                tabs: [
                  GButton(
                    icon: LineIcons.image,
                    text: 'Image',
                  ),
                  GButton(
                    icon: LineIcons.audible,
                    text: 'Voice',
                  ),
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.chat_bubble_outline,
                    text: 'Chat',
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
