import 'dart:ffi';
import 'package:earnmoney/screens/quiz.dart';
import 'package:earnmoney/screens/referandearn.dart';
import 'package:earnmoney/screens/spin.dart';
import 'package:earnmoney/screens/superspin.dart';
import 'package:earnmoney/screens/payment.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:unity_ads_plugin/unity_ads.dart';

import 'package:cc_avenue/cc_avenue.dart';
import 'package:workmanager/workmanager.dart';
import '../otherfiles/webpage.dart';
import '../otherfiles/widgets.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
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
  unityloadad() async {
    int getammount = 1;
    int clicks = adsbox!.get(5)['clicks'];
    int Ballance = localballance!.get(0);
    int newBall = (Ballance + getammount);
    localballance!.put(0, newBall);
    http.Response resp = await http.post(
        Uri.parse(
            'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
        body: {
          'email': email.toString(),
          'Ballance': getammount.toString(),
        });
    adsbox!.put(5, {'clicks': clicks + 1});
    adsbox!.put(7, {'lastclick': DateTime.now()});
    Timer(Duration(seconds: 1), () {
      setState(() {
        {
          showMessage(context, 'You have earned your reward');
        }
      });
    });

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) => print('Video Ad $placementId completed'),
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  void _handleMonthPaymentSuccess(PaymentSuccessResponse response) async {
    {
      showMessage(context, 'you are now premium user');
    }

    http.Response response = await http.post(

        // how to print current date in flutter
        Uri.parse('https://www.nextonebox.com/earnmoney/NotGetUrls/EMPremium'),
        body: {
          'email': email.toString(),
          'EMPremium': 'true',
        });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigation()),
    );
    Ontimecall();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    {
      showMessage(context, ' Payment failed');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    {
      showMessage(context, ' Some error happened');
    }
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
      gameId: '5180629',
    );
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
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) => print('Video Ad $placementId completed'),
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );

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

  prevusad() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: Center(
          child: Text(
            'Current \n *10 Watch ads per day \n *10 Spin&Win per day \n *10 days Task tracking \n * Withdraw within 3days    \n\n Pro just in 99₹\n *  30 Watch ads per day \n  *  30 Spin&Win per day \n  *  24hours Task tracking \n  *  Withdraw within 1 hours',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        keyboardAware: true,
        btnOkText: "Pay",
        title: 'Continue to pay ₹99 rupees',
        padding: const EdgeInsets.all(5.0),
        btnCancelOnPress: () {
          showMessage(context, 'You missed the big earning opportunity');
        },
        btnOkOnPress: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pay()),
          );
        }).show();
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await CcAvenue.cCAvenueInit(
          transUrl: 'https://test.ccavenue.com/transaction/initTrans',
          accessCode: 'AVMF51KD59BK66FMKB',
          amount: '99',
          cancelUrl: 'https://www.nextonebox.com/',
          currencyType: 'INR',
          merchantId: '2322778',
          orderId: '519',
          redirectUrl: 'https://www.nextonebox.com/',
          rsaKeyUrl: 'https://www.nextonebox.com/');
    } on PlatformException {
      print('PlatformException');
    }
  }

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
                  GFListTile(
                    shadow: BoxShadow(offset: Offset.infinite),
                    color: BackColor,
                    onTap: () {
                      SetAnalytic('AccSetting');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountSetting()),
                      );
                    },
                    padding: EdgeInsets.fromLTRB(15, 5, 1, 1),
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
                      shadow: BoxShadow(offset: Offset.infinite),
                      onTap: () {
                        SetAnalytic('Wallet');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Wallet()),
                        );
                      },
                      padding: EdgeInsets.all(10),
                      titleText: 'Current Ballance',
                      icon: Icon(
                        FontAwesomeIcons.wallet,
                        color: MainColor,
                        size: 30,
                      ),
                    ),
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
                                      ' Earn ${listTrandign?[index]['price']} ₹',
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Task(val: '')),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: PrColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: EdgeInsets.only(right: 40, left: 40),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Share tasks to Earn Unlimited ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.forward,
                            color: MainColor,
                          )
                        ],
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        prevusad();
                      });
                    },
                    child: Container(
                      width: 400,
                      height: 50,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Boost your earning 4x',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
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
                              ' Try now ',
                              style: TextStyle(color: Colors.white),
                            )),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                UnityAds.load(
                                  placementId: 'Rewarded_Android',
                                  onComplete: (placementId) =>
                                      print('Load Complete $placementId'),
                                  onFailed: (placementId, error, message) => print(
                                      'Load Failed $placementId: $error $message'),
                                );

                                dynamic lastclick = adsbox!.get(7)['lastclick'];
                                DateTime presenttime = DateTime.now();
                                Duration difference =
                                    presenttime.difference(lastclick);
                                int clicks = adsbox!.get(5)['clicks'];
                                if (EMPremium == 'true') {
                                  if (clicks == 30) {
                                    if (difference.inHours > 24) {
                                      unityloadad();
                                      adsbox!.put(5, {'clicks': 0});
                                      adsbox!.put(
                                          7, {'lastclick': DateTime.now()});
                                    } else {
                                      {
                                        showMessage(context,
                                            'Next spin available at : ${23 - difference.inHours} Hours ${difference.inMinutes - 60} Minutes');
                                      }
                                    }
                                  } else {
                                    unityloadad();
                                  }
                                } else {
                                  if (clicks == 10) {
                                    initPlatformState();
                                    if (difference.inHours > 24) {
                                      unityloadad();
                                      adsbox!.put(5, {'clicks': 0});
                                      adsbox!.put(
                                          7, {'lastclick': DateTime.now()});
                                    } else {
                                      {
                                        showMessage(context,
                                            'Next spin available at : ${23 - difference.inHours} Hours ${difference.inMinutes - 60} Minutes');
                                      }
                                    }
                                  } else {
                                    unityloadad();
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/index.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Card(
                                  color: Colors.transparent,
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
                                          ' Watch&Earn ',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SpinWheel()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/spinwheel.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Card(
                                  color: Colors.transparent,
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
                                          ' Spin Win',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SuperSpin()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/congr.webp'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Card(
                                color: Colors.transparent,
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
                                        'Super Spin',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ],
                                ),
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
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/brain.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Card(
                                color: Colors.transparent,
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
                                        ' Play quiz',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ],
                                ),
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
                      shadow: BoxShadow(offset: Offset.infinite),
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
