// ignore_for_file: sort_child_properties_last

import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:figtrade/widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Navbar.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

import '../widget.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final FacebookAppEvents facebookAppEvents = FacebookAppEvents();
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  var phonecontroller = TextEditingController();
  var agecontroller = TextEditingController();
  var gendercontroller = TextEditingController();
  var reffercontroller = TextEditingController();
  final __formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: c3,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 250, left: 30, bottom: 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon.png',
                    fit: BoxFit.fill,
                    height: 50,
                  ),
                  const Text(
                    'FigTrade',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 100, left: 30),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'No.1 & Trusted trading app 2023\nLogin or Signup to continue',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 50, right: 20),
              child: InkWell(
                onTap: () {
                  signInWithGoogle();
                },
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/googleicon.png',
                            fit: BoxFit.fill,
                            height: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Continue with Google',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Proxima Nova'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 250,
                child: RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "By continuing, you agree to NextOneBox ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      style: const TextStyle(
                          color: Color.fromARGB(255, 128, 253, 3)),
                      text: "  T&C  ",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          var url = "https://nextonebox.com/TermAndConditions";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                  const TextSpan(
                      text: " and ", style: TextStyle(color: Colors.black)),
                  TextSpan(
                      style: const TextStyle(color: Colors.green),
                      text: "Privacy Policy",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          var url = "https://nextonebox.com/PrivacyPolicy";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }),
                ])),
              ),
            ),
          ],
        ),
        //  Form(
        //   key: __formkey,
        //   child: Stack(
        //     children: <Widget>[
        //       Align(
        //         alignment: Alignment.bottomCenter,
        //         child: ListView(
        //           children: [
        //             Container(
        //               decoration: BoxDecoration(
        //                   color: Colors.white,
        //                   //border: Border.all(color: Colors.grey),
        //                   borderRadius: BorderRadius.circular(10)),
        //               margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
        //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
        //               child: Column(
        //                 children: <Widget>[
        //                   TextFormField(
        //                     validator: (value) {
        //                       if (value == null || value.isEmpty) {
        //                         return 'Enter Your Phone No';
        //                       }
        //                       if (value.length > 10 || value.length < 10) {
        //                         return 'Enter Corect phone No';
        //                       }
        //                       return null;
        //                     },
        //                     controller: phonecontroller,
        //                     decoration: InputDecoration(
        //                         // border: OutlineInputBorder(
        //                         //     borderSide: BorderSide.none),
        //                         icon: Icon(Icons.phone, color: c1),
        //                         focusedBorder: UnderlineInputBorder(
        //                             borderSide:
        //                                 BorderSide(color: Colors.grey.shade100)),
        //                         labelText: "Phone No",
        //                         enabledBorder: InputBorder.none,
        //                         labelStyle: const TextStyle(color: Colors.grey)),
        //                   ),
        //                   TextFormField(
        //                     validator: (value) {
        //                       // Check if this field is empty
        //                       if (value == null || value.isEmpty) {
        //                         return 'Enter Your Gender';
        //                       }
        //                       return null;
        //                     },
        //                     controller: gendercontroller,
        //                     decoration: InputDecoration(
        //                         icon: Icon(FontAwesomeIcons.venusMars, color: c1),
        //                         focusedBorder: UnderlineInputBorder(
        //                             borderSide:
        //                                 BorderSide(color: Colors.grey.shade100)),
        //                         labelText: "Gender",
        //                         enabledBorder: InputBorder.none,
        //                         labelStyle: const TextStyle(color: Colors.grey)),
        //                   ),
        //                   TextFormField(
        //                     controller: reffercontroller,
        //                     decoration: InputDecoration(
        //                         icon: Icon(
        //                           Icons.redeem,
        //                           color: c1,
        //                         ),
        //                         focusedBorder: UnderlineInputBorder(
        //                             borderSide:
        //                                 BorderSide(color: Colors.grey.shade100)),
        //                         labelText: "Refer code (optional)",
        //                         enabledBorder: InputBorder.none,
        //                         labelStyle: const TextStyle(color: Colors.grey)),
        //                   )
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: <Widget>[
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * 0.8,
        //                     height: 43,
        //                     child: Container(
        //                       child: Material(
        //                         borderRadius: BorderRadius.circular(20),
        //                         color: Colors.transparent,
        //                         child: InkWell(
        //                           borderRadius: BorderRadius.circular(20),
        //                           splashColor: Color.fromRGBO(220, 208, 172, 1),
        //                           onTap: () async {
        //                             if (__formkey.currentState!.validate()) {
        //                               bool result =
        //                                   await InternetConnectionChecker()
        //                                       .hasConnection;
        //                               if (result == true) {
        //                                 signInWithEmail();
        //                               } else {
        //                                 Fluttertoast.showToast(
        //                                     msg: "No Iternet Connection",
        //                                     toastLength: Toast.LENGTH_SHORT,
        //                                     backgroundColor: c6,
        //                                     textColor: c3,
        //                                     fontSize: 16.0);
        //                               }
        //                             }
        //                           },
        //                           child: const Center(
        //                             child: Text(
        //                               "LOGIN",
        //                               style: TextStyle(
        //                                   color: Colors.white,
        //                                   fontWeight: FontWeight.w700),
        //                             ),
        //                           ),
        //                         ),
        //                       ),
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(20),
        //                           color: buttoncolor),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Center(
        //                 child: Text(
        //               'Or',
        //               style: TextStyle(color: c1, fontWeight: FontWeight.w700),
        //             )),
        //             SizedBox(
        //               height: 10,
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: GestureDetector(
        //                 onTap: () async {
        //                   bool result =
        //                       await InternetConnectionChecker().hasConnection;
        //                   if (result == true) {
        //                     signInWithGoogle();
        //                     // signInWithGoogle();
        //                   } else {
        //                     Fluttertoast.showToast(
        //                         msg: "No Iternet Connection",
        //                         toastLength: Toast.LENGTH_SHORT,
        //                         backgroundColor: Colors.purple,
        //                         textColor: Colors.white,
        //                         fontSize: 16.0);
        //                   }
        //                 },
        //                 child: Card(
        //                   shape: RoundedRectangleBorder(
        //                     borderRadius: BorderRadius.circular(40.0),
        //                   ),
        //                   elevation: 10,
        //                   shadowColor: c1,
        //                   child: Container(
        //                     width: 360,
        //                     height: 55,
        //                     decoration: BoxDecoration(
        //                         border: Border.all(color: c6),
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(40)),
        //                     child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           Container(
        //                               width: 40,
        //                               height: 40,
        //                               child: Icon(
        //                                 FontAwesomeIcons.google,
        //                               )
        //                               // Image(
        //                               //     image: AssetImage('images/g.png'))
        //                               ),
        //                           Text(
        //                             "google",
        //                             style: TextStyle(
        //                                 fontWeight: FontWeight.w500,
        //                                 fontSize: 22,
        //                                 color: Colors.black),
        //                           )
        //                         ]), // child: MaterialButton(
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
      ),
    );
  }

  signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }
      Fluttertoast.showToast(
          msg: "${reslut.email}",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: c6,
          textColor: c3,
          fontSize: 16.0);

      http.Response response = await http.post(
          Uri.parse('https://realcash.nextonebox.com/CreateAccount'),
          body: {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'image': reslut.photoUrl.toString(),
          });

      if (response.body == 'Login') {
        dynamic dat = {
          'email': reslut.email.toString(),
          'name': reslut.displayName.toString(),
          'Ballance': '0',
          'Refercode': '....',
        };
        await userdata!.add(dat);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomapp()),
          (Route<dynamic> route) => false,
        );
      }

      if (response.body == 'account created') {
        dynamic dat = {
          'email': reslut.email.toString(),
          'name': reslut.displayName.toString(),
          'Ballance': '0',
          'Refercode': '....',
        };

        await userdata!.add(dat);
        facebookAppEvents.logCompletedRegistration();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomapp()),
          (Route<dynamic> route) => false,
        );
      }

      Fluttertoast.showToast(
          msg: "${response.body}",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: c6,
          textColor: c3,
          fontSize: 16.0);
    } catch (error) {
      print(error);
    }
  }

  signInWithEmail() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }
      Fluttertoast.showToast(
          msg: "${reslut.email}",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: c6,
          textColor: c3,
          fontSize: 16.0);

      http.Response response = await http.post(
          Uri.parse('https://realcash.nextonebox.com/CreateAccount'),
          body: {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'image': reslut.photoUrl.toString(),
          });

      if (response.body == 'Login') {
        dynamic dat = {
          'email': reslut.email.toString(),
          'name': reslut.displayName.toString(),
          'Ballance': '0',
          'Refercode': '....',
        };
        await userdata!.add(dat);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomapp()),
          (Route<dynamic> route) => false,
        );
      }

      if (response.body == 'account created') {
        dynamic dat = {
          'email': reslut.email.toString(),
          'name': reslut.displayName.toString(),
          'Ballance': '0',
          'Refercode': '....',
        };

        await userdata!.add(dat);
        facebookAppEvents.logCompletedRegistration();
        http.Response resp = await http.post(
            Uri.parse('https://realcash.nextonebox.com/UpdateAccount'),
            body: {
              'name': reslut.displayName.toString(),
              'email': reslut.email.toString(),
              'gender': gendercontroller.text.toString(),
              'phone': phonecontroller.text.toString(),
              'referby': reffercontroller.text.toString(),
            });
        Fluttertoast.showToast(
            msg: "${resp.body}",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: c6,
            textColor: c3,
            fontSize: 16.0);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomapp()),
          (Route<dynamic> route) => false,
        );
      }

      Fluttertoast.showToast(
          msg: "${response.body}",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: c6,
          textColor: c3,
          fontSize: 16.0);
      print(response.body);
    } catch (error) {}
  }
}
