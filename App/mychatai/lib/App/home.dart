// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:MyChatAi/OtherFiles/history.dart';
import 'package:MyChatAi/OtherFiles/widgets.dart';
import 'package:MyChatAi/App/chat.dart';
import 'package:MyChatAi/App/voic.dart';
import 'package:http/http.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../OtherFiles/premium.dart';
import '../OtherFiles/widgets.dart' as widgets;

RewardedAd? _rewardedAd;
int _numRewardedLoadAttempts = 0;

runadd() {
  DateTime now = DateTime.now();
  final formattedDate = "${now.year}${now.month}${now.day}";
  if (int.parse(ChatAiPrem) < int.parse(formattedDate)) {
    dynamic i = adtime.get(1);
    if (i == 0) {
      adtime.put(1, 1);
    }
    if (i == 1) {
      adtime.put(1, 2);
    }
    if (i == 2) {
      adtime.put(1, 3);
    }
    if (i == 3) {
      adtime.put(1, 4);
    }
    if (i == 4) {
      adtime.put(1, 5);
    }
    if (i == 5) {
      adtime.put(1, 6);
    }
    if (i == 6) {
      adtime.put(1, 7);
    }
    if (i == 7) {
      adtime.put(1, 8);
    }
    if (i == 8) {
      adtime.put(1, 9);
    }
    if (i == 9) {
      adtime.put(1, 10);
    }
    if (i == 10) {
      adtime.put(1, 0);
      _showInterstitialAd();
    }
  }
}

InterstitialAd? _interstitialAd;
int _numInterstitialLoadAttempts = 0;
// unityloadad() async {
//   UnityAds.showVideoAd(
//     placementId: 'Rewarded_Android',
//     listener: (state, args) async {
//       if (state == UnityAdState.complete) {
//       } else if (state == UnityAdState.skipped) {}
//     },
//   );
// }

void _createInterstitialAd() {
  InterstitialAd.load(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3946644332709876/6248052800'
          : 'ca-app-pub-3946644332709876/6248052800',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
        },
      ));
}

void _showInterstitialAd() {
  if (_interstitialAd == null) {
    print('Warning: attempt to show interstitial before loaded.');
    return;
  }
  _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (InterstitialAd ad) =>
        print('ad onAdShowedFullScreenContent.'),
    onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print('$ad onAdDismissedFullScreenContent.');
      ad.dispose();
      _createInterstitialAd();
    },
    onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
      print('$ad onAdFailedToShowFullScreenContent: $error');
      ad.dispose();
      // unityloadad();
      _createInterstitialAd();
    },
  );
  _interstitialAd!.show();
  _interstitialAd = null;
}

dynamic newb = [
  {
    "image":
        "https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/weew.png?alt=media&token=b450409c-9c44-45da-9abb-028b16fe916d",
    "url": "https://play.google.com/store/apps/details?id=com.nextonebox.games",
    "name": "ChatGptAi"
  },
  {
    "image":
        "https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/we.jpg?alt=media&token=61201def-0dc3-4562-a5d0-0c7b949b9992",
    "url":
        "https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney",
    "name": "ChatGptAi"
  }
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //how to change widget after ever 10  seconds
  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  String? get url => null;
  BannerAd? _ad;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    // UnityAds.init(
    //   gameId: '5212950',
    // );

    BannerAd(
      adUnitId: 'ca-app-pub-3946644332709876/2184205785',
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
  }

  var iconclor = MainColor;
  var visi = false;
  @override
  Widget build(BuildContext context) {
    SendAllData();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GFListTile(
              color: BackColor,
              onTap: () {
                SetAnalytic('AccSetting');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSetting()),
                );
              },
              padding: EdgeInsets.fromLTRB(10, 1, 1, 1),
              avatar: GFAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  FontAwesomeIcons.userAstronaut,
                  color: Colors.green,
                ),
              ),
              subTitleText: 'Welcome back',
              titleText: widgets.name,
            ),
            Card(
              color: BackColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      SetAnalytic('Facebook');

                      var url = 'https://www.facebook.com/nextonebox';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      size: 20,
                      color: PrColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      SetAnalytic('Youtube');

                      var url = 'https://www.youtube.com/@nextonebox';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.youtube,
                      size: 20,
                      color: PrColor,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        SetAnalytic('nextonebox');

                        var url = 'https://www.nextonebox.com/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      icon: Image.asset(
                        'assets/next.png',
                        fit: BoxFit.fill,
                      )),
                  IconButton(
                    onPressed: () async {
                      SetAnalytic('instagram');

                      var url = 'https://www.instagram.com/nextonebox/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      size: 20,
                      color: PrColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.twitter,
                      size: 20,
                      color: PrColor,
                    ),
                    onPressed: () async {
                      SetAnalytic('twitter');

                      var url = 'https://twitter.com/NextOneBox';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            isLoaded
                ? Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: AdWidget(ad: _ad!),
                  )
                : const SizedBox(),
            Card(
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Text(
                            'We are Expert in',
                            style: TextStyle(
                                color: MainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            'Used Chat Gpt to assist',
                            style: TextStyle(color: MainColor, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.cast_for_education,
                          color: iconclor,
                        ),
                        Text(
                          '     Education',
                          style: texSty,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.sports_gymnastics,
                          color: iconclor,
                        ),
                        Text(
                          '     Personal Trainer',
                          style: texSty,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.travel_explore,
                          color: iconclor,
                        ),
                        Text(
                          '     Traveler',
                          style: texSty,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wb_incandescent_rounded,
                          color: iconclor,
                        ),
                        Text(
                          '     Many More',
                          style: texSty,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 1,
                    width: 300,
                    color: MainColor,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Use the Power of AI',
                              style: texSty,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              SetAnalytic('premium');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Premium()),
                              );
                            },
                            child: Card(
                              elevation: 10,
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(' Go Ad Free'),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoiceScreen()),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Talk with AI      ',
                                      style: texSty,
                                    ),
                                    Icon(
                                      Icons.mic,
                                      color: iconclor,
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
                                    builder: (context) => ChatPage()),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Chat with AI     ',
                                      style: texSty,
                                    ),
                                    Icon(
                                      Icons.message,
                                      color: iconclor,
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
                                    builder: (context) => History()),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      '     History      ',
                                      style: texSty,
                                    ),
                                    Icon(
                                      Icons.history_outlined,
                                      color: iconclor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(6),
                height: 80,
                child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        var url = newb[index]['url'];
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      child: Card(
                        color: BackColor,
                        child: Container(
                          width: 140,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${newb[index]['image']}'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Text('Ai tools'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                color: BackColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Content Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.copy.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/copyai.jpg')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'http://articoolo.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/articoolo.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.jasper.ai/?jredirect=true';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/jasper.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Image Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.midjourney.com';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/midjourney.jpeg')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://deepai.org/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/deepai.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.shutterstock.com/generate';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/shutter.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Video Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.steve.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/steveai.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://lumen5.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/lumes.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://animoto.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/animoto.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Audio Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.shutterstock.com/discover/ampermusic?ref=Welcome.AI';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/shutter.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://mubert.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/mubert.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.aiva.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/oiva.png')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
