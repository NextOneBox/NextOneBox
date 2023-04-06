// import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:audioplayers/audioplayers.dart';
// import '../otherfiles/widgets.dart';
// import 'package:http/http.dart' as http;

// class SpinWheel extends StatefulWidget {
//   SpinWheel({Key? key}) : super(key: key);

//   @override
//   State<SpinWheel> createState() => _SpinWheelState();
// }

// class _SpinWheelState extends State<SpinWheel> {
//   @override
//   void initState() {
//     super.initState();
//     UnityAds.init(
//       gameId: '5107227',
//     );
//     BannerAd(
//       adUnitId: 'ca-app-pub-3946644332709876/6246084818',
//       size: AdSize.banner,
//       request: AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (ad) {
//           setState(() {
//             _ad = ad as BannerAd;
//             isLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (ad, error) {
//           // Releases an ad resource when it fails to load
//           ad.dispose();
//           print('Ad load failed (code=${error.code} message=${error.message})');
//         },
//       ),
//     ).load();
//   }

//   BannerAd? _ad;
//   bool isLoaded = false;

//   int _numRewardedLoadAttempts = 0;

//   RewardedAd? _rewardedAd;
//   unityloadad(int getammount) async {
//     int clicks = adsbox!.get(4)['clicks'];
//     int Ballance = localballance!.get(0);
//     int newBall = (Ballance + getammount);
//     localballance!.put(0, newBall);
//     http.Response resp = await http.post(
//         Uri.parse(
//             'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
//         body: {
//           'email': email.toString(),
//           'Ballance': getammount.toString(),
//         });
//     adsbox!.put(4, {'clicks': clicks + 1});
//     adsbox!.put(3, {'lastclick': DateTime.now()});
//     Timer(Duration(seconds: 1), () {
//       setState(() {
//         {
//           showMessage(context, 'You have earned your reward');
//         }
//       });
//     });
//     UnityAds.showVideoAd(
//       placementId: 'Rewarded_Android',
//       listener: (state, args) async {
//         if (state == UnityAdState.complete) {}
//         if (state == UnityAdState.skipped) {
//           {
//             showMessage(context, 'You have canceled your reward');
//           }
//         }
//         if (state == UnityAdState.error) {
//           {
//             showMessage(context, 'Something went wrong. please try later');
//           }
//         }
//       },
//     );
//   }

//   // loadad(var getammount) {
//   //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //       duration: Duration(seconds: 4),
//   //       backgroundColor: Colors.transparent,
//   //       content: Center(
//   //           child: CircularProgressIndicator(
//   //         color: Colors.white,
//   //         backgroundColor: MainColor,
//   //       ))));
//   //   RewardedAd.load(
//   //       adUnitId: 'ca-app-pub-6690747295108713/7663719675',
//   //       request: AdRequest(),
//   //       rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
//   //         _rewardedAd = ad;
//   //         _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
//   //           int newBall = int.parse(localballance!.get(0)) + 1;
//   //           _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
//   //               onAdFailedToShowFullScreenContent: (ad, err) {
//   //             unityloadad();
//   //             ad.dispose();
//   //           }, onAdDismissedFullScreenContent: (ad) {
//   //             ad.dispose();
//   //           });
//   //           int clicks = adsbox!.get(4)['clicks'];
//   //           localballance!.put(0, newBall);
//   //           http.Response resp = await http.post(
//   //               Uri.parse(
//   //                   'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
//   //               body: {
//   //                 'email': email.toString(),
//   //                 'Ballance': getammount,
//   //               });
//   //           adsbox!.put(4, {'clicks': clicks + 1});
//   //           adsbox!.put(3, {'lastclick': DateTime.now()});
//   //           {
//   //             showMessage(context, 'You have earned your reward');
//   //           }
//   //           Timer(Duration(seconds: 40), () {
//   //             setState(() {});
//   //           });
//   //         });
//   //       }, onAdFailedToLoad: (LoadAdError error) {
//   //         unityloadad();
//   //       }));
//   // }

//   final selected = BehaviorSubject<int>();

//   int rewards = 0;
//   final player = AudioCache();
//   List items = [1, 2, 3, 1, 2, 3];
//   // dynamic spincoin;
//   var allcoin = 0;

//   @override
//   void dispose() {
//     selected.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (0 == null) {
//       allcoin = 0;
//     } else {
//       allcoin = 0;
//     }
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 50),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 border: Border(
//                   bottom: BorderSide(color: MainColor),
//                   top: BorderSide(color: MainColor),
//                   left: BorderSide(color: MainColor),
//                   right: BorderSide(color: MainColor),
//                 )),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 5, right: 5),
//               child: Text('${localballance!.get(0)} Coins',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w700,
//                   )),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           AbsorbPointer(
//             absorbing: true,
//             child: SizedBox(
//               height: 430,
//               child: FortuneWheel(
//                 selected: selected.stream,
//                 animateFirst: false,
//                 items: [
//                   FortuneItem(
//                     style: FortuneItemStyle(
//                         color: Color.fromARGB(255, 128, 233, 132),
//                         borderWidth: 1),
//                     child: Text(
//                       items[0].toString() + ' Coin',
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                   FortuneItem(
//                     style:
//                         FortuneItemStyle(color: Colors.black, borderWidth: 1),
//                     child: Text(
//                       items[1].toString() + ' Coin',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                   FortuneItem(
//                     style: FortuneItemStyle(
//                         color: Color.fromARGB(255, 101, 141, 175),
//                         borderWidth: 1),
//                     child: Text(
//                       items[2].toString() + ' Coin',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                   FortuneItem(
//                     style: FortuneItemStyle(
//                         color: Color.fromARGB(255, 240, 80, 80),
//                         borderWidth: 1),
//                     child: Text(
//                       items[3].toString() + ' Coin',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                   FortuneItem(
//                     style: FortuneItemStyle(
//                         color: Color.fromARGB(255, 78, 201, 181),
//                         borderWidth: 1),
//                     child: Text(
//                       items[4].toString() + ' Coin',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                   FortuneItem(
//                     style: FortuneItemStyle(
//                         color: Color.fromARGB(255, 216, 195, 56),
//                         borderWidth: 1),
//                     child: Text(
//                       items[5].toString() + ' Coin',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   ),
//                 ],
//                 onAnimationStart: () {
//                   player.play('assets/sou.mp3');
//                 },
//                 onAnimationEnd: () {
//                   setState(() {
//                     rewards = items[selected.value];
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return Container(
//                             child: AlertDialog(
//                               actions: [
//                                 SizedBox(height: 10),
//                                 Center(
//                                     child: Text('Congratulation..!',
//                                         style: TextStyle(
//                                             fontSize: 30,
//                                             fontWeight: FontWeight.w300,
//                                             color: MainColor))),
//                                 Center(
//                                     child: Container(
//                                   width: 150,
//                                   height: 150,
//                                   child: Image(
//                                       image: AssetImage('assets/congr.webp')),
//                                 )),
//                                 Center(
//                                   child: Text(
//                                       'You Win : ' +
//                                           rewards.toString() +
//                                           ' Coin',
//                                       style: texSty),
//                                 ),
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Center(
//                                     child: MaterialButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                           unityloadad(items[selected.value]);
//                                         },
//                                         height: 50,
//                                         minWidth: 120,
//                                         color: MainColor,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(50)),
//                                         child: Text('CLAIM',
//                                             style: TextStyle(
//                                                 color: Colors.white)))),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           );
//                         });
//                   });
//                 },
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           isLoaded
//               ? Container(
//                   height: 50,
//                   alignment: Alignment.center,
//                   child: AdWidget(ad: _ad!),
//                 )
//               : const SizedBox(),
//           Container(
//             // padding: EdgeInsets.only(top: 3, left: 3),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 border: Border(
//                   bottom: BorderSide(color: Colors.yellow),
//                   top: BorderSide(color: Colors.yellow),
//                   left: BorderSide(color: Colors.yellow),
//                   right: BorderSide(color: Colors.yellow),
//                 )),
//             child: MaterialButton(
//               onPressed: () {
//                 dynamic lastclick = adsbox!.get(3)['lastclick'];
//                 DateTime presenttime = DateTime.now();
//                 Duration difference = presenttime.difference(lastclick);
//                 int clicks = adsbox!.get(4)['clicks'];

//                 if (clicks == 2) {
//                   if (difference.inHours > 24) {
//                     unityloadad(1);
//                     adsbox!.put(4, {'clicks': 0});
//                     adsbox!.put(3, {'lastclick': DateTime.now()});
//                   } else {
//                     {
//                       showMessage(context,
//                           'Next spin available at : ${23 - difference.inHours} Hours ${difference.inMinutes - 60} Minutes');
//                     }
//                   }
//                 } else {
//                   setState(() {
//                     selected.add(Fortune.randomInt(0, items.length));
//                   });
//                 }

//                 SetAnalytic('WatchAd');
//               },
//               color: MainColor,
//               child: Text('Spin',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                   )),
//               elevation: 10,
//               height: 50,
//               minWidth: 120,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50)),
//             ),
//           ),
//         ],
//       ),
//       // ),
//     );
//   }
// }
