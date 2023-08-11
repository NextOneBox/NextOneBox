import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:test1/HomePage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Colors.dart';
import 'package:http/http.dart' as http;

import 'Widget.dart';
import 'edit_profile.dart';

class Car1 extends StatefulWidget {
  final tasksshow;

  Car1({Key? key, this.tasksshow}) : super(key: key);

  @override
  State<Car1> createState() => _Car1State();
}

class _Car1State extends State<Car1> {
  var Textstyl = const TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w400);
  // BannerAd? _bannerAd;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLoadin = false;
  getuserdata() async {
    var email = account!.get(0)['email'];
    http.Response data = await http
        .get(Uri.parse('https://realcash.nextonebox.com/ShowAccountData?$email'));
    if (data.reasonPhrase == 'OK') {
      await account!.clear();
      var da = jsonDecode(data.body);
      setState(() async {
        for (var a in da) {
          await account!.add(a);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var taskkdetail = widget.tasksshow['taskdetail'];
    var pt = taskkdetail.replaceAll(',', '\n\n');
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: c6,
          elevation: 0,
          leading: BackButton(
            color: c3,
          ),
          title: Text(
            widget.tasksshow['name'],
            style: TextStyle(color: c3),
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    elevation: elevation,
                    shadowColor: elecolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Steps To Earn',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹${widget.tasksshow['price']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  pt.toString(),
                                  style: Textstyl,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: 55,
                          child: MaterialButton(
                            onPressed: () async {
                              bool result = await InternetConnectionChecker()
                                  .hasConnection;
                              if (result == true) {
                                if (account?.get(0)['phonenumber'] ==
                                    'Phone Number') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => editprofile()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                          backgroundColor: c6,
                                          content: Text(
                                              'Please update your profile',style: textstyle,)));
                                } else {
                                  String link = widget.tasksshow['referlink'];
                                  if (await canLaunch(link)) {
                                    await launch(link, forceWebView: false);
                                  } else {
                                    throw "Error occured trying to call that number.";
                                  }
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "No Iternet Connection",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: c6,
                                    textColor: c3,
                                    fontSize: 16.0);
                              }
                            },
                            child: Text(
                              'Redeem',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            color: c1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.of(context).size.width / 3.3,
                          height: 55,
                          child: MaterialButton(
                            onPressed: () async {
                              String link = widget.tasksshow['referlink'];
                              String refertext = widget.tasksshow['refertext'];
                              Share.share('RealCash $refertext $link');
                            },
                            child: Text(
                              'Share',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            color: c1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
