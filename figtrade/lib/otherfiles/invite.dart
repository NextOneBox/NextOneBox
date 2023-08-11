import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Profile_Page.dart';
import '../widget.dart';

var urlapp =
    'https://play.google.com/store/apps/details?id=com.trading.indtrade';

class ReferFriend extends StatefulWidget {
  const ReferFriend({super.key});

  @override
  State<ReferFriend> createState() => _ReferFriendState();
}

class _ReferFriendState extends State<ReferFriend> {
  final String _content = '✅ Download INDTrade Start YOur Earning Now '
      '✅ My Refferal Code is ${userdata!.get(0)['Refercode']}'
      '✅ Practice in demo account 20000 cridet'
      '✅ Start rs 20 in real account'
      '✅ Download now ${urlapp}';

  void _shareContent() {
    Share.share('$_content $urlapp ');
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

  getuserdata() async {
    var email = userdata!.get(0)['email'];
    http.Response data = await http.get(
        Uri.parse('https://realcash.nextonebox.com/ShowAccountData?$email'));
    if (data.reasonPhrase == 'OK') {
      await userdata!.clear();
      var da = jsonDecode(data.body);
      print(da);
      for (var a in da) {
        await userdata!.add(a);
      }
    }
  }

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    getuserdata();
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
                        colors: [Colors.black, Color.fromARGB(255, 0, 0, 0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sh(70),
                    Text(
                      'Refer Your Friends\n and Earn',
                      style: TextStyle(
                          color: c3, fontSize: 30, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Earn ₹100 when Your friend deposit first time ',
                      style: TextStyle(
                          color: c3, fontSize: 13, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    sh(20),
                    Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: c3,
                            style: BorderStyle.solid,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${userdata!.get(0)['Refercode']}',
                                style: TextStyle(
                                    color: c3,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: 65,
                                width: 1,
                                color: c3,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: c3,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          '${userdata!.get(0)['Refercode']}'));
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
                    Text(
                      'Share Your Refferal Code via',
                      style: TextStyle(
                          color: c3, fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
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
                                    color: c3,
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
                                    color: c3,
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
                              color: Color.fromARGB(255, 51, 156, 242),
                            ),
                            child: Row(children: [
                              Text(
                                'FaceBook',
                                style: TextStyle(
                                    color: c3,
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
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Text(faqData[0]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(faqData[0]['answer'] ?? ''),
                  ),
                ],
              ),
              ExpansionTile(
                backgroundColor: Colors.white,
                title: Text(faqData[1]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(faqData[1]['answer'] ?? ''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(faqData[2]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(faqData[2]['answer'] ?? ''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(faqData[3]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(faqData[3]['answer'] ?? ''),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  List<Map<String, String>> faqData = [
    {
      'question': 'What is refer and earn program ?',
      'answer':
          'Refer And Earn program is when You Refer a friend You Earn Money',
    },
    {
      'question': 'How its work?',
      'answer':
          'Share this app with your friends when your friend enter your referal code You earn ₹10 when your friend Trade you earn ₹100',
    },
    {
      'question': 'How to share ?',
      'answer':
          'Copy Your referal code share with friends or click on the above whatsapp , facebook ,telegram button share with friends.',
    },
    {
      'question': 'Can i withdraw this money ?',
      'answer': 'Yes you can eaisly withdraw this money',
    },
    // Add more questions and answers as needed
  ];
}
