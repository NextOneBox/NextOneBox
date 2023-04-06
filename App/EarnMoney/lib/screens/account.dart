import 'package:earnmoney/otherfiles/webpage.dart';
import 'package:earnmoney/screens/getphone.dart';

import '../otherfiles/widgets.dart';
import '../otherfiles/widgets.dart' as widgets;
import 'contactus.dart';

Future<void> logout() async {
  await GoogleSignIn().disconnect();
  FirebaseAuth.instance.signOut();
}

class Account extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  Account({super.key, required this.analytics, required this.observer});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? get url => null;
  BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: 'ca-app-pub-3946644332709876/6246084818',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  Future<Null> _sendAnalytics() async {
    await widget.analytics
        .logEvent(name: 'full_screen_tapped', parameters: <String, dynamic>{});
  }

  @override
  Widget build(BuildContext context) {
    print(isLoaded);

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
                      margin: EdgeInsets.all(20),
                      avatar: GFAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          FontAwesomeIcons.userAstronaut,
                          color: MainColor,
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
                              SetAnalytic('Wallet');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Wallet()),
                              );
                            },
                            text: "Wallet",
                            textColor: BackColor,
                            icon: Icon(
                              FontAwesomeIcons.wallet,
                              color: BackColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: GFButton(
                            color: MainColor,
                            textColor: BackColor,
                            fullWidthButton: true,
                            size: 50,
                            onPressed: () {
                              SetAnalytic('Setting');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AccountSetting()),
                              );
                            },
                            text: "Setting",
                            icon: Icon(
                              FontAwesomeIcons.userPen,
                              color: BackColor,
                            ),
                          ),
                        ),
                      ],
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
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFButton(
                          color: BackColor,
                          size: 50,
                          fullWidthButton: true,
                          // Within the `FirstRoute` widget
                          onPressed: () {
                            SetAnalytic('LeadBoard');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LeadboadScreen()),
                            );
                          },
                          text: "Winners",
                          textColor: PrColor,
                          icon: Icon(
                            Icons.card_giftcard_rounded,
                            color: MainColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFButton(
                          color: BackColor,
                          size: 50,
                          fullWidthButton: true,
                          // Within the `FirstRoute` widget
                          onPressed: () {
                            SetAnalytic('Notification');

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotificationScreen()),
                            );
                          },

                          text: "Notification",
                          textColor: PrColor,
                          icon: Icon(
                            FontAwesomeIcons.bell,
                            color: MainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFButton(
                          color: BackColor,
                          size: 50,
                          fullWidthButton: true,
                          // Within the `FirstRoute` widget
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUs()),
                            );
                            SetAnalytic('ContactUs');
                          },
                          text: "Support 24/7",
                          textColor: PrColor,
                          icon: Icon(
                            FontAwesomeIcons.headset,
                            color: MainColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFButton(
                          color: BackColor,
                          size: 50,
                          fullWidthButton: true,
                          // Within the `FirstRoute` widget
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WebPage(
                                        data:
                                            'https://www.nextonebox.com/TermAndConditions',
                                      )),
                            );
                            SetAnalytic('Term&Con');
                          },

                          text: " Term & Con.",
                          textColor: PrColor,
                          icon: Icon(
                            FontAwesomeIcons.signature,
                            color: MainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFButton(
                          color: BackColor,
                          size: 50,
                          fullWidthButton: true,
                          // Within the `FirstRoute` widget
                          onPressed: () async {
                            SetAnalytic('RateUs');

                            var url =
                                'https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          text: "Rate us",
                          textColor: PrColor,
                          icon: Icon(
                            FontAwesomeIcons.star,
                            color: MainColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFButton(
                          color: BackColor,
                          size: 50,
                          fullWidthButton: true,
                          // Within the `FirstRoute` widget
                          onPressed: () {
                            SetAnalytic('Logout');

                            showFlash(
                              context: context,
                              duration: Duration(seconds: 2),
                              builder: (_, c) {
                                return Flash.bar(
                                  barrierDismissible: true,
                                  controller: c,
                                  backgroundColor:
                                      Color.fromARGB(255, 247, 247, 250),
                                  position: FlashPosition.bottom,
                                  margin: EdgeInsets.all(50),
                                  borderRadius: BorderRadius.circular(20),
                                  child: FlashBar(
                                    padding: EdgeInsets.all(40),
                                    title: Text(
                                      "Logout",
                                      style: texSty,
                                    ),
                                    content: Text(
                                      "Are you sure do you want to logout. You can login again",
                                    ),
                                    actions: [
                                      TextButton(
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
                                        child: Text(
                                          'Logout',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          text: "Logout",
                          textColor: PrColor,
                          icon: Icon(
                            Icons.logout,
                            color: MainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          onTap: () async {
                            SetAnalytic('Facebook');

                            var url = 'https://www.facebook.com/nextonebox';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.facebook,
                            size: 20,                
                            color: PrColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          onTap: () async {
                            SetAnalytic('Youtube');

                            var url = 'https://www.youtube.com/@nextonebox';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.youtube,
                            size: 20,
                            color: PrColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          onTap: () async {
                            SetAnalytic('instagram');

                            var url = 'https://www.instagram.com/nextonebox/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.instagram,
                            size: 20,
                            color: PrColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        height: 50,
                        margin: EdgeInsets.all(5),
                        decoration: UseBorder,
                        child: GFListTile(
                          onTap: () async {
                            SetAnalytic('twitter');

                            var url = 'https://twitter.com/NextOneBox';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.twitter,
                            size: 20,
                            color: PrColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  isLoaded
                      ? Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: AdWidget(ad: _ad!),
                        )
                      : const SizedBox()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
