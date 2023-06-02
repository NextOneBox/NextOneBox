import 'package:cashapp/AppScreens/tasksdetaile.dart';
import 'package:cashapp/slot/gamescreen.dart';
import 'package:confetti/confetti.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';
import '../ComonScreens/local_notification_service.dart';
import 'Superspin.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Screehome();
  }
}

var myname;
var tasklength;

class Screehome extends State<Home> {

  bool isLoaded = false;
  int _numRewardedLoadAttempts = 0;


  unityloadad() async {
    UnityAds.load(
        placementId: 'Rewarded_Android',
        onFailed: (placementId, error, message) =>
            showMessage(context, 'Failed to load ad.'));

    int getammount = 3;
    int clicks = adsbox!.get(5)['clicks'];
    int Ballance = localballance!.get(0);
    int newBall = (Ballance + getammount);

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {
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

        showWining(context, '');
      },
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }



  Color bgcolor = Colors.blueAccent;
  var txt = "home";
  var arrNames = lead?.values.toList().reversed.toList();
  var tasklist = tasks?.values.toList();
  var taskre = tasks?.values.toList().reversed.toList();
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
        placementId: 'Rewarded_Android',
        onFailed: (placementId, error, message) =>
            showMessage(context, 'Failed to load ad.'));
    Ceckinternet();

    controller.play();

    

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

  dynamic showboost = false;
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

  @override
  Widget build(BuildContext context) {
    if (EMPremium == 'true') {
      showboost = false;
    } else {
      showboost = true;
    }

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
        

          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GFListTile(
                    shadow: BoxShadow(offset: Offset.infinite),
                    color: SecondaryColor,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Wallet()),
                      );
                    },
                    icon: Icon(
                      LineIcons.wallet,
                      color: MainColor,
                      size: 30,
                    ),
                    padding: EdgeInsets.fromLTRB(15, 5, 1, 1),
                    avatar: GFAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        FontAwesomeIcons.userAstronaut,
                        color: Colors.red,
                      ),
                    ),
                    subTitleText: ' Check balance  ₹...',
                    titleText: ' ${name}',
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
                              color: SecondaryColor,
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Visibility(
                      visible: true,
                      child: InkWell(
                        onTap: () {
                          buyMessage(context, '');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Make your earning 10X \n😔₹500 ==> ₹10,000 😃'),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.green,
                              ),
                              child: Center(
                                  child: Text(
                                ' Boost ',
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
                      UnityAds.load(
                        placementId: 'Rewarded_Android',
                        onComplete: (placementId) =>
                            print('Load Complete $placementId'),
                        onFailed: (placementId, error, message) =>
                            print('Load Failed $placementId: $error $message'),
                      );
                      dynamic lastclick = adsbox!.get(7)['lastclick'];
                      DateTime presenttime = DateTime.now();
                      Duration difference = presenttime.difference(lastclick);
                      int clicks = adsbox!.get(5)['clicks'];
                      if (EMPremium == 'true') {
                        unityloadad();
                      } else {
                        if (clicks == 10) {
                          if (difference.inHours > 24) {
                            unityloadad();
                            adsbox!.put(5, {'clicks': 0});
                            adsbox!.put(7, {'lastclick': DateTime.now()});
                          } else {
                            buyMessage(context, '');
                          }
                        } else {
                          unityloadad();
                        }
                      }
                    },
                    child: Container(
                      width: 400,
                      height: 110,
                      color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/index.png',
                            width: 50,
                          ),
                          Text(
                            ' Watch Ad and Earn  \n',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              color: MainColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text(
                              ' Watch ',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SpinWheel()),
                      );
                    },
                    child: Container(
                      width: 400,
                      height: 110,
                      color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/spinwheel.jpg',
                            width: 70,
                          ),
                          Text(
                            ' Spin and Win  ',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              color: MainColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text(
                              ' Spin ',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
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
                              if (EMPremium == 'true') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SuperSpin()),
                                );
                              } else {
                                buyMessage(context, '');
                              }
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 100,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/congr.webp'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: MainColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameScreen()),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/Graphics/gfx-slot-machine.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                        border: Border.all(color: MainColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      margin: EdgeInsets.only(right: 40, left: 40),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Share tasks to Earn ',
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
                                    ' Earn ₹50,000 +',
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ),
                                IconButton(
                                  iconSize: 35,
                                  color: MainColor,
                                  icon: Icon(FontAwesomeIcons.chartSimple),
                                  onPressed: () {
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
                                      color: MainColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
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
                                        color: MainColor,
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
                                    ' Earn ₹20,0000  +',
                                    style: TextStyle(color: Colors.black),
                                  )),
                                ),
                                IconButton(
                                  color: MainColor,
                                  icon: Icon(Icons.credit_card),
                                  iconSize: 35,
                                  onPressed: () {
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
                                      color: MainColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
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
                                      ' Earn ₹10,0000 +',
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
                                        TextStyle(color: MainColor, fontSize: 15),
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
