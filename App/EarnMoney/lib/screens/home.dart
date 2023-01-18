import 'dart:ffi';

import 'package:earnmoney/screens/referandearn.dart';

import 'package:http/http.dart' as http;
import 'package:unity_ads_plugin/unity_ads.dart';
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

  unityloadad() {
    int clicks = adsbox!.get(4)['clicks'];
    int Ballance = int.parse(user.get(0)['Ballance']);
    int a = 1;
    int newBall = Ballance + a;
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      listener: (state, args) async {
        if (state == UnityAdState.complete) {
          http.Response resp = await http.post(
              Uri.parse(
                  'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallance'),
              body: {
                'email': email.toString(),
                'Ballance': newBall.toString(),
              });
          adsbox!.put(4, {'clicks': clicks + 1});
          adsbox!.put(3, {'lastclick': DateTime.now()});
          Timer(Duration(seconds: 3), () {
            setState(() {
              {
                showMessage(context,
                    'You have earned 1₹ \n It takes time to update ballance');
              }
            });
          });
        } else if (state == UnityAdState.skipped) {
          print('User cancel video.');
        }
      },
    );
  }

  loadad() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 4),
        backgroundColor: Colors.transparent,
        content: Center(
            child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: MainColor,
        ))));
    RewardedAd.load(
        adUnitId: 'ca-app-pub-6690747295108713/7663719675',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          _rewardedAd = ad;
          _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
            int newBall = int.parse(user.get(0)['Ballance']) + 1;
            _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
                onAdFailedToShowFullScreenContent: (ad, err) {
              unityloadad();
              ad.dispose();
            }, onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
            });
            int clicks = adsbox!.get(4)['clicks'];
            http.Response resp = await http.post(
                Uri.parse(
                    'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallance'),
                body: {
                  'email': email.toString(),
                  'Ballance': newBall.toString(),
                });
            adsbox!.put(4, {'clicks': clicks + 1});
            adsbox!.put(3, {'lastclick': DateTime.now()});
            {
              showMessage(context,
                  'You have earned 1₹ \n It takes time to update ballance');
            }
            Timer(Duration(seconds: 40), () {
              setState(() {});
            });
          });
        }, onAdFailedToLoad: (LoadAdError error) {
          unityloadad();
        }));
  }

  Color bgcolor = Colors.blueAccent;
  var txt = "home";
  var arrNames = lead?.values.toList().reversed.toList();
  var tasklist = tasks?.values.toList();
  var taskre = tasks?.values.toList().reversed.toList();

  @override
  void initState() {
    super.initState();
    UnityAds.init(
      gameId: '5107227',
    );

    BannerAd(
      adUnitId: 'ca-app-pub-6690747295108713/1024392773',
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

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppEarnMoneyAccount?${email}',
        user);
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
        print(user.get(0)['Ballance']);
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
        // future: GetRequest(
        //     'https://www.nextonebox.com/earnmoney/NotGetUrls/AppEarnMoneyAccount?${email}',
        //     user),
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gift Box  ',
                          style: texSty,
                        ),
                        Text('Get upto ₹500    '),
                        IconButton(
                          onPressed: () {
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
                                      "Claim",
                                      style: texSty,
                                    ),
                                    content: Text(
                                      "Claim your reward every day",
                                      style: texSty,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                      
                                        
                                          
                                      
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
                          icon: Icon(
                            FontAwesomeIcons.gift,
                            size: 35,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                  GFListTile(
                    color: BackColor,
                    onTap: () {
                      MyAnalytic!.put(DateTime.now().toString(), 'AccSetting');
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
                        MyAnalytic!.put(DateTime.now().toString(), 'Wallet');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Wallet()),
                        );
                      },
                      padding: EdgeInsets.all(10),
                      titleText: 'Current Ballance',
                      subTitleText: '${user.get(0)['Ballance']}.0',
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
                      '25 tasks * 10 friends it become 50,000₹ \n Earn more with more shares No limit',
                      style: TextStyle(color: Colors.black),
                    )),
                  ),
                  Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: ListView.builder(
                        itemCount: 9,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              MyAnalytic!.put(DateTime.now().toString(), 'All');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Task(val: '')),
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
                                      ' Earn ₹${tasklist?[index]['price']}',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://nextonebox.com/media/${tasklist?[index]['image']}'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    tasklist?[index]['name'],
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
                  isLoaded
                      ? Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: AdWidget(ad: _ad!),
                        )
                      : const SizedBox(
                          height: 20,
                        ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GFListTile(
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            size: 40.0,
                            Icons.card_giftcard_sharp,
                            color: MainColor,
                          ),
                          titleText: '     Watch Video And Earn',
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              dynamic lastclick = adsbox!.get(3)['lastclick'];
                              DateTime presenttime = DateTime.now();
                              Duration difference =
                                  presenttime.difference(lastclick);
                              int clicks = adsbox!.get(4)['clicks'];

                              if (clicks == 20) {
                                if (difference.inHours > 3) {
                                  loadad();
                                  adsbox!.put(4, {'clicks': 0});
                                  adsbox!.put(3, {'lastclick': DateTime.now()});
                                } else {
                                  {
                                    showMessage(context,
                                        'You have exceed your ad limit. Please try after ${2 - difference.inHours} Hours ${60 - difference.inMinutes} Minutes');
                                  }
                                }
                              } else {
                                loadad();
                              }

                              MyAnalytic!
                                  .put(DateTime.now().toString(), 'Watch ad');
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
                                    'Watch ad',
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
                  Container(
                      child: InkWell(
                    onTap: () {
                      MyAnalytic!.put(DateTime.now().toString(), 'tasks');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Task(val: '')),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          GFListTile(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(5),
                            avatar: Image.asset(
                                width: 50, height: 50, 'assets/comtask.png'),
                            titleText: 'Complete Task and earn',
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
                                ' Check Now',
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: Row(
                        children: [
                          Card(
                            color: BackColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  image: AssetImage('assets/po.png'),
                                  width: 50,
                                  height: 50,
                                ),
                                Text(
                                  'Share and earn ₹100',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 110, 114, 116),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: BackColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          'https://nextonebox.com/media'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Complete quiz an earn',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 110, 114, 116),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    height: 120,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebPage(
                                              data: 'https://poki.com/',
                                            )),
                                  );
                                },
                                icon: Icon(
                                  FontAwesomeIcons.gamepad,
                                  size: 50,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  'Play games ',
                                  style: texSty,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebPage(
                                              data: 'https://share.myjosh.in/',
                                            )),
                                  );
                                },
                                icon: Icon(
                                  Icons.app_shortcut_sharp,
                                  size: 50,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Watch reels',
                                  style: texSty,
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: UseBorder,
                    child: GFListTile(
                      onTap: () {
                        MyAnalytic!.put(DateTime.now().toString(), 'Explore');

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Explore()),
                        );
                      },
                      listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                      avatar: Icon(
                        FontAwesomeIcons.magnifyingGlassChart,
                        color: MainColor,
                      ),
                      titleText: '         Explore',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GFListTile(
                          listItemTextColor: Color.fromARGB(255, 119, 121, 123),
                          avatar: Icon(
                            FontAwesomeIcons.moneyBillTrendUp,
                            color: MainColor,
                            size: 35,
                          ),
                          titleText:
                              '     Create Profit Link \n       And Earn Cash ',
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Web()),
                            );
                          },
                          child: Card(
                              color: Color.fromARGB(255, 190, 211, 185),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                      child: Text(
                                    'Create Profit Link',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: PrColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  IconButton(
                                      onPressed: () {
                                        MyAnalytic!.put(
                                            DateTime.now().toString(),
                                            'ProfitLink');

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Web()),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.navigate_next_outlined,
                                        color: MainColor,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              MyAnalytic!.put(DateTime.now().toString(), 'All');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Task(val: '')),
                              );
                            },
                            child: SizedBox(
                              height: 180,
                              width: 170,
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
                                        border: Border.all(color: PrColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        ' Earn ₹${taskre?[index]['price']}',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://nextonebox.com/media/${taskre?[index]['image']}'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      taskre?[index]['name'],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 110, 114, 116),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Referandearn()),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(
                          left: 5, right: 5, top: 20, bottom: 30),
                      child: Container(
                        width: 400,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/re.PNG'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      MyAnalytic!.put(DateTime.now().toString(), 'Demart');
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
                                    MyAnalytic!.put(
                                        DateTime.now().toString(), 'Demart');

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
                              MyAnalytic!
                                  .put(DateTime.now().toString(), 'Saving');
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
                                      ' Earn ₹30,000  +',
                                      style: TextStyle(color: Colors.black),
                                    )),
                                  ),
                                  IconButton(
                                    color: MainColor,
                                    icon:
                                        Icon(FontAwesomeIcons.buildingColumns),
                                    iconSize: 35,
                                    onPressed: () {
                                      MyAnalytic!.put(
                                          DateTime.now().toString(), 'loan');

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Task(val: 'Loan')),
                                      );
                                    },
                                  ),
                                  Text(
                                    'Personal Loan',
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
                      MyAnalytic!.put(DateTime.now().toString(), 'credit');
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
                                    MyAnalytic!.put(
                                        DateTime.now().toString(), 'credit');
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
                              MyAnalytic!
                                  .put(DateTime.now().toString(), 'coin');
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
                                      MyAnalytic!.put(
                                          DateTime.now().toString(), 'coin');
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
                  InkWell(
                    onTap: () {
                      MyAnalytic!.put(DateTime.now().toString(), 'ohter');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Task(val: 'Other')),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      decoration: UseBorder,
                      height: 120,
                      width: 320,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                iconSize: 40,
                                color: MainColor,
                                icon: Icon(
                                  Icons.all_inbox,
                                ),
                                onPressed: () {
                                  MyAnalytic!
                                      .put(DateTime.now().toString(), 'other');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Task(val: 'Other')),
                                  );
                                },
                              ),
                              Text(
                                'Easy Tasks',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: UseBorder,
                            margin: EdgeInsets.only(right: 40, left: 40),
                            child: Center(
                                child: Text(
                              ' Earn more then  ₹10,000',
                              style: TextStyle(color: Colors.black),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      child: InkWell(
                    onTap: () {
                      MyAnalytic!.put(DateTime.now().toString(), 'profit link');
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        int Ballance = int.parse(user.get(0)['Ballance']);
                        int a = 1;
                        int newBall = Ballance + a;
                        loadad();

                        // UnityAds.showVideoAd(
                        //   placementId: 'Rewarded_Android',
                        //   listener: (state, args) async {
                        //     if (state == UnityAdState.complete) {
                        //       {
                        //         showMessage(context, 'You have earned 1₹');
                        //       }
                        //       http.Response resp = await http.post(
                        //           Uri.parse(
                        //               'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallance'),
                        //           body: {
                        //             'email': email.toString(),
                        //             'Ballance': newBall.toString(),
                        //           });
                        //       Timer(Duration(seconds: 3), () {
                        //         setState(() {});
                        //       });
                        //     } else if (state == UnityAdState.skipped) {
                        //       print('User cancel video.');
                        //     }
                        //   },
                        // );

                        // FacebookRewardedVideoAd.loadRewardedVideoAd(
                        //   placementId: "VID_HD_16_9_15S_LINK#YOUR_PLACEMENT_ID",
                        //   listener: (result, value) async {
                        //     if (result == RewardedVideoAdResult.LOADED)
                        //       FacebookRewardedVideoAd.showRewardedVideoAd();
                        //     if (result == RewardedVideoAdResult.VIDEO_COMPLETE)
                        //       http.Response response = await http.post(
                        //           Uri.parse(
                        //               'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallance'),
                        //           body: {
                        //             'email': email,
                        //             'Ballance': newBall.toString(),
                        //           });

                        //     Timer(Duration(seconds: 3), () {
                        //       {
                        //         showMessage(context, 'You have earned 1₹');
                        //       }
                        //     });
                        //   },
                        // );
                      });
                    },
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dynamic lastclick = adsbox!.get(3)['lastclick'];
                          DateTime presenttime = DateTime.now();
                          Duration difference =
                              presenttime.difference(lastclick);
                          int clicks = adsbox!.get(4)['clicks'];
                          {
                            showMessage(context, clicks.toString());
                          }
                          if (clicks == 20) {
                            if (difference.inHours > 4) {
                              loadad();
                              adsbox!.put(4, {'clicks': 0});
                              adsbox!.put(3, {'lastclick': DateTime.now()});
                            } else {
                              {
                                showMessage(context,
                                    'You have exceed your ad limit. Please try after  ${2 - difference.inHours} Hours   ${60 - difference.inMinutes} Minutes');
                              }
                            }
                          } else {
                            loadad();
                          }

                          MyAnalytic!
                              .put(DateTime.now().toString(), 'Watch ad');
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            GFListTile(
                              margin: EdgeInsets.all(10),
                              avatar: Image.asset(
                                  width: 50, height: 50, 'assets/index.png'),
                              titleText: 'Watch And Earn',
                              subTitleText:
                                  'Watch Video ads and earn real cash money',
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
                                  ' Watch  Now',
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
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 5),
                      height: 150,
                      child: ListView.builder(
                        itemCount: arrlength,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (arrlength == 1) {
                            return Card(
                              color: BackColor,
                              child: Container(
                                width: 500,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/baan.png'),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'leads');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Leadsadded()),
                                );
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
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://nextonebox.com/media/${arrNames?[index]['image']}'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            child: Center(
                                              child: Text(
                                                ' Status',
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
                                                '  ${arrNames?[index]['status']}  ',
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
                          }
                        },
                      )),
                  SizedBox(
                    height: 120,
                    child: GFListTile(
                      padding: EdgeInsets.fromLTRB(20, 40, 10, 10),
                      onTap: () async {
                        MyAnalytic!.put(DateTime.now().toString(), 'website');
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
