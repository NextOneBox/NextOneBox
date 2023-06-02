// ignore_for_file: prefer_const_constructors
import 'package:earnmoney/screens/home.dart';
import 'package:earnmoney/screens/referandearn.dart';
import '../screens/account.dart';
import 'widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int currentindex = 2;

//   final screens = [
//     GameScreen(),
//     Task(val: ''),
//     Home(),
//     Referandearn(),
//     Account(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     if (user.isEmpty) {
//       return LoginScr();
//     } else {
//       return Scaffold(
//         backgroundColor: MainColor,
//         body: screens[currentindex],
//         bottomNavigationBar: BottomNavigationBar(
//             iconSize: 20,
//             backgroundColor: Color.fromARGB(255, 10, 53, 89),
//             unselectedItemColor: Color.fromARGB(255, 33, 150, 243),
//             showUnselectedLabels: true,
//             selectedItemColor: Color.fromARGB(255, 12, 55, 90),
//             currentIndex: currentindex,
//             onTap: (index) {
//               setState(() => currentindex = index);
//             },
//             items: [

//               BottomNavigationBarItem(
//                   icon: Icon(Icons.add_task_rounded), label: 'Loot'),
//               BottomNavigationBarItem(
//                   icon: Icon(FontAwesomeIcons.sackDollar), label: 'Tasks'),
//               BottomNavigationBarItem(
//                   icon: Icon(FontAwesomeIcons.house), label: 'Home'),
//               BottomNavigationBarItem(
//                   icon: Icon(FontAwesomeIcons.bullhorn), label: 'Refer&earn'),
//               BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.person,
//                     size: 25,
//                   ),
//                   label: 'Account'),
//             ]),
//       );
//     }
//   }
// }

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  final _widgetOptions = [
    GameScreen(),
    Task(val: ''),
    Home(),
    Referandearn(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
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
                  icon: LineIcons.gamepad,
                  text: 'Play',
                ),
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
