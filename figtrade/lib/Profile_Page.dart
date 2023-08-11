import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:figtrade/payments/deposit.dart';
import 'package:figtrade/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'otherfiles/PrivacyPolicy.dart';
import 'otherfiles/Trans_history.dart';
import 'otherfiles/contactus.dart';
import 'otherfiles/invite.dart';
import 'otherfiles/login.dart';
import 'otherfiles/payout.dart';

import 'package:intl/intl.dart';

void main() {
  DateTime now = DateTime.now();
  String monthName = DateFormat.MMMM().format(now); // Get month name
  String date = DateFormat.d().format(now); // Get date
  String hour = DateFormat.H().format(now); // Get hour in 24-hour format
  String minute = DateFormat.m().format(now); // Get minute

  print('$monthName $date, $hour:$minute');
}

DateTime now = DateTime.now();
String monthAndDate = DateFormat('MM-dd').format(now);
String hourAndMinute = DateFormat('HH:mm').format(now);

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: c6,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              // !----------------------------------------------------User Profile
              Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  color: c6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // !----------------------------------------------------image
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: c3,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: FaIcon(
                          FontAwesomeIcons.userAstronaut,
                          size: 40,
                        )),
                      ),
                      // !----------------------------------------------------image

                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${userdata?.get(0)['email']}',
                                  style: TextStyle(
                                      color: c3,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                                IconButton(
                                    color: c3,
                                    onPressed: () {},
                                    icon: Icon(Icons.chevron_right_outlined))
                              ],
                            ),
                            // !----------------------------------------------------image
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name',
                                      style: TextStyle(
                                          color: c3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    Text(
                                      '${userdata?.get(0)['name']}',
                                      style: TextStyle(
                                          color: c3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                sw(80),

                                // !----------------------------------------------------image

                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       'Registration Date',
                                //       style: TextStyle(
                                //           color: c3,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 10),
                                //     ),
                                //     Text(
                                //       '28 Feb 2023',
                                //       style: TextStyle(
                                //           color: c3,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 10),
                                //     ),
                                //   ],
                                // ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )),
              sh(10),
              // !----------------------------------------------------Deposit
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => Deposit_page())));
                },
                child: CostumContainer(60, Icons.wallet_travel_rounded, () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: ((context) => Payments_page())));
                }, () {}, 25, 'Deposit', Icons.chevron_right_outlined),
              ),
              sh(10),
              // !----------------------------------------------------Withdraw Funds
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => payout_page())));
                },
                child: CostumContainer(60, Icons.currency_rupee_rounded, () {},
                    () {}, 25, 'Withdraw Funds', Icons.chevron_right_outlined),
              ),
              sh(10),
              // !----------------------------------------------------Transaction
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => trans_history())));
                },
                child: CostumContainer(60, Icons.connecting_airports_sharp, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => trans_history())));
                }, () {}, 25, 'Transaction', Icons.chevron_right_outlined),
              ),
              sh(10),
              // !----------------------------------------------------Status
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => termcondation())));
                },
                child: CostumContainer(60, Icons.star_outline_sharp, () {},
                    () {}, 25, 'Terms', Icons.chevron_right_outlined),
              ),
              sh(10),
              // !----------------------------------------------------Notification
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => privacy())));
                },
                child: CostumContainer(60, Icons.notifications, () {}, () {},
                    25, 'Privacy', Icons.chevron_right_outlined),
              ),
              sh(10),
              // !----------------------------------------------------Language
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => ReferFriend())));
                },
                child: CostumContainer(60, Icons.language, () {}, () {}, 25,
                    'Refer Earn', Icons.chevron_right_outlined),
              ),
              sh(10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => contactus())));
                },
                child: CostumContainer(
                    60, Icons.contact_support_outlined, () {}, () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: ((context) => instagram())));
                }, 25, 'Contact Us', Icons.chevron_right_outlined),
              ),

              // sh(10),
              //  GestureDetector(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: ((context) => Coursepage())));
              //   },
              //   child: CostumContainer(60, Icons.menu_book, () {}, () {
              //     // Navigator.push(context,
              //     //     MaterialPageRoute(builder: ((context) => instagram())));
              //   }, 25, 'Learn How to Trade', Icons.chevron_right_outlined),
              // ),
              sh(25),
              // !----------------------------------------------------Logout
              GestureDetector(
                onTap: () {
                  setState(() {
                    GoogleSignIn().signOut();
                    // FirebaseAuth.instance.signOut();
                    userdata!.clear();
                    SystemNavigator.pop();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: c3),
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: c3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              sh(30),
              // !----------------------------------------------------Best time to Join
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Center(
              //         child: Text(
              //       '------------- Best time to join us online ------------',
              //       style: TextStyle(color: c3),
              //     )),
              //   ],
              // ),
              sh(10),
              // !----------------------------------------------------Social Media
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialMediaButton(() async {
                    var url = 'https://www.youtube.com/@nextonebox';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  }, FontAwesomeIcons.youtube, Colors.red),
                  sw(10),
                  SocialMediaButton(() async {
                    var url = 'https://www.facebook.com/nextonebox';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  }, FontAwesomeIcons.facebook, Colors.blue),
                  sw(10),
                  SocialMediaButton(() async {
                    var url = 'https://www.instagram.com/NextOneBox';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  }, FontAwesomeIcons.instagram, Colors.orange),
                  sw(10),
                  SocialMediaButton(() async {
                    var url = 'https://www.twitter.com/NextOneBox';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  }, FontAwesomeIcons.twitter, Colors.blue),
                  sw(10),
                  SocialMediaButton(
                      () {}, FontAwesomeIcons.whatsapp, Colors.green),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget CostumContainer(double height, IconData icon1, VoidCallback onTap1,
    VoidCallback onTap2, double size, String text, IconData icon2) {
  return Container(
    height: height,
    width: double.infinity,
    color: Color.fromARGB(255, 49, 53, 56),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: onTap1,
                icon: Icon(
                  icon1,
                  size: size,
                )),
            Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        IconButton(
            onPressed: onTap2,
            icon: Icon(
              icon2,
              size: size,
            )),
      ],
    ),
  );
}

Widget SocialMediaButton(
    VoidCallback callback, IconData FontAwesomeIcons, Color color) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: FaIcon(
        FontAwesomeIcons,
        color: color,
      ),
    ),
  );
}

Widget sh(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sw(double width) {
  return SizedBox(
    width: width,
  );
}
