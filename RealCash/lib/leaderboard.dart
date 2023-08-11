import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test1/welcome.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'Colors.dart';


import 'Widget.dart';

class LeaderBoard extends StatefulWidget {
  LeaderBoard({super.key});

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

var leadshow = tasks?.values.toList();

class _LeaderBoardState extends State<LeaderBoard> {

  @override
  initState() {
    super.initState();
    UnityAds.init(
      gameId: '5366239',
    );
  }

  DateTime pre_backpress = DateTime.now();

  getleaderb() async {
    http.Response getleaderbord =
        await http.get(Uri.parse('https://realcash.nextonebox.com/LeaderBoardReq'));
    if (getleaderbord.reasonPhrase == 'OK') {
      await leaderboa!.clear();
      var da = jsonDecode(getleaderbord.body);
      for (var a in da) {
        await leaderboa!.add(a);
      }
    }
  }

  var leadbordshow = leaderboa?.values.toList();

  @override
  Widget build(BuildContext context) {
    getleaderb();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: BackButton(color: c3),
        title: Text(
          'LeaderBoard',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: white,
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: leadshow!.length,
                      itemBuilder: (context, index) {
                        // !Designing Strated here---------------------

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 5),
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // ! Image-------------------------------
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2.0),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50),
                                                bottomLeft:
                                                    Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              )),
                                          width: 50,
                                          height: 50,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100)),
                                              child: Image.network(
                                                  leadbordshow![index]
                                                      ['image'])),
                                        ),
                                        sdw(10),
                                        // ! Name--------------------------------------
                                        Text(
                                          leadbordshow![index]['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    // ! Price--------------------------------------
                                    Row(
                                      children: [
                                        Text('Earned'),
                                        Icon(
                                          Icons.currency_rupee_outlined,
                                          color: Color.fromARGB(
                                              255, 44, 160, 48),
                                        ),
                                        Text(
                                          leadbordshow![index]['price']
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            )),
      ),
    );
  }
}

// ! Sizebox------------------------------------------
Widget sdh(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sdw(double width) {
  return SizedBox(
    width: width,
  );
}
