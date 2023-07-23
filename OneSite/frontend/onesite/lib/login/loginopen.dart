
// import 'package:flutter/gestures.dart';
// import 'package:onesite/helper.dart';
// import 'package:http/http.dart' as http;
// import 'package:onesite/login/getphone.dart';


// class LoginScr extends StatefulWidget {
//   const LoginScr({super.key});

//   @override
//   State<LoginScr> createState() => _LoginScrState();
// }

// class _LoginScrState extends State<LoginScr> {

//   Box? tasks = Hive.box('tasks');
//   TextEditingController emaiSecondaryColoront = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
   
//     var maincolor = const Color.fromARGB(255, 0, 0, 0);
//     @override
//     googleLogin() async {
//       GoogleSignIn googleSignIn = GoogleSignIn();
//       try {
//         var reslut = await googleSignIn.signIn();
//         if (reslut == null) {
//           return;
//         }
       
//         print(reslut.displayName.toString());
//         http.Response response = await http.post(
//             Uri.parse(
//                 'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
//             body: {
//               'email': reslut.email.toString(),
//               'name': reslut.displayName.toString(),
//               'otp': 'googleotplogin',
//             });
       

//         if (response.body == 'Login') {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const Navigation()),
//             (Route<dynamic> route) => false,
//           );
//           dynamic dat = {
//             'email': reslut.email.toString(),
//             'name': reslut.displayName.toString(),
//             'Ballance': '100',
//             'EMPremium': 'false',
//             'Refercode': '..',
//           };
        

//         }

//         if (response.body == 'account created') {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => const GetPhone()),
//             (Route<dynamic> route) => false,
//           );
//           dynamic dat = {
//             'email': reslut.email.toString(),
//             'name': reslut.displayName.toString(),
//             'Ballance': '100',
//             'EMPremium': 'false',
//             'Refercode': '..',
//           };
         

    
//         }
//       } catch (error) {
       
//       }
//     }

//     return FutureBuilder(
//       future: GetRequest(
//           'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', tasks!),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         return Scaffold(
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 250, left: 30, bottom: 10),
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         'assets/Nob.png',
//                         fit: BoxFit.fill,
//                         height: 50,
//                       ),
//                       const Text(
//                         'NextOneBox',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(bottom: 100, left: 30),
//                   child: const Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Login or Signup to continue',
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 400,
//                   margin: const EdgeInsets.only(left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       SizedBox(
//                         width: 240,
//                         child: TextField(
//                           controller: emaiSecondaryColoront,
//                           decoration: InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                               color: maincolor,
//                             )),
//                             border: const OutlineInputBorder(),
//                             floatingLabelStyle: TextStyle(color: maincolor),
//                             labelText: 'Email',
//                             prefixIcon: Padding(
//                               padding: const EdgeInsets.all(8),
//                               child: Icon(
//                                 Icons.email,
//                                 color: maincolor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       GFButton(
//                         onPressed: () async {
//                           if (RegExp(
//                                   r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
//                               .hasMatch(emaiSecondaryColoront.text)) {
//                             {
//                               showMessage(context, 'Please wait');
//                             }

//                             http.Response response = await http.post(
//                                 Uri.parse(
//                                     'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
//                                 body: {
//                                   'email': emaiSecondaryColoront.text,
//                                   'otp': '',
//                                   'name': 'user'
//                                 });

                          
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => LoginOtp(
//                                       data: emaiSecondaryColoront.text
//                                           .toString())),
//                             );
//                           } else {
//                             {
//                               showMessage(
//                                   context, 'Please enter correct email Id');
//                             }
//                           }
//                         },
//                         color: maincolor,
//                         shape: GFButtonShape.pills,
//                         size: GFSize.LARGE,
//                         text: 'n e x t',
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15, bottom: 15),
//                   child: Center(
//                     child: Text(
//                       'Or',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: maincolor),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(left: 20, bottom: 50, right: 20),
//                   child: InkWell(
//                     onTap: () {
//                       googleLogin();
//                     },
//                     child: Card(
//                       color: SecondaryColor,
//                       elevation: 5,
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 'assets/googleicon.png',
//                                 fit: BoxFit.fill,
//                                 height: 30,
//                               ),
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 10),
//                                 child: Text(
//                                   'Continue with Google',
//                                   style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily: 'Proxima Nova'),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: SizedBox(
//                     width: 250,
//                     child: RichText(
//                         text: TextSpan(children: [
//                       const TextSpan(
//                           text: "By continuing, you agree to NextOneBox ",
//                           style: TextStyle(color: Colors.black)),
//                       TextSpan(
//                           style: const TextStyle(
//                               color: Color.fromARGB(255, 128, 253, 3)),
//                           text: "  T&C  ",
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () async {
//                               var url =
//                                   "https://nextonebox.com/TermAndConditions";
//                               if (await canLaunch(url)) {
//                                 await launch(url);
//                               } else {
//                                 throw 'Could not launch $url';
//                               }
//                             }),
//                       const TextSpan(
//                           text: " and ", style: TextStyle(color: Colors.black)),
//                       TextSpan(
//                           style: const TextStyle(color: Colors.green),
//                           text: "Privacy Policy",
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () async {
//                               var url = "https://nextonebox.com/PrivacyPolicy";
//                               if (await canLaunch(url)) {
//                                 await launch(url);
//                               } else {
//                                 throw 'Could not launch $url';
//                               }
//                             }),
//                     ])),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class GetRequest {
// }
