// import 'package:MyChatAi/OtherFiles/contactus.dart';
// import 'package:MyChatAi/OtherFiles/history.dart';
// import 'package:MyChatAi/OtherFiles/premium.dart';
// import 'package:MyChatAi/OtherFiles/referandearn.dart';
// import 'package:MyChatAi/OtherFiles/webpage.dart';

// import 'package:MyChatAi/OtherFiles/widgets.dart';

// import 'widgets.dart' as widgets;

// Future<void> logout() async {
//   await GoogleSignIn().disconnect();
//   FirebaseAuth.instance.signOut();
// }

// class Account extends StatefulWidget {
//   Account({
//     super.key,
//   });

//   @override
//   State<Account> createState() => _AccountState();
// }

// class _AccountState extends State<Account> {
//   String? get url => null;
//   BannerAd? _ad;
//   bool isLoaded = false;

//   @override
//   void initState() {
//     super.initState();
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 250,
//               width: 500,
//               decoration: UseBorder,
//               child: Padding(
//                 padding: EdgeInsets.only(top: 35),
//                 child: Column(
//                   children: [
//                     GFListTile(
//                       shadow: BoxShadow(offset: Offset.infinite),
//                       margin: EdgeInsets.all(20),
//                       avatar: GFAvatar(
//                         backgroundColor: Colors.black,
//                         child: Icon(
//                           FontAwesomeIcons.userAstronaut,
//                           color: Colors.green,
//                         ),
//                       ),
//                       titleText: widgets.name,
//                       subTitleText: widgets.email,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SizedBox(
//                           width: 150,
//                           child: GFButton(
//                             color: Colors.amber,
//                             textColor: BackColor,
//                             fullWidthButton: true,
//                             size: 50,
//                             onPressed: () {
//                               SetAnalytic('pro');

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Premium()),
//                               );
//                             },
//                             text: "Ai Pro",
//                             icon: Icon(
//                               FontAwesomeIcons.chessKing,
//                               color: BackColor,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 150,
//                           child: GFButton(
//                             color: Colors.green,
//                             textColor: BackColor,
//                             fullWidthButton: true,
//                             size: 50,
//                             onPressed: () {
//                               SetAnalytic('Setting');

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => AccountSetting()),
//                               );
//                             },
//                             text: "Setting",
//                             icon: Icon(
//                               FontAwesomeIcons.userPen,
//                               color: BackColor,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     onTap: (() {
//                       SetAnalytic('History');

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => History()),
//                       );
//                     }),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.history,
//                               color: MainColor,
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               'History',
//                               style: TextStyle(
//                                 color: MainColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: (() {
//                       SetAnalytic('Refer and earn');

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Referandearn()),
//                       );
//                     }),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.share,
//                               color: MainColor,
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               'Refer & Earn',
//                               style: TextStyle(
//                                 color: MainColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: (() {
//                       SetAnalytic('ContactUs');

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ContactUs()),
//                       );
//                     }),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               FontAwesomeIcons.headset,
//                               color: MainColor,
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               'Support 24/7',
//                               style: TextStyle(
//                                 color: MainColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: (() {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => WebPage(
//                                   data:
//                                       'https://www.nextonebox.com/TermAndConditions',
//                                 )),
//                       );
//                       SetAnalytic('Term&Con');
//                     }),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               FontAwesomeIcons.signature,
//                               color: MainColor,
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               ' Term & Con.',
//                               style: TextStyle(
//                                 color: MainColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: (() async {
//                       SetAnalytic('RateUs');

//                       var url =
//                           'https://play.google.com/store/apps/details?id=com.nextonebox.MyChatAi';
//                       if (await canLaunch(url)) {
//                         await launch(url);
//                       }
//                     }),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               FontAwesomeIcons.star,
//                               color: MainColor,
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               ' Rate us',
//                               style: TextStyle(
//                                 color: MainColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: (() async {
//                       SetAnalytic('Logout');
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             content: Text(
//                                 'Are you sure do you want to logout. You can login again.'),
//                             actions: <Widget>[
//                               TextButton(
//                                 child: Text('Cancel'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                               TextButton(
//                                 child: Text('Logut'),
//                                 onPressed: () {
//                                   SetAnalytic('logout');
//                                   logout();
//                                   widgets.account.clear();

//                                   SystemNavigator.pop();
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     }),
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.logout,
//                               color: MainColor,
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               ' Logout',
//                               style: TextStyle(
//                                 color: MainColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 60,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () async {
//                             SetAnalytic('Facebook');

//                             var url = 'https://www.facebook.com/nextonebox';
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             }
//                           },
//                           icon: Icon(
//                             FontAwesomeIcons.facebook,
//                             size: 20,
//                             color: PrColor,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () async {
//                             SetAnalytic('Youtube');

//                             var url = 'https://www.youtube.com/@nextonebox';
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             }
//                           },
//                           icon: Icon(
//                             FontAwesomeIcons.youtube,
//                             size: 20,
//                             color: PrColor,
//                           ),
//                         ),
//                         IconButton(
//                             onPressed: () async {
//                               SetAnalytic('nextonebox');

//                               var url = 'https://www.nextonebox.com/';
//                               if (await canLaunch(url)) {
//                                 await launch(url);
//                               }
//                             },
//                             icon: Image.asset(
//                               'assets/next.png',
//                               fit: BoxFit.fill,
//                             )),
//                         IconButton(
//                           onPressed: () async {
//                             SetAnalytic('instagram');

//                             var url = 'https://www.instagram.com/nextonebox/';
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             }
//                           },
//                           icon: Icon(
//                             FontAwesomeIcons.instagram,
//                             size: 20,
//                             color: PrColor,
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(
//                             FontAwesomeIcons.twitter,
//                             size: 20,
//                             color: PrColor,
//                           ),
//                           onPressed: () async {
//                             SetAnalytic('twitter');

//                             var url = 'https://twitter.com/NextOneBox';
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                   isLoaded
//                       ? Container(
//                           height: 50,
//                           alignment: Alignment.center,
//                           child: AdWidget(ad: _ad!),
//                         )
//                       : const SizedBox()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
