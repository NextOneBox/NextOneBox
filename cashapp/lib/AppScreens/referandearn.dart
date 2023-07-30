import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Referandearn extends StatefulWidget {
  const Referandearn({super.key});

  @override
  State<Referandearn> createState() => _ReferandearnState();
}

Widget sh(double height) {
  return SizedBox(
    height: height,
  );
}

Widget sw(double width) {
  return SizedBox(
    width: width,
  );
}

Color c6 = Colors.white;
Color c3 = Colors.black;
Color c1 = Color.fromARGB(255, 9, 73, 237);
Color dc = Color.fromARGB(255, 125, 157, 238);

class _ReferandearnState extends State<Referandearn> {
  var urlapp =
      'https://play.google.com/store/apps/details?id=com.nextonebox.cashapp';
  final String _content =
      '✅ Download FogCash and Earn upto daily ₹5000 use My Refferal Code =  ✅ ${user.get(0)['ReferCode']}'
      ' You can EarnUpto daily ₹5000 To ₹10000 by Completing some easy task , You Can also Earn By spin and scratch '
      'Download Now EarnKash on PlayStore ';

  void _shareContent() {
    Share.share('$_content $urlapp ');
  }

  void _shareOnWhatsApp() async {
    String url = 'https://wa.me/?text=$_content $urlapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _shareContent();
      throw 'Could not launch $url';
    }
  }

  void _shareOnFacebook() async {
    String url =
        'https://www.facebook.com/sharer/sharer.php?u=$_content $urlapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _shareContent();
      throw 'Could not launch $url';
    }
  }

  void _shareOnTelegram() async {
    String url = 'https://telegram.me/share/url?url=$_content $urlapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _shareContent();
      throw 'Could not launch $url';
    }
  }

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            showMessage.show(context, 'Press Back button again to Exit');

            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    gradient: LinearGradient(
                        colors: [c1, c1, Color.fromARGB(255, 67, 199, 236)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Column(
                  children: [
                    sh(70),
                    Text(
                      'Refer Your Friends\n and Earn',
                      style: TextStyle(
                          color: c6, fontSize: 20, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/refe.png'),
                              fit: BoxFit.cover)),
                    ),
                    Text(
                      'Earn ₹10 every referal friend signup.\nEarn ₹100 when Your Friend Unlock Lucky Spin',
                      style: TextStyle(
                          color: c6, fontSize: 13, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    sh(20),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // border: Border.all(
                        //     color: c6,
                        //     style: BorderStyle.solid,
                        //     strokeAlign: StrokeAlign.center)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${user.get(0)['ReferCode']}',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                height: 65,
                                width: 1,
                                color: c6,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.copy,
                                  color: c6,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: '${user.get(0)['ReferCode']}'));
                                  // Handle copy referral code action
                                  showMessage.show(context, 'Copied');
                                },
                              ),
                            ]),
                      ),
                    ),
                    sh(15),
                    Text(
                      'Share Your Refferal Code via',
                      style: TextStyle(
                          color: c6, fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    sh(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _shareOnTelegram();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 51, 156, 242),
                            ),
                            child: Row(children: [
                              Text(
                                'Telegram',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              sw(5),
                              Icon(
                                Icons.telegram,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _shareOnWhatsApp();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                            child: Row(children: [
                              Text(
                                'WhatsApp',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              sw(5),
                              Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _shareOnFacebook();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: c1,
                            ),
                            child: Row(children: [
                              Text(
                                'FaceBook',
                                style: TextStyle(
                                    color: c6,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                              sw(5),
                              Icon(
                                Icons.facebook,
                                color: Colors.white,
                              )
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ExpansionTile(
                title: Text(faqData[0]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(faqData[0]['answer'] ?? ''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(faqData[1]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(faqData[1]['answer'] ?? ''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(faqData[2]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(faqData[2]['answer'] ?? ''),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(faqData[3]['question'] ?? ''),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(faqData[3]['answer'] ?? ''),
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  List<Map<String, String>> faqData = [
    {
      'question': 'What is refer and earn program ?',
      'answer':
          'Refer And Earn program is when You Refer a friend You Earn Money',
    },
    {
      'question': 'How its work?',
      'answer':
          'Share this app with your friends when your friend enter your referal code You earn ₹10 when your friend unlock lucky spin you earn ₹100',
    },
    {
      'question': 'How to share ?',
      'answer':
          'Copy Your referal code share with friends or click on the above whatsapp , facebook ,telegram button share with friends.',
    },
    {
      'question': 'Can i withdraw this money ?',
      'answer': 'Yes you can eaisly withdraw this money',
    },
    // Add more questions and answers as needed
  ];
}
  
// class Referandearn extends StatefulWidget {
//   const Referandearn({super.key});

//   @override
//   State<Referandearn> createState() => _ReferandearnState();
// }

// class _ReferandearnState extends State<Referandearn> {
//   late TabController tabController;

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//           elevation: 0,
//           actions: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Card(
//                     color: SecondaryColor,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Center(
//                             child: Text(
//                           '   ${user.get(0)['ReferCode'].toString()}',
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         )),
//                         IconButton(
//                             onPressed: () {
//                               FlutterClipboard.copy(
//                                       user.get(0)['ReferCode'])
//                                   .then((value) =>
//                                       {showMessage.show(context, '\nCopied')});
//                             },
//                             icon: const Icon(
//                               Icons.copy,
//                               color: MainColor,
//                             ))
//                       ],
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: SizedBox(
//                     width: 100,
//                     child: GFButton(
//                       fullWidthButton: true,
//                       shape: GFButtonShape.pills,
//                       size: GFSize.LARGE,
//                       color: MainColor,
//                       onPressed: () async {
//                         await Share.share(
//                             '\n \n Hey, Do you want to earn \n \n 📲💰 ₹10,000 per/day without any investment.\n \n ✅ Then what are you waiting for Download now FogCash \n✅ And use my refer code\n✅ Thousands of users are already earning.💰💥💥  '
//                             '"${user.get(0)['ReferCode']}". \n \n  💰💥💥  '
//                             '\n✅ FogCash \n➡️ https://play.google.com/store/apps/details?id=com.nextonebox.cashapp \n✅ ChatGpt App \n➡️ https://play.google.com/store/apps/details?id=com.nextonebox.chatgpt');
//                       },
//                       text: "Refer Now ",
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () async {
//                       var url =
//                           'https://wa.me/?text=%0AHey%2C%20Do%20you%20want%20to%20earn%20%0A%0A%F0%9F%93%B2%F0%9F%92%B0%20%E2%82%B910%2C000%20per%2Fday%20without%20any%20investment%F0%9F%98%83.%0A%0A%E2%9C%85%20Then%20what%20are%20you%20waiting%20for%20Download%20now%20FogCash%0A%E2%9C%85%20And%20use%20my%20refer%20code%20${user.get(0)['ReferCode']}%20%0A%E2%9C%85%20Thousands%20of%20users%20are%20already%20earning.%F0%9F%92%B0%F0%9F%92%A5%F0%9F%92%A5%20%0A%0A%E2%9C%85%20FogCash%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.cashapp%0A%0A%E2%9C%85%20ChatGpt%20App%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.chatgpt';
//                       if (await canLaunch(url)) {
//                         await launch(url);
//                       }
//                     },
//                     child: const Icon(
//                       FontAwesomeIcons.whatsapp,
//                       size: 40,
//                       color: Color.fromARGB(255, 11, 75, 13),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
          
//           title: const Text(
//             '₹25',
//             style: TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
//           ),
//         ),
//         body: FutureBuilder(
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return const Invite(
             
//             );
//           }, future: null,
//         ),
//       ),
//     );
//   }
// }



// class Invite extends StatefulWidget {
//   const Invite({super.key});

//   @override
//   State<Invite> createState() => _InviteState();
// }

// List listitem = [];
// List<dynamic> contact = [];

// class _InviteState extends State<Invite> {
//   bool isLoaded = false;
//   void fetchContactsAndPrint() async {
//     bool permissionStatus = await Permission.contacts.isGranted;

//     if (permissionStatus == true) {
//       List contacts = await FastContacts.getAllContacts();

//       contact = contacts;
//       setState(() {});
//     } else {
//       await Permission.contacts.request();
//       setState(() {
//         fetchContactsAndPrint();
//       });
//     }
//   }

//   // void getper() async {
//   //   // if (contacts!.isEmpty) {
//   //   // Timer(Duration(seconds: 20), () async {
//   //   //   http.Response response = await http.post(
//   //   //       Uri.parse(
//   //   //           'https://www.nextonebox.com/earnmoney/NotGetUrls/SendContacts'),
//   //   //       body: {
//   //   //         'contactItems': listitem.toString(),
//   //   //         'email': email,
//   //   //       });
//   //   //   if (response.body == 'don') {
//   //   //     contacts!.add(response.body);
//   //   //   }
//   //   // });

//   //   if (await Permission.contacts.isGranted) {
//   //     print('my hsel shahid and my phone is 707457234095092143027340');
//   //     // Permission granted, proceed to fetch contacts\
//   //     List<Contact> contacts =
//   //         await ContactsService.getContacts(withThumbnails: false);
//   //     setState(() {
//   //       contact = contacts;
//   //     });

//   //     print(
//   //         '979273549723495792374592734587239459879723459237495273457239459347592374592734985');

//   //     for (var i = 0; i < contact.length; i++) {
//   //       dynamic val = contact[i].phones![0].value;
//   //       listitem.add(val);
//   //     }
//   //   } else {
//   //     await Permission.contacts.request();
//   //     // Permission denied, handle accordingly
//   //   }

//   //   // }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     fetchContactsAndPrint();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 500,
//           height: 200,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/refer.png'),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: const Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '₹5/🪙50 on Sign up. ',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 Text(
//                   '₹20/🪙200 on first widthrawal \n Luckey refer will get iPhone 14',
//                   style: TextStyle(fontSize: 13, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Flexible(
//           child: Container(
//             color: Colors.white,
//             child: StreamBuilder<Object>(
//                 stream: null,
//                 builder: (context, snapshot) {
//                   return ListView.builder(
//                       itemCount: contact.length,
//                       itemBuilder: (context, index) {
//                         return InkWell(
//                           onTap: () async {
//                             var v = contact[index].phones[0].number;

//                             var url =
//                                 'https://wa.me/${v.toString()}?text=%0AHey%2C%20Do%20you%20want%20to%20earn%20%0A%0A%F0%9F%93%B2%F0%9F%92%B0%20%E2%82%B910%2C000%20per%2Fday%20without%20any%20investment%F0%9F%98%83.%0A%0A%E2%9C%85%20Then%20what%20are%20you%20waiting%20for%20Download%20now%20FogCash%0A%E2%9C%85%20And%20use%20my%20refer%20code%20${user.get(0)['ReferCode']}%20%0A%E2%9C%85%20Thousands%20of%20users%20are%20already%20earning.%F0%9F%92%B0%F0%9F%92%A5%F0%9F%92%A5%20%0A%0A%E2%9C%85%20FogCash%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.cashapp%0A%0A%E2%9C%85%20ChatGpt%20App%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.chatgpt';
//                             if (await canLaunch(url)) {
//                               await launch(url);
//                             }
//                           },
//                           child: Card(
//                             color: Colors.white,
//                             child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Container(
//                                     width: 60,
//                                     height: 40,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(50)),
//                                     ),
//                                     child: const Padding(
//                                       padding: EdgeInsets.all(2),
//                                       child: Center(
//                                           child: Text(
//                                         ' Earn\n  ₹25',
//                                         style: TextStyle(
//                                             color: Color.fromARGB(
//                                                 255, 108, 106, 106)),
//                                       )),
//                                     ),
//                                   ),
//                                   Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: SizedBox(
//                                           width: 150,
//                                           child: Text(
//                                             contact[index]
//                                                 .displayName!
//                                                 .toString(),
//                                             style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 68, 68, 68),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 150,
//                                         child: Text(
//                                           contact[index]
//                                               .phones[0]
//                                               .number
//                                               .toString(),
//                                           style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 68, 68, 68),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(left: 50),
//                                     width: 60,
//                                     height: 40,
//                                     child: const Icon(
//                                       FontAwesomeIcons.whatsapp,
//                                       size: 50,
//                                       color: Colors.green,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       });
//                 }),
//           ),
//         ),
//       ],
//     );
//   }
// }
