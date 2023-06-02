import 'package:cashapp/ComonScreens/WebView.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:cashapp/ComonScreens/widgets.dart' as widgets;


Future<void> logout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}

class Account extends StatefulWidget {
  Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? get url => null;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

   
  }

  @override
  Widget build(BuildContext context) {
    // late WebViewController noting;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: 500,
              decoration: UseBorder,
              child: Padding(
                padding: EdgeInsets.only(top: 35),
                child: Column(
                  children: [
                    GFListTile(
                      shadow: BoxShadow(offset: Offset.infinite),
                      margin: EdgeInsets.all(20),
                      avatar: GFAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          FontAwesomeIcons.userAstronaut,
                          color: Colors.red,
                        ),
                      ),
                      titleText: widgets.name,
                      subTitleText: widgets.email,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          child: GFButton(
                            color: MainColor,
                            size: 50,
                            fullWidthButton: true,
                            // Within the `FirstRoute` widget
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wallet()),
                              );
                            },
                            text: "Wallet",
                            textColor: SecondaryColor,
                            icon: Icon(
                              LineIcons.wallet,
                              color: SecondaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: GFButton(
                            color: MainColor,
                            textColor: SecondaryColor,
                            fullWidthButton: true,
                            size: 50,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountSetting()),
                              );
                            },
                            text: "Setting",
                            icon: Icon(
                              Icons.settings,
                              color: SecondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeadboadScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.auto_graph_sharp,
                      color: MainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: Text(
                          'Winners',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.insert_page_break_rounded,
                      color: MainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: Text(
                          'Support 24/7',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebPage(
                            data:
                                'https://www.nextonebox.com/TermAndConditions',
                          )),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      LineIcons.goodreads,
                      color: MainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: Text(
                          ' Term & Con.',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                var url =
                    'https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      LineIcons.star,
                      color: MainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: Text(
                          'Rate Us',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.notification_important_rounded,
                      color: MainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: Text(
                          'Notification',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          'Are you sure do you want to logout. You can login again.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavigation()),
                            );
                          },
                        ),
                        TextButton(
                          child: Text('Logout'),
                          onPressed: () {
                            logout();
                            widgets.user.clear();
                            widgets.pkacc?.clear();
                            lead?.clear();
                            widgets.widrawstaus?.clear();
                            leadsteps?.clear();
                            refer?.clear();

                            SystemNavigator.pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: MainColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              color: Color.fromARGB(255, 16, 16, 16),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          shadow: BoxShadow(offset: Offset.infinite),
                          onTap: () async {
                            var url = 'https://www.facebook.com/nextonebox';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.facebook,
                            size: 20,
                            color: MainColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          shadow: BoxShadow(offset: Offset.infinite),
                          onTap: () async {
                            var url = 'https://www.youtube.com/@nextonebox';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.youtube,
                            size: 20,
                            color: MainColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          shadow: BoxShadow(offset: Offset.infinite),
                          onTap: () async {
                            var url = 'https://www.instagram.com/nextonebox/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.instagram,
                            size: 20,
                            color: MainColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          shadow: BoxShadow(offset: Offset.infinite),
                          onTap: () async {
                            var url = 'https://twitter.com/NextOneBox';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.twitter,
                            size: 20,
                            color: MainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
