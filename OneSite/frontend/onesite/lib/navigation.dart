import 'package:onesite/helper.dart';
import 'package:onesite/screens/account.dart';
import 'package:onesite/screens/createBusinees/type.dart';
import 'package:onesite/screens/near/near.dart';
import 'package:onesite/screens/potfolio/my_site.dart';


import 'login/getphone.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  final _widgetOptions = [
  PotfolioScreen(),
     TypeSc(),
     Home(),
    const Near(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // if (user.isEmpty) {
    //   return const LoginScr();
    // } else {
      
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
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.locationArrow,
                    text: 'Near',
                  ),
                  // GButton(
                  //   icon: LineIcons.home,
                  //   text: 'Home',
                  // ),
                  // GButton(
                  //   icon: LineIcons.wavyMoneyBill,
                  //   text: 'Refer',
                  // ),
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
  // }
}
