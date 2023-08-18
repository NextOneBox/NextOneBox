import 'package:mugcash/AppScreens/proScreens/education.dart';
import 'package:mugcash/AppScreens/proScreens/scrachcard.dart';
import 'package:mugcash/AppScreens/tasksdetaile.dart';
import 'package:mugcash/ComonScreens/local_notification_service.dart';
import 'package:confetti/confetti.dart';
import 'package:http/http.dart' as http;
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'proScreens/luckeyspin.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return Screehome();
  }
}

var socialmedia = adsbox!.get(22)['teligram'];

class Screehome extends State<Home> {
  bool isLoaded = false;

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

        localballance!.put(0, localballance!.get(0) + 10);

        adsbox!.put(11, {'WatchCount': -1});
        adsbox!.put(12, {'WatchLastClickOn': DateTime.now()});

        setState(() {
          showMessage.show(
              context, 'You won your ₹1, it take time to update balance');
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
      showMessage.show(context, 'Please check your internet connection');
    }
  }

  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: '5278155',
    );

    UnityAds.load(
      placementId: 'Rewarded_Android',
    );
    Ceckinternet();

    controller.play();
    if (socialmedia == false) {
      print('object');
      Future.delayed(Duration(seconds: 2), () {
        QuickAlert.show(
          context: context,
          title: '✅Join Teligram \n ',
          type: QuickAlertType.confirm,
          text:
              'Get Daily Update In our Telegram channel join our Telegram family',
          confirmBtnText: ' Join now',
          onConfirmBtnTap: () async {
            Navigator.of(
              context,
            ).pop('dialog');
            setState(() {
              adsbox!.put(22, {'teligram': true});
            });

            String youtube = 'https://t.me/nextonebox';
            if (await canLaunch(youtube)) {
              await launch(youtube);
            } else {
              throw "Error occured trying to call that number.";
            }
          },
          cancelBtnText: 'Skip',
          onCancelBtnTap: () {
            Navigator.of(
              context,
            ).pop('dialog');
          },
          confirmBtnColor: Colors.green,
        );
      });
    }
    ;
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

  List dailylist = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
  dynamic listTrandign =
      task?.values.where((tet) => tet['favorite'] == 'yes').toList();

  @override
  Widget build(BuildContext context) {
    // if (adsbox!.get(22)['youtube'] != 'true') {
    //   QuickAlert.show(
    //     context: context,
    //     title: 'Subcribe our channel',
    //     type: QuickAlertType.confirm,
    //     text: 'Get latest updates',
    //     confirmBtnText: 'Sbuscribe',
    //     onConfirmBtnTap: () async {
    //       Navigator.of(
    //         context,
    //       ).pop('dialog');
    //       var url = "https://www.youtube.com/@nextonebox";
    //       if (await canLaunch(url)) {
    //         await launch(url);
    //       }
    //       adsbox!.put(22, {'youtube': 'false'});
    //     },
    //     cancelBtnText: 'later',
    //     onCancelBtnTap: () {
    //       Navigator.of(
    //         context,
    //       ).pop('dialog');
    //     },
    //     confirmBtnColor: Colors.green,
    //   );
    // }

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
                      shadow: BoxShadow(offset: Offset.infinite),
                      color: Colors.white60,
                      onTap: () {
                        setState(() {});
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Wallet()),
                        );
                        UnityAds.load(
                          placementId: 'Interstitial_Android',
                        );
                        UnityAds.showVideoAd(
                            placementId: 'Interstitial_Android');
                      },
                      icon: TextButton.icon(
                          onPressed: () {
                            setState(() {});
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Wallet()),
                            );
                            UnityAds.load(
                              placementId: 'Interstitial_Android',
                            );
                            UnityAds.showVideoAd(
                                placementId: 'Interstitial_Android');
                          },
                          icon: Icon(Icons.currency_rupee),
                          label: Text(
                            '${localballance!.get(0) / 10}',
                            style: TextStyle(fontSize: 30),
                          )),
                      padding: EdgeInsets.fromLTRB(15, 5, 1, 1),
                      avatar: GFAvatar(
                        shape: GFAvatarShape.circle,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 47,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(adsbox!.get(1000)['image']),
                            radius: 45,
                          ),
                        ),
                      ),
                      titleText: user.get(0)['Name']),

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
                                    width: 100,
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
                                    setState(() {});
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
                                    width: 100,
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
                      Container(
                          margin: const EdgeInsets.all(6),
                          height: 120,
                          child: InkWell(
                            onTap: () {
                              unityloadad();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScrachCard()),
                              );
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
                                        image: AssetImage('assets/scrach.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Scratch Card',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 110, 114, 116),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      ' Scratch now',
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
                  GestureDetector(
                    onTap: () {
                      UnityAds.load(
                        placementId: 'Interstitial_Android',
                      );
                      UnityAds.showVideoAd(placementId: 'Interstitial_Android');
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(adsbox!.get(1001)['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    vipMessage(context, '');
                                  },
                                  color: Colors.amber,
                                  elevation: 10,
                                  height: 40,
                                  minWidth: 100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text('💎 Vip',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    buyMessage(context, '');
                                  },
                                  color: Colors.amber,
                                  elevation: 10,
                                  height: 40,
                                  minWidth: 100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(' Upgrade',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              VideoPlayerPage()),
                                    );
                                  },
                                  color: Colors.amber,
                                  elevation: 10,
                                  height: 40,
                                  minWidth: 100,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text('How to Earn',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
                                Text(' Super Spin',
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
                                Text('Earn Upto ₹10000',
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
                                Text('✅ Luckey Spin',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(height: 20),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image(
                                        image: AssetImage('assets/spw.png'))),
                                Text('Earn Upto ₹30000 ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

//Second spin start

                  Container(
                      height: 60,
                      child: ListView.builder(
                          itemCount: dailylist.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                {
                                  showMessage.show(context,
                                      'Use app for 20 days to unlock\nStart claiming daily reward from Day 21');
                                }
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                child: Card(
                                  child: Center(
                                      child: Text(
                                    'Day 2${dailylist[index]}\n  ₹1${dailylist[index]}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color:
                                            Color.fromARGB(255, 110, 114, 116),
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              ),
                            );
                          })),
                  const SizedBox(
                    height: 20,
                  ),
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
