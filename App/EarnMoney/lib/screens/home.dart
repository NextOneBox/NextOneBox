import 'dart:ffi';
import 'package:earnmoney/screens/quiz.dart';
import 'package:earnmoney/screens/referandearn.dart';
import 'package:earnmoney/screens/spin.dart';
import 'package:http/http.dart' as http;
// import 'package:unity_ads_plugin/unity_ads.dart';
import 'package:workmanager/workmanager.dart';
import '../otherfiles/webpage.dart';
import '../otherfiles/widgets.dart';

// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Screehome();
  }
}

var myname;

var tasklength;


class Screehome extends State<Home> {


  BannerAd? _ad;
  bool isLoaded = false;
  int _numRewardedLoadAttempts = 0;
  RewardedAd? _rewardedAd;
  //this function is for load ad
  unityloadad(double getammount) async {
    int clicks = adsbox!.get(4)['clicks'];
    double Ballance = double.parse(localballance!.get(0));
    double newBall = (Ballance + getammount);
    localballance!.put(0, newBall);
    http.Response resp = await http.post(
        Uri.parse(
            'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
        body: {
          'email': email.toString(),
          'Ballance': getammount.toString(),
        });
    adsbox!.put(4, {'clicks': clicks + 1});
    adsbox!.put(3, {'lastclick': DateTime.now()});
    Timer(Duration(seconds: 2), () {
      setState(() {
        {
          showMessage(context, 'You have earned your reward');
        }
      });
    });
    // UnityAds.showVideoAd(
    //   placementId: 'Rewarded_Android',
    //   listener: (state, args) async {
    //     if (state == UnityAdState.complete) {
    //     } else if (state == UnityAdState.skipped) {
    //       print('User cancel video.');
    //     }
    //   },
    // );
  }

  // loadad() {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(seconds: 4),
  //       backgroundColor: Colors.transparent,
  //       content: Center(
  //           child: CircularProgressIndicator(
  //         color: Colors.white,
  //         backgroundColor: MainColor,
  //       ))));
  //   RewardedAd.load(
  //       adUnitId: 'ca-app-pub-6690747295108713/7663719675',
  //       request: AdRequest(),
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
  //         _rewardedAd = ad;
  //         _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
  //           int newBall = int.parse(localballance!.get(0)) + 1;
  //           _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
  //               onAdFailedToShowFullScreenContent: (ad, err) {
  //             unityloadad();
  //             ad.dispose();
  //           }, onAdDismissedFullScreenContent: (ad) {
  //             ad.dispose();
  //           });
  //           int clicks = adsbox!.get(4)['clicks'];
  //           localballance!.put(0, newBall);
  //           http.Response resp = await http.post(
  //               Uri.parse(
  //                   'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
  //               body: {
  //                 'email': email.toString(),
  //                 'Ballance': newBall.toString(),
  //               });
  //           adsbox!.put(4, {'clicks': clicks + 1});
  //           adsbox!.put(3, {'lastclick': DateTime.now()});
  //           {
  //             showMessage(context, 'You have earned your reward');
  //           }
  //           Timer(Duration(seconds: 40), () {
  //             setState(() {});
  //           });
  //         });
  //       }, onAdFailedToLoad: (LoadAdError error) {
  //         unityloadad();
  //       }));
  // }

  Color bgcolor = Colors.blueAccent;
  var txt = "home";
  var arrNames = lead?.values.toList().reversed.toList();
  var tasklist = tasks?.values.toList();
  var taskre = tasks?.values.toList().reversed.toList();

  @override
  void initState() {
    super.initState();

    // UnityAds.init(
    //   gameId: '5180629',
    // );

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
// TODO: Load a banner ad

//  Container(
//                     width: _ad!.size.width.toDouble(),
//                     height: _ad!.size.height.toDouble(),
//                     alignment: Alignment.center,
//                     child: AdWidget(ad: _ad!),
//                   ),

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {
          if (message.data['_id'] != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Task(),
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
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
        }
      },
    );
    Timer(Duration(seconds: 3), () {
      setState(() {
        print('intializing state');
        print(localballance!.get(0));
      });
    });
  }

  @override

  //final videourl = 'https://youtu.be/6stlCkUDG_s';
  //late YoutubePlayerController _controller;

  //@override
  //void initState() {
  //  final videoID = YoutubePlayer.convertUrlToId(videourl);
  //  _controller = YoutubePlayerController(
  //      initialVideoId: videoID!, flags: YoutubePlayerFlags(autoPlay: false));
  //  super.initState();
  //}

  var arrlength;
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
  dynamic listTrandign =
      task?.values.where((tet) => tet['favorite'] == 'yes').toList();
  @override
  Widget build(BuildContext context) {
    if (arrNames!.isEmpty) {
      arrlength = 1;
    } else {
      arrlength = arrNames?.length;
    }
    return Scaffold(
      body: FutureBuilder(
        initialData: {tasklength = 0, myname = 'Hi'},
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          tasklength = tasklist?.length;
          var showad;
          if (_ad == null) {
            showad = false;
          } else {
            showad = true;
          }

          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: Image.asset(
                              'assets/em.png',
                            ),
                          ),
                          Text(
                            'EarnMoney',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: 'RobotoMono'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                  // Padding(
                  //   padding: const EdgeInsets.all(10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Daily Rewards',
                  //         style: texSty,
                  //       ),
                  //       IconButton(
                  //         onPressed: () {
                  //           Workmanager().registerPeriodicTask(
                  //             "periodic-task-identifier",
                  //             "You daily reward is ready to claim.",
                  //             frequency: Duration(hours: 24),
                  //           );

                  //           dynamic dailygift = adsbox!.get(10)['dailygift'];
                  //           DateTime presenttime = DateTime.now();
                  //           Duration difference =
                  //               presenttime.difference(dailygift);
                  //           if (difference.inHours > 24) {
                  //             showDialog(
                  //                 context: context,
                  //                 builder: (context) {
                  //                   return Container(
                  //                     child: AlertDialog(
                  //                       actions: [
                  //                         SizedBox(height: 10),
                  //                         Center(
                  //                             child: Text('Congratulation..!',
                  //                                 style: TextStyle(
                  //                                     fontSize: 30,
                  //                                     fontWeight:
                  //                                         FontWeight.w300,
                  //                                     color: MainColor))),
                  //                         Center(
                  //                           child: Image(
                  //                               image: AssetImage(
                  //                                   'assets/giftopen.png')),
                  //                         ),
                  //                         Center(
                  //                           child: Text('You Win : 1₹',
                  //                               style: texSty),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 20,
                  //                         ),
                  //                         Center(
                  //                             child: MaterialButton(
                  //                                 onPressed: () async {
                  //                                   await adsbox!.put(10, {
                  //                                     'dailygift':
                  //                                         DateTime.now()
                  //                                   });
                  //                                 },
                  //                                 height: 50,
                  //                                 minWidth: 120,
                  //                                 color: MainColor,
                  //                                 shape: RoundedRectangleBorder(
                  //                                     borderRadius:
                  //                                         BorderRadius.circular(
                  //                                             50)),
                  //                                 child: TextButton(
                  //                                   onPressed: () {
                  //                                     Navigator.pop(context);
                  //                                     unityloadad(1);
                  //                                   },
                  //                                   child: Text('CLAIM',
                  //                                       style: TextStyle(
                  //                                           color:
                  //                                               Colors.white)),
                  //                                 ))),
                  //                         SizedBox(
                  //                           height: 10,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   );
                  //                 });
                  //           } else {
                  //             showDialog(
                  //                 context: context,
                  //                 builder: (context) {
                  //                   return Container(
                  //                     child: AlertDialog(
                  //                       actions: [
                  //                         SizedBox(height: 10),
                  //                         Center(
                  //                             child: Text(
                  //                                 'Claim your reward \nevery day and earn',
                  //                                 style: TextStyle(
                  //                                     color: Colors.green))),
                  //                         Center(
                  //                           child: Image(
                  //                               image: AssetImage(
                  //                                   'assets/giftclose.png')),
                  //                         ),
                  //                         Center(
                  //                           child: Text(
                  //                               'Time to open  ${24 - difference.inHours} Hours ${difference.inMinutes - 60} Minutes',
                  //                               style: TextStyle(
                  //                                   color: Colors.green)),
                  //                         ),
                  //                         SizedBox(
                  //                           height: 10,
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   );
                  //                 });
                  //           }
                  //         },
                  //         icon: Image.asset('assets/giftclose.png'),
                  //         iconSize: 50,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  GFListTile(
                    color: BackColor,
                    onTap: () {
                      SetAnalytic('AccSetting');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountSetting()),
                      );
                    },
                    padding: EdgeInsets.fromLTRB(20, 5, 1, 1),
                    avatar: GFAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        FontAwesomeIcons.userAstronaut,
                        color: MainColor,
                      ),
                    ),
                    subTitleText: 'Welcome back',
                    titleText: name,
                  ),
                  Container(
                    child: GFListTile(
                      onTap: () {
                        SetAnalytic('Wallet');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Wallet()),
                        );
                      },
                      padding: EdgeInsets.all(10),
                      titleText: 'Current Ballance',
                      subTitleText: '${localballance!.get(0)} Coins',
                      icon: Icon(
                        FontAwesomeIcons.wallet,
                        color: MainColor,
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: UseBorder,
                    margin: EdgeInsets.only(right: 40, left: 40),
                    child: Center(
                        child: Text(
                      'Share tasks with friends and family \nThey do task you earn',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: ListView.builder(
                        itemCount: listTrandign.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TasksDetails(
                                        task_name: listTrandign?[index])),
                              );
                            },
                            child: Card(
                              color: BackColor,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50),
                                    width: 100,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      ' Earn ${listTrandign?[index]['price']}',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://nextonebox.com/media/${listTrandign?[index]['image']}'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    listTrandign?[index]['name'],
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 110, 114, 116),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
                  // UnityBannerAd(
                  //   placementId: 'Banner_Android',
                  //   size: BannerSize.standard,
                  // ),
                  isLoaded
                      ? Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: AdWidget(ad: _ad!),
                        )
                      : const SizedBox(
                          height: 5,
                        ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          width: 500,
                          height: 100,
                          child: Image.asset(
                            'assets/comtask.png',
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              SetAnalytic('tasks');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Task(val: '')),
                              );

                              // dynamic lastclick = adsbox!.get(3)['lastclick'];
                              // DateTime presenttime = DateTime.now();
                              // Duration difference =
                              //     presenttime.difference(lastclick);
                              // int clicks = adsbox!.get(4)['clicks'];

                              // if (clicks == 20) {
                              //   if (difference.inHours > 3) {
                              //     loadad();
                              //     adsbox!.put(4, {'clicks': 0});
                              //     adsbox!.put(3, {'lastclick': DateTime.now()});
                              //   } else {
                              //     {
                              //       showMessage(context,
                              //           'You have exceed your ad limit. Please try after ${2 - difference.inHours} Hours ${60 - difference.inMinutes} Minutes');
                              //     }
                              //   }
                              // } else {
                              //   loadad();
                              // }
                            });
                          },
                          child: Card(
                              color: Color.fromARGB(255, 190, 211, 185),
                              margin: EdgeInsets.only(
                                left: 30,
                                right: 30,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Text(
                                    'Complete Task and earn',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: PrColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Icon(
                                    Icons.play_arrow,
                                    color: PrColor,
                                    size: 50,
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //     child: InkWell(
                  //   onTap: () {
                  //     SetAnalytic('tasks');
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Task(val: '')),
                  //     );
                  //   },
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     child: Column(
                  //       children: [
                  //         GFListTile(
                  //           padding: EdgeInsets.all(5),
                  //           margin: EdgeInsets.all(5),
                  //           avatar: Image.asset(
                  //               width: 50, height: 50, 'assets/comtask.png'),
                  //           titleText: 'Complete Task and earn',
                  //         ),
                  //         Container(
                  //           decoration: BoxDecoration(
                  //             color: MainColor,
                  //             border: Border.all(color: MainColor),
                  //             borderRadius:
                  //                 BorderRadius.all(Radius.circular(10)),
                  //           ),
                  //           height: 30,
                  //           margin: EdgeInsets.only(
                  //               left: 40, right: 40, bottom: 20),
                  //           child: Card(
                  //             elevation: 100,
                  //             color: MainColor,
                  //             child: Center(
                  //                 child: Text(
                  //               ' Check Now',
                  //               style: TextStyle(
                  //                   color: Colors.white,
                  //                   fontFamily: 'Roboto',
                  //                   fontWeight: FontWeight.bold),
                  //             )),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Referandearn()),
                              );
                            },
                            child: Card(
                              color: BackColor,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50),
                                    width: 100,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Refer & Earn',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  Image(
                                    width: 90,
                                    height: 90,
                                    image: AssetImage('assets/refercard.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var url = 'https://1174.set.qureka.com/intro';
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Quiz()),
                              // );
                            },
                            child: Card(
                              color: BackColor,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50),
                                    width: 100,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      ' Play quiz',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  Image(
                                    width: 90,
                                    height: 90,
                                    image: AssetImage('assets/brain.png'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      var url =
                          'https://play.google.com/store/apps/details?id=com.nextonebox.games';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(6),
                        height: 150,
                        child: Row(
                          children: [
                            Card(
                              color: BackColor,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 50),
                                    width: 100,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: MainColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Play games ',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  Image(
                                    width: 90,
                                    height: 90,
                                    image: AssetImage('assets/game.png'),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Quiz()),
                                );
                              },
                              child: InkWell(
                                onTap: () async {
                                  var url =
                                      'https://play.google.com/store/apps/details?id=com.nextonebox.nobs';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                child: Card(
                                  color: BackColor,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 50),
                                        width: 100,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: MainColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          ' Watch Reels',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                      Image(
                                        width: 90,
                                        height: 90,
                                        image: AssetImage('assets/reels.png'),
                                      ),
                                      Center(
                                          child: Text(
                                        'Watch reels and earn',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Container(
                  //     margin: EdgeInsets.all(6),
                  //     height: 150,
                  //     child: ListView.builder(
                  //       itemCount: 6,
                  //       scrollDirection: Axis.horizontal,
                  //       itemBuilder: (context, index) {
                  //         return InkWell(
                  //           onTap: () {
                  //             SetAnalytic('All');
                  //             Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => Task(val: '')),
                  //             );
                  //           },
                  //           child: SizedBox(
                  //             height: 180,
                  //             width: 170,
                  //             child: Card(
                  //               color: BackColor,
                  //               child: Column(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.spaceEvenly,
                  //                 children: [
                  //                   Container(
                  //                     margin: EdgeInsets.only(left: 50),
                  //                     width: 100,
                  //                     height: 25,
                  //                     decoration: BoxDecoration(
                  //                       color: MainColor,
                  //                       border: Border.all(color: PrColor),
                  //                       borderRadius: BorderRadius.all(
                  //                           Radius.circular(10)),
                  //                     ),
                  //                     child: Center(
                  //                         child: Text(
                  //                       ' Earn ${taskre?[index]['price']}',
                  //                       style: TextStyle(color: Colors.white),
                  //                     )),
                  //                   ),
                  //                   Container(
                  //                     width: 50,
                  //                     height: 50,
                  //                     decoration: BoxDecoration(
                  //                       image: DecorationImage(
                  //                         image: NetworkImage(
                  //                             'https://nextonebox.com/media/${taskre?[index]['image']}'),
                  //                         fit: BoxFit.fill,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     taskre?[index]['name'],
                  //                     style: TextStyle(
                  //                         color: Color.fromARGB(
                  //                             255, 110, 114, 116),
                  //                         fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     )),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Referandearn()),
                  //     );
                  //   },
                  //   child: Card(
                  //     margin: EdgeInsets.only(
                  //         left: 5, right: 5, top: 20, bottom: 30),
                  //     child: Container(
                  //       width: 400,
                  //       height: 150,
                  //       decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //           image: AssetImage('assets/referhome.png'),
                  //           fit: BoxFit.fitWidth,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      SetAnalytic('Demart');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Task(val: 'Demart')),
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 120,
                            width: 150,
                            decoration: UseBorder,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(right: 20, left: 10),
                                  child: Center(
                                      child: Text(
                                    ' Earn ₹50,000  +',
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ),
                                IconButton(
                                  iconSize: 35,
                                  color: MainColor,
                                  icon: Icon(FontAwesomeIcons.chartSimple),
                                  onPressed: () {
                                    SetAnalytic('Demart');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Task(val: 'Demart')),
                                    );
                                  },
                                ),
                                Text(
                                  'Demart Account',
                                  style: TextStyle(
                                      color: PrColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SetAnalytic('Saving');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Task(val: 'Saving')),
                              );
                            },
                            child: Container(
                              height: 120,
                              width: 150,
                              decoration: UseBorder,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 25,
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: Center(
                                        child: Text(
                                      ' Earn ₹80,000  +',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                  ),
                                  IconButton(
                                    color: MainColor,
                                    icon:
                                        Icon(FontAwesomeIcons.magnifyingGlass),
                                    iconSize: 35,
                                    onPressed: () {
                                      SetAnalytic('other');

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Task(val: 'Other')),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Many more',
                                    style: TextStyle(
                                        color: PrColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      SetAnalytic('credit');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Task(val: 'Credit')),
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: UseBorder,
                            height: 120,
                            width: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(right: 20, left: 10),
                                  child: Center(
                                      child: Text(
                                    ' Earn ₹20,000  +',
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ),
                                IconButton(
                                  color: MainColor,
                                  icon: Icon(Icons.credit_card),
                                  iconSize: 35,
                                  onPressed: () {
                                    SetAnalytic('Credit');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Task(
                                                val: 'Credit',
                                              )),
                                    );
                                  },
                                ),
                                Text(
                                  'Credit Cards',
                                  style: TextStyle(
                                      color: PrColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SetAnalytic('Coin');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Task(val: 'Coin')),
                              );
                            },
                            child: Container(
                              decoration: UseBorder,
                              height: 120,
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 25,
                                    margin:
                                        EdgeInsets.only(right: 20, left: 10),
                                    child: Center(
                                        child: Text(
                                      ' Earn ₹10,000  +',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                  ),
                                  IconButton(
                                    iconSize: 40,
                                    color: MainColor,
                                    icon: Icon(
                                      Icons.copyright_outlined,
                                    ),
                                    onPressed: () {
                                      SetAnalytic('Coin');

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Task(val: 'Coin')),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Crypto',
                                    style:
                                        TextStyle(color: PrColor, fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                      child: InkWell(
                    onTap: () {
                      SetAnalytic('ProfitLink');

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Web()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          GFListTile(
                            margin: EdgeInsets.all(10),
                            avatar: Image.asset(
                                width: 50, height: 50, 'assets/gi.png'),
                            titleText: 'Generate Profit Link ',
                            subTitleText:
                                'Past any product link from any eCommerce website and make it profitable and earn real cash money',
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: MainColor,
                              border: Border.all(color: MainColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 30,
                            margin: EdgeInsets.only(
                                left: 40, right: 40, bottom: 20),
                            child: Card(
                              elevation: 100,
                              color: MainColor,
                              child: Center(
                                  child: Text(
                                ' Generate  Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       int Ballance = int.parse(localballance!.get(0));
                  //       int a = 1;
                  //       int newBall = Ballance + a;
                  //       loadad();

                  //       // UnityAds.showVideoAd(
                  //       //   placementId: 'Rewarded_Android',
                  //       //   listener: (state, args) async {
                  //       //     if (state == UnityAdState.complete) {
                  //       //       {
                  //       //         showMessage(context, 'You have earned 1₹');
                  //       //       }
                  //       //       http.Response resp = await http.post(
                  //       //           Uri.parse(
                  //       //               'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
                  //       //           body: {
                  //       //             'email': email.toString(),
                  //       //             'Ballance': newBall.toString(),
                  //       //           });
                  //       //       Timer(Duration(seconds: 3), () {
                  //       //         setState(() {});
                  //       //       });
                  //       //     } else if (state == UnityAdState.skipped) {
                  //       //       print('User cancel video.');
                  //       //     }
                  //       //   },
                  //       // );

                  //       // FacebookRewardedVideoAd.loadRewardedVideoAd(
                  //       //   placementId: "VID_HD_16_9_15S_LINK#YOUR_PLACEMENT_ID",
                  //       //   listener: (result, value) async {
                  //       //     if (result == RewardedVideoAdResult.LOADED)
                  //       //       FacebookRewardedVideoAd.showRewardedVideoAd();
                  //       //     if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
                  //       //       http.Response response = await http.post(
                  //       //           Uri.parse(
                  //       //               'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
                  //       //           body: {
                  //       //             'email': email,
                  //       //             'Ballance': newBall.toString(),
                  //       //           });

                  //       //     Timer(Duration(seconds: 3), () {
                  //       //       {
                  //       //         showMessage(context, 'You have earned 1₹');
                  //       //       }
                  //       //     });
                  //       //   },
                  //       // );
                  //     });
                  //   },
                  //   child: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         dynamic lastclick = adsbox!.get(3)['lastclick'];
                  //         DateTime presenttime = DateTime.now();
                  //         Duration difference =
                  //             presenttime.difference(lastclick);
                  //         int clicks = adsbox!.get(4)['clicks'];
                  //         {
                  //           showMessage(context, clicks.toString());
                  //         }
                  //         if (clicks == 20) {
                  //           if (difference.inHours > 4) {
                  //             loadad();
                  //             adsbox!.put(4, {'clicks': 0});
                  //             adsbox!.put(3, {'lastclick': DateTime.now()});
                  //           } else {
                  //             {
                  //               showMessage(context,
                  //                   'You have exceed your ad limit. Please try after  ${2 - difference.inHours} Hours   ${60 - difference.inMinutes} Minutes');
                  //             }
                  //           }
                  //         } else {
                  //           loadad();
                  //         }

                  //         SetAnalytic('ProfitLink');!
                  //             .put(DateTime.now().toString(), 'Watch ad');
                  //       });
                  //     },
                  //     child: Container(
                  //       margin: EdgeInsets.all(10),
                  //       child: Column(
                  //         children: [
                  //           GFListTile(
                  //             margin: EdgeInsets.all(10),
                  //             avatar: Image.asset(
                  //                 width: 50, height: 50, 'assets/index.png'),
                  //             titleText: 'Watch And Earn',
                  //             subTitleText:
                  //                 'Watch Video ads and earn real cash money',
                  //           ),
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: MainColor,
                  //               border: Border.all(color: MainColor),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(10)),
                  //             ),
                  //             height: 30,
                  //             margin: EdgeInsets.only(
                  //                 left: 40, right: 40, bottom: 20),
                  //             child: Card(
                  //               elevation: 100,
                  //               color: MainColor,
                  //               child: Center(
                  //                   child: Text(
                  //                 ' Watch  Now',
                  //                 style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontFamily: 'Roboto',
                  //                     fontWeight: FontWeight.bold),
                  //               )),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // write heading in flutter
                  // rupee symbol
                  Center(
                      child: Text(
                    'Shop using this link and earn',
                    style: texSty,
                  )),
                  Center(
                      child: Text(
                    'On successfully product delivered',
                  )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 5),
                      height: 150,
                      child: ListView.builder(
                          itemCount: imagelist.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                SetAnalytic('Leads');

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
                                      SizedBox(
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
                                          Container(
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
                                            margin: EdgeInsets.all(10),
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: MainColor,
                                              border:
                                                  Border.all(color: MainColor),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '  10 \u20B9  ',
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

                  SizedBox(
                    height: 120,
                    child: GFListTile(
                      padding: EdgeInsets.fromLTRB(20, 40, 10, 10),
                      onTap: () async {
                        SetAnalytic('website');
                        String url = "https://www.nextonebox.com/";
                        var urllaunchable = await canLaunch(
                            url); //canLaunch is from url_launcher package
                        if (urllaunchable) {
                          await launch(
                              url); //launch is from url_launcher package to launch URL
                        } else {
                          print("URL can't be launched.");
                        }
                      },
                      avatar: GFAvatar(
                        size: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'assets/em.png',
                        ),
                      ),
                      subTitle: Text('       powerd by ',
                          style: TextStyle(
                              fontSize: 10,
                              color: PrColor,
                              fontFamily: 'RobotoMono')),
                      description: Text(
                        '     NextOneBox',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: PrColor,
                            fontFamily: 'RobotoMono'),
                      ),
                      title: Text(
                        '   EarnMoney',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: PrColor,
                            fontFamily: 'RobotoMono'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
// class Contact {
//   String name;
//   String email;
//   String phone;

//   Contact({required this.name, required this.email, required this.phone});

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//       'phone': phone,
//     };
//   }
// }
class Fruit {
  String displayName;
  String mobile;

  Fruit({required this.displayName, required this.mobile});

  Map<String, dynamic> toJson() {
    return {
      'name': displayName,
      'mobile': mobile,
    };
  }
}
