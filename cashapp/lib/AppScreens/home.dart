// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:cashapp/AppScreens/course.dart';
import 'package:cashapp/AppScreens/proScreens/mistryearn.dart';
import 'package:cashapp/AppScreens/proScreens/scrachcard.dart';
import 'package:cashapp/AppScreens/tasksdetaile.dart';
import 'package:cashapp/ComonScreens/sharnow.dart';

import 'package:confetti/confetti.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';
import '../ComonScreens/local_notification_service.dart';
import 'package:flutter/material.dart';

import 'dailyreward.dart';
import 'proScreens/luckeyspin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return Screehome();
  }
}

class Screehome extends State<Home> {
  bool isLoaded = false;
  final int _numRewardedLoadAttempts = 0;

  unityloadad() async {
    UnityAds.load(
      placementId: 'Rewarded_Android',
    );

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) async {
        http.Response response = await http.put(
            Uri.parse('https://fogcash.nextonebox.com/UpdateBallance'),
            body: {
              'Email': email.toString(),
              'Ballance': 5.toString(),
            });

        localballance!.put(0, localballance!.get(0) + 5);

        adsbox!.put(11, {'WatchCount': -1});
        adsbox!.put(12, {'WatchLastClickOn': DateTime.now()});

        setState(() {
          showWining(context, '');
        });
      },
    );
  }

  Color bgcolor = Colors.blueAccent;
  var txt = "home";

  var tasklist = task?.values.toList();
  var taskre = task?.values.toList().reversed.toList();
  final controller = ConfettiController();

  Ceckinternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(context, 'Please check your internet connection');
    }
  }

  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: '5278155',
    );
    UnityAds.load(
      placementId: 'Interstitial_Android',
    );
    UnityAds.load(
      placementId: 'Rewarded_Android',
    );
    Ceckinternet();

    controller.play();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Task(),
              ),
            );
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.notification != null) {}
      },
    );
  }

  List imagelist = [
    'https://asset20.ckassets.com/resources/image/stores/flipkart.png',
    'https://asset20.ckassets.com/resources/image/stores/amazon-store-exclusive-1602774183.png',
    'https://asset20.ckassets.com/resources/image/stores/myntra-1614060175.png',
    'https://asset20.ckassets.com/resources/image/stores/boat-store-1607926097.png',
    'https://asset20.ckassets.com/resources/image/stores/mama-earth-coupons-1561467924.png',
    'https://asset20.ckassets.com/resources/image/stores/nykaabeauty-1658489934.jpg'
  ];
  List linklist = [
    'https://ekaro.in/enkr20230301s21885146',
    'https://amzn.to/3kChPbP',
    'https://ekaro.in/enkr20230301s21885250',
    'https://ekaro.in/enkr20230301s21885277',
    'https://ekaro.in/enkr20230301s21885315',
    'https://ekaro.in/enkr20230301s21885399'
  ];
    List dailylist = [
'1','2','3','4','5','6','7','8','9','0'
  ];
  dynamic listTrandign =
      task?.values.where((tet) => tet['favorite'] == 'yes').toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 253, 253),
      body: FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GFListTile(
                      shadow: const BoxShadow(offset: Offset.infinite),
                      color: Colors.white60,
                      onTap: () {
                        SendAllData();
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Wallet()),
                        );
                        UnityAds.load(
                          placementId: 'Interstitial_Android',
                        );
                        UnityAds.showVideoAd(
                            placementId: 'Interstitial_Android');
                      },
                      icon: TextButton.icon(
                          onPressed: () {
                            unityloadad();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Wallet()),
                            );
                          },
                          icon: Icon(Icons.currency_rupee),
                          label: Text(
                            '${localballance!.get(0) / 10}',
                            style: TextStyle(fontSize: 30),
                          )),
                      padding: const EdgeInsets.fromLTRB(15, 5, 1, 1),
                      avatar: const GFAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(
                          FontAwesomeIcons.userAstronaut,
                          color: Colors.red,
                        ),
                      ),
                      titleText: user.get(0)['Name']),
                 
                  Container(
                     
                      height: 60,
                      child: ListView.builder(
                          itemCount: dailylist.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                    
                            return InkWell(
                              onTap: () async {
                                {
          showMessage(context, 'Use app for 20 days to unlock\nStart claiming daily reward from Day 21');
        }
                              },
                              child: Container(
                    width: 60,
                    height: 60,
                    child: Card(
                      child: Center(child: Text('Day 2${dailylist[index]}\n₹1${dailylist[index]}' )),
                    ),
                  ),
                            );
                          })),
                  Container(
                    height: 150,
                    color: SecondaryColor,
                    child: ListView.builder(
                        itemCount: listTrandign?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              var taskName = listTrandign?[index];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TasksDetails(task_name: taskName)),
                              );
                              UnityAds.load(
                                placementId: 'Interstitial_Android',
                              );
                              UnityAds.showVideoAd(
                                  placementId: 'Interstitial_Android');
                            },
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://nextonebox.com/media/${listTrandign?[index]['image']}'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 80,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              listTrandign?[index]['name'],
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 16, 16, 16),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              listTrandign?[index]
                                                  ['description'],
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 110, 114, 116),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 100,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                        color: MainColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        ' Earn ₹ ${newb?[index]['price']} ',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(6),
                          height: 120,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SpinWheel()),
                              );
                              UnityAds.load(
                                placementId: 'Interstitial_Android',
                              );
                              UnityAds.showVideoAd(
                                  placementId: 'Interstitial_Android');
                            },
                            child: Card(
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/spin.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Spin & Win',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 110, 114, 116),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      ' Spin now',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.all(6),
                          height: 120,
                          child: InkWell(
                            onTap: () {
                              UnityAds.load(placementId: 'Rewarded_Android');
                              if (user.get(0)['Pro'] == 'true') {
                                unityloadad();
                              } else {
                                int clicks = adsbox!.get(11)['WatchCount'];
                                dynamic lastclick =
                                    adsbox!.get(12)['WatchLastClickOn'];
                                DateTime presenttime = DateTime.now();
                                Duration difference =
                                    presenttime.difference(lastclick);

                                if (clicks <= 0) {
                                  if (difference.inHours > 24) {
                                    unityloadad();
                                    adsbox!.put(11, {'WatchCount': 8});
                                    adsbox!.put(12,
                                        {'WatchLastClickOn': DateTime.now()});
                                  } else {
                                    buyMessage(context, '');
                                  }
                                } else {
                                  unityloadad();
                                }
                              }
                            },
                            child: Card(
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/watch.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Watch ad & Earn',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 110, 114, 116),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 150,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      ' Earn now',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          UnityAds.load(
                            placementId: 'Interstitial_Android',
                          );
                          UnityAds.showVideoAd(
                              placementId: 'Interstitial_Android');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuperSpin()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 14,
                                ),
                                Text(' Jack Pot',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                        image: AssetImage(
                                            'assets/superspin.png'))),
                                Text('Earn Upto ₹1000 daily',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          UnityAds.load(
                            placementId: 'Interstitial_Android',
                          );
                          UnityAds.showVideoAd(
                              placementId: 'Interstitial_Android');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LuckeySpin()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 14,
                                ),
                                Text('Luckey Spin',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 20),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                        image: AssetImage('assets/spw.png'))),
                                Text('Earn Upto ₹5000 daily',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

//Second spin start

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (user.get(0)['MystryScrach'] == 'true') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MysteryScrach()),
                            );
                          } else {
                            UnityAds.load(
                              placementId: 'Interstitial_Android',
                            );
                            UnityAds.showVideoAd(
                                placementId: 'Interstitial_Android');

                            setState(() {});
                            MystryMessage(context, '');
                          }
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 14,
                                ),
                                Text(' Mystery Scrach',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 18,
                                ),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                        image: AssetImage(
                                            'assets/Graphics/gfx-casino-chips.png'))),
                                Text('Earn Upto ₹500 daily',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          unityloadad();
                          setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScrachCard()),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.2,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 14,
                                ),
                                Text('Scrach Card',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 20),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                      image: AssetImage('assets/scrach.png'),
                                      fit: BoxFit.cover,
                                    )),
                                Text('Earn Upto ₹500',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 5),
                      height: 150,
                      child: ListView.builder(
                          itemCount: imagelist.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                String url = linklist[index];
                                var urllaunchable = await canLaunch(url);
                                if (urllaunchable) {
                                  await launch(url);
                                }
                              },
                              child: SizedBox(
                                height: 180,
                                width: 170,
                                child: Card(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  '${imagelist[index]}'),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                '   PerOrder',
                                                style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    color: Color.fromARGB(
                                                        255, 110, 114, 116),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: MainColor,
                                              border:
                                                  Border.all(color: MainColor),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                '  ₹10  ',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ),
            ),
          );
        },
        future: null,
      ),
    );
  }
}
