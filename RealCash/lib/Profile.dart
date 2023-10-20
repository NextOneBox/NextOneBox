import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cash/withdrawal.dart';
import 'package:cash/webview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HomePage.dart';
import 'Widget.dart';
import 'contactu_us.dart';
import 'edit_profile.dart';
import 'Colors.dart';

import 'package:http/http.dart' as http;

import 'leaderboard.dart';
import 'referearn/ReferFriend.dart';



class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  getuserdata() async {
    var email = account!.get(0)['email'];
    http.Response data = await http
        .get(Uri.parse('https://realcash.nextonebox.com/ShowAccountData?$email'));
    if (data.reasonPhrase == 'OK') {
      await account!.clear();
      var da = jsonDecode(data.body);
      print(data.body);
      for (var a in da) {
        await account!.add(a);
      }
    }
  }

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  // BannerAd? _bannerAd;

  @override
  void initState() {
    getuserdata();

    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {

    subscription.cancel();
    super.dispose();
  }

  // this function is for when internet is of show alert diolog box
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  var appbarcolor = c1;

  Widget listTile({
    IconData? icon,
    String? title,
  }) {
    return Column(
      children: [
        Divider(),
        ListTile(
          leading: Icon(
            icon,
            color: c1,
          ),
          title: Text(
            title!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: c1,
            size: 15,
          ),
        ),
      ],
    );
  }

  DateTime pre_backpress = DateTime.now();
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          Fluttertoast.showToast(
              msg: "Press Back button again to Exit",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: c1,
              textColor: c3,
              fontSize: 16.0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: c1,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "PROFILE",
            style: TextStyle(
              color: c6,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 47,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(account!.get(0)['image']),
                    radius: 45,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 250,
                        height: 80,
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${account!.get(0)['name']}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${account!.get(0)['email']}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => editprofile())),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              radius: 16,
                              backgroundColor: c1),
                        ),
                      ),
                    ],
                  ),

                  // !listTiles------------------------------------------------
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => withdrawal()));
                      },
                      child: listTile(
                        icon: Icons.wallet_outlined,
                        title: "Wallet",
                      )),

                  // !listTiles-----------------------------ReferPage-------------------
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReferFriend()));
                      },
                      child: listTile(
                          icon: Icons.copy_all_outlined, title: "Refer Earn")),

                  // !listTiles------------------------------------------------
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => contactus()));
                      },
                      child: listTile(
                          icon: Icons.language_outlined, title: "Contact Us")),

                  // !listTiles------------------------------------------------
                  GestureDetector(
                    onTap: () async {
                      // String privacy =  'https://earnkashbussiness.blogspot.com/2022/12/privicy-policy.html';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => termcondation()));
                    },
                    child: listTile(
                        icon: Icons.indeterminate_check_box,
                        title: "Term&Con.."),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String term =
                          'https://aitoolsnext.blogspot.com/2023/08/privacypoclicy.html';

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => privacy()));
                    },
                    child: listTile(
                        icon: Icons.privacy_tip_outlined,
                        title: "Privacy Policy"),
                  ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => LeaderBoard()));
                  //   },
                  //   child: listTile(
                  //       icon: FontAwesomeIcons.trophy, title: "LeaderBord"),
                  // ),
                  GestureDetector(
                    onTap: () async {
                      String twitter = 'https://t.me/nextonebox';
                      if (await canLaunch(twitter)) {
                        await launch(twitter);
                      } else {
                        throw "Error occured trying to call that number.";
                      }
                    },
                    child:
                        listTile(icon: Icons.telegram, title: "Join Telegram"),
                  ),
                  

                  // !listTiles------------------------------------------------
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          GoogleSignIn().signOut();
                          FirebaseAuth.instance.signOut();
                          account!.clear();
                          SystemNavigator.pop();
                        });

                        // wallet?.clear();
                        // totalearn?.clear();
                      },
                      child: listTile(icon: Icons.logout, title: "Logout")),

                  GestureDetector(
                      onTap: () async {
                        String youtube = 'https://www.youtube.com/@realcashapp';
                        if (await canLaunch(youtube)) {
                          await launch(youtube);
                        } else {
                          throw "Error occured trying to call that number.";
                        }
                      },
                      child: listTile(
                        icon: Icons.monetization_on,
                        title: "How To Earn",
                      )),
                  // SizedBox(height: 30),
                ]),
              ),

              // if (_bannerAd != null)
              //   Align(
              //     alignment: Alignment.topCenter,
              //     child: Container(
              //       width: _bannerAd!.size.width.toDouble(),
              //       height: _bannerAd!.size.height.toDouble(),
              //       child: AdWidget(ad: _bannerAd!),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
