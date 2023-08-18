import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../HomePage.dart';
import '../Widget.dart';

class ReferFriend extends StatefulWidget {
  const ReferFriend({super.key});

  @override
  State<ReferFriend> createState() => _ReferFriendState();
}

class _ReferFriendState extends State<ReferFriend> {
  Box? tasks = Hive.box('tasks');
  var urlapp =
      'https://play.google.com/store/apps/details?id=com.earn.lovecash';
  final String _content =
      '✅ Download LoveCash and Earn upto daily ₹5000 use My Refferal Code =  ✅ ${account!.get(0)['Refercode']}'
      ' You can EarnUpto daily ₹5000 To ₹10000 by Completing some easy task , You Can also Earn By spin and scratch '
      'Download Now LoveCash on PlayStore ';

  void _shareContent() {
    Share.share('$_content $urlapp ');
  }

  getuserdata() async {
    http.Response taskget =
        await http.get(Uri.parse('https://realcash.nextonebox.com/ShowTasks'));
    if (taskget.reasonPhrase == 'OK') {
      await tasks!.clear();
      var da = jsonDecode(taskget.body);
      for (var a in da) {
        await tasks!.add(a);
      }
    }
  }

  void _shareOnWhatsApp() async {
    String url = 'https://wa.me/?text=$_content $urlapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _shareContent();
      throw 'Could not launch $url';
    }
  }

  void _shareOnFacebook() async {
    String url =
        'https://www.facebook.com/sharer/sharer.php?u=$_content $urlapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _shareContent();
      throw 'Could not launch $url';
    }
  }

  void _shareOnTelegram() async {
    String url = 'https://telegram.me/share/url?url=$_content $urlapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _shareContent();
      throw 'Could not launch $url';
    }
  }

  DateTime pre_backpress = DateTime.now();

  @override
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
                backgroundColor: c6,
                textColor: c3,
                fontSize: 16.0);
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    gradient: LinearGradient(
                        colors: [c1, c1, Color.fromARGB(255, 67, 199, 236)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  children: [
                    sh(70),
                    Text(
                      'Refer Your Friends\n and Earn',
                      style: TextStyle(
                          color: c6, fontSize: 30, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/refe.png'),
                              fit: BoxFit.cover)),
                    ),
                    Text(
                      'Earn ₹10 every referal friend signup.\nEarn ₹100 when Your Friend Unlock Lucky Spin',
                      style: TextStyle(
                          color: c6, fontSize: 13, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    sh(20),
                    Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: c6,
                            style: BorderStyle.solid,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${account!.get(0)['Refercode']}',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: 65,
                                width: 1,
                                color: c6,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: c6,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '${account!.get(0)['Refercode']}'));
                                  // Handle copy referral code action
                                  Fluttertoast.showToast(
                                      msg: "Copied",
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: c6,
                                      textColor: c3,
                                      fontSize: 16.0);
                                },
                              ),
                            ]),
                      ),
                    ),
                    sh(25),
                    Text(
                      'Share Your Refferal Code via',
                      style: TextStyle(
                          color: c6, fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    sh(50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _shareOnTelegram();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 51, 156, 242),
                            ),
                            child: Row(children: [
                              Text(
                                'Telegram',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              sw(5),
                              Icon(
                                Icons.telegram,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _shareOnWhatsApp();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                            child: Row(children: [
                              Text(
                                'WhatsApp',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              sw(5),
                              Icon(
                                Icons.wechat,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _shareOnFacebook();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: c1,
                            ),
                            child: Row(children: [
                              Text(
                                'FaceBook',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              sw(5),
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
