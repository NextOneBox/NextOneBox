import 'dart:io';
import 'package:nobs/wallet.dart';
import 'package:nobs/web.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unity_ads_plugin/unity_ads.dart';
import 'widgets.dart';
import 'dart:async';

import 'package:unity_ads_plugin/ad/unity_banner_ad.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

dynamic sizeboxsize = 20.0;
dynamic boxsize = 60.0;
dynamic texstyle = TextStyle(fontSize: 15, color: Colors.black87);

class _HomePageState extends State<HomePage> {
  BannerAd? _ad;
  bool isLoaded = false;

  int _numRewardedLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  bool _isInterstitialAdLoaded = false;
  @override
  void initState() {
    super.initState();
    UnityAds.init(
      gameId: '5149985',
    );
    // FacebookAudienceNetwork.init();
    BannerAd(
      adUnitId: 'ca-app-pub-3946644332709876/5656729747',
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

  unityloadad() async {
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      listener: (state, args) async {
        if (state == UnityAdState.complete) {
        } else if (state == UnityAdState.skipped) {}
      },
    );
  }
  // loadad() {
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       duration: Duration(seconds: 4),
  //       backgroundColor: Colors.transparent,
  //       content: Center(
  //           child: CircularProgressIndicator(
  //         color: Colors.white,
  //         backgroundColor: Colors.black,
  //       ))));
  //   RewardedAd.load(
  //       adUnitId: 'ca-app-pub-3946644332709876/6988340327',
  //       request: AdRequest(),
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //           onAdLoaded: (ad) {
  //             _rewardedAd = ad;
  //             _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
  //               _rewardedAd?.fullScreenContentCallback =
  //                   FullScreenContentCallback(
  //                       onAdFailedToShowFullScreenContent: (ad, err) {
  //                 ad.dispose();
  //               }, onAdDismissedFullScreenContent: (ad) {
  //                 ad.dispose();
  //               });
  //             });
  //           },
  //           onAdFailedToLoad: (LoadAdError error) {}));
  // }
  // rewardedload() {
  //   FacebookInterstitialAd.loadInterstitialAd(
  //     placementId:
  //         "VID_HD_9_16_39S_APP_INSTALL#603276158280415_604703744804323",
  //     listener: (result, value) {
  //       if (result == InterstitialAdResult.LOADED)
  //         FacebookInterstitialAd.showInterstitialAd();
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(minutes: 3), (timer) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Container(
              child: AlertDialog(
                actions: [
                  SizedBox(height: 10),
                  Center(
                      child: Text('Watch ad to continue',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.green))),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: MaterialButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            unityloadad();
                            int a = localballance!.get(0) ?? 0;
                            int b = 1;
                            localballance!.put(0, (a + b));
                          },
                          height: 50,
                          minWidth: 120,
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text('Watch',
                              style: TextStyle(color: Colors.white)))),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          });
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'NobShorts',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Image.asset('assets/wa.png'),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Wallet()),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              Column(
                children: [
                  isLoaded
                      ? Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: AdWidget(ad: _ad!),
                        )
                      : const SizedBox(
                          height: 20,
                        ),
                  // Container(
                  //   alignment: Alignment(0.5, 1),
                  //   child: FacebookBannerAd(
                  //     placementId:
                  //         'IMG_16_9_APP_INSTALL#603276158280415_604703814804316',
                  //     bannerSize: BannerSize.STANDARD,
                  //     listener: (result, value) {},
                  //   ),
                  // ),
                ],
              ),

              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Top Social Reels Websites',
                        style: texstyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://www.facebook.com/reel/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/facebook.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data:
                                        'https://www.instagram.com/reels/videos/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/instareels.jpeg',
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: sizeboxsize,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Videos platform',
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://www.youtube.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/youtube.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebPage(
                                  data: 'https://www.facebook.com/watch/')),
                        ),
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/facebook.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://www.twitch.tv/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/twitch.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://www.dailymotion.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/dailymotion.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: sizeboxsize,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Top Shorts Reels Apps ',
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://www.youtube.com/shorts/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/shorts.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WebPage(data: 'https://share.myjosh.in/')),
                        ),
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/josh.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://mojapp.in/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/moj.jpeg',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data:
                                        'https://www.hipi.co.in/feed/for-you')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/hipi.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // Container(
              //   alignment: Alignment(0.5, 1),
              //   child: FacebookBannerAd(
              //     placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
              //     bannerSize: BannerSize.STANDARD,
              //     listener: (result, value) {
              //       switch (result) {
              //         case BannerAdResult.ERROR:
              //           print("Error: $value");
              //           break;
              //         case BannerAdResult.LOADED:
              //           print("Loaded: $value");
              //           break;
              //         case BannerAdResult.CLICKED:
              //           print("Clicked: $value");
              //           break;
              //         case BannerAdResult.LOGGING_IMPRESSION:
              //           print("Logging Impression: $value");
              //           break;
              //       }
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
