import 'package:mugcash/ComonScreens/WebView.dart';
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:mugcash/ComonScreens/widgets.dart' as widgets;
import 'package:flutter/material.dart';

Future<void> logout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}

class Account extends StatefulWidget {
  const Account({super.key});

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
    // String profileimage = adsbox!.get(1000)['image'];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: 500,
              decoration: UseBorder,
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: Column(
                  children: [
                    GFListTile(
                      shadow: const BoxShadow(offset: Offset.infinite),
                      margin: const EdgeInsets.all(20),
                      avatar: GFAvatar(
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 47,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(adsbox!.get(1000)['image']),
                              radius: 45,
                            ),
                          )),
                      titleText: user.get(0)['Name'],
                      subTitleText: user.get(0)['Email'],
                    ),
                    const SizedBox(
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
                                    builder: (context) => const Wallet()),
                              );
                            },
                            text: "Wallet",
                            textColor: SecondaryColor,
                            icon: const Icon(
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
                                    builder: (context) =>
                                        const AccountSetting()),
                              );
                            },
                            text: "Setting",
                            icon: const Icon(
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
                  MaterialPageRoute(
                      builder: (context) => const LeadboadScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FontAwesomeIcons.crown,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: Text(
                          'LeaderBoard',
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
                  MaterialPageRoute(builder: (context) => const ContactUs()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.headset_mic,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
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
                      builder: (context) => const WebPage(
                            data:
                                'https://mugcash.blogspot.com/2023/08/terms.html',
                          )),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.shield_rounded,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text(
                          'Are you sure do you want to logout. You can login again.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavigation()),
                            );
                          },
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () async {
                            logout();
                            await user.clear();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScr()),
                              (Route<dynamic> route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
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
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          FontAwesomeIcons.facebook,
                          size: 20,
                          color: MainColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          FontAwesomeIcons.youtube,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          FontAwesomeIcons.twitter,
                          size: 20,
                          color: Colors.blue,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          FontAwesomeIcons.instagram,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          FontAwesomeIcons.telegram,
                          size: 20,
                          color: Colors.blue,
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
