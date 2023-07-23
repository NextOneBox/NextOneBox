// ignore_for_file: prefer_const_constructors

import 'package:chatai/App/chat.dart';
import 'package:http/http.dart' as http;
import '../OtherFiles/purchase.dart';
import '../OtherFiles/widgets.dart' as widgets;
import '../OtherFiles/widgets.dart';


RewardedAd? _rewardedAd;
int _numRewardedLoadAttempts = 0;

  unityloadad() async {
    UnityAds.load(
        placementId: 'Rewarded_Android',
      );



    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {
      
      },
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }



runadd() {
  // _showInterstitialAd();
  RewardedAd.load(
      adUnitId: 'ca-app-pub-7177495743199841/7118219640',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
              _rewardedAd?.fullScreenContentCallback =
                  FullScreenContentCallback(
                      onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              }, onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              });
            });
          },
          onAdFailedToLoad: (LoadAdError error) {}));
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
    // _createInterstitialAd();
    UnityAds.init(
      gameId: '5349140',
    );
    UnityAds.load(
        placementId: 'Rewarded_Android',
        onFailed: (placementId, error, message) =>
            showMessage(context, 'Failed to load ad.'));
    // BannerAd(
    //   adUnitId: 'ca-app-pub-7177495743199841/7198110692',
    //   size: AdSize.banner,
    //   request: AdRequest(),
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _ad = ad as BannerAd;
    //         isLoaded = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       // Releases an ad resource when it fails to load
    //       ad.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');
    //     },
    //   ),
    // ).load();
  }

  void main() async {
    final url = Uri.parse(
        'https://api.d-id.com/talks'); // Replace with the actual API endpoint URL

    final jsonBody = {
      'source_url':
          'https://create-images-results.d-id.com/api_docs/assets/noelle.jpeg',
      'script': {'type': 'text', 'input': 'Hello world!'}
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic c2hhaGlkbWlyOTY4MkBnbWFpbC5jb20:rYzVdT2aexjJoXlyHxgCy'
    };

    http
        .post(
      url,
      headers: headers,
      body: jsonEncode(jsonBody),
    )
        .then((response) async {
      if (response.statusCode == 201) {
        print(response.body);
        Map<String, dynamic> jsonObject = json.decode(response.body);
        String idValue = jsonObject['id'];
        print(idValue);
        final url = Uri.parse('https://api.d-id.com/talks/${idValue}');
        http.Response respoe = await http.post(
          url,
        );

        print(respoe.body);
      } else {
        print(response.body);
      }
    });
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
            widgets.Row(
              children: [
                widgets.Container(
                  width: 250,
                  child: GFListTile(
                    shadow: BoxShadow(offset: Offset.infinite),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountSetting()),
                      );
                    },
                    padding: EdgeInsets.fromLTRB(10, 1, 1, 1),
                    avatar: GFAvatar(
                      backgroundColor: Colors.black,
                      child: Icon(
                        FontAwesomeIcons.userAstronaut,
                        color: Colors.blueAccent,
                      ),
                    ),
                    subTitleText: 'Welcome back',
                    titleText: widgets.name,
                  ),
                ),
                InkWell(
                  onTap: () async {
                
             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Purchase()),
                              );
             
                    getkey();

               
                  },
                  child: Container(
                    width: 150,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                        child: Text(
                      ' ChatAi Pro',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
            widgets.Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: widgets.Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VoiceScreen()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: MainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage('assets/weqr.png'),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        ' Ai Voice ',
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
                                    builder: (context) => ImageGenerate()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage('assets/aiimage.jpg'),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        ' Ai Image ',
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
                    Container(
                      margin: EdgeInsets.all(6),
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage('assets/chat.png'),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        ' Ai Chat ',
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
                                    builder: (context) => History()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                  image: AssetImage('assets/weq.png'),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        ' History ',
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
                  ],
                ),
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
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: Text('MyChatAi'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: Text(' Powered by ChatGPT'),
                  ),
                ],
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
                          Text('Earning App :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://play.google.com/store/apps/details?id=com.nextonebox.cashapp';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/cashapp.png',
                                width: 30,
                              )),
                        ],
                      ),
                    ),
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
                              icon: Image.asset(
                                'assets/copyai.jpg',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'http://articoolo.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/articoolo.png',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              
                              onPressed: () async {
                                var url =
                                    'https://www.jasper.ai/?jredirect=true';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/jasper.png',
                                width: 30,
                              )),
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
                              icon: Image.asset(
                                'assets/midjourney.jpeg',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://deepai.org/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/deepai.png',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.shutterstock.com/generate';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/shutter.png',
                                width: 30,
                              )),
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
                              icon: Image.asset(
                                'assets/steveai.png',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://lumen5.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/lumes.png',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://animoto.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/animoto.png',
                                width: 30,
                              )),
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
                              icon: Image.asset(
                                'assets/shutter.png',
                                width: 30,
                              )),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.aiva.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset(
                                'assets/oiva.png',
                                width: 30,
                              )),
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
