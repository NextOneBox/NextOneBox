// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:ipl/payment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:facebook_app_events/facebook_app_events.dart';

final FacebookAppEvents facebookAppEvents = FacebookAppEvents();

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  bool load = false;
  TextEditingController emaiSecondaryColoront = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var maincolor = const Color.fromARGB(255, 0, 0, 0);
    @override
    googleLogin() async {
      GoogleSignIn googleSignIn = GoogleSignIn();
      try {
        var reslut = await googleSignIn.signIn();
        if (reslut == null) {
          return;
        }

        http.Response response = await http.post(
            Uri.parse('https://realcash.nextonebox.com/w/CreateAccount'),
            body: {'email':reslut.email});
      
        if (response.reasonPhrase == 'OK') {
          await user.clear();
          var da = jsonDecode(response.body);
          await user.add(da);
        }

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PaymentPage()),
          (Route<dynamic> route) => false,
        );
       
      } catch (error) {
        setState(() {
          load = !load;
        });

        {
          showMessage.show(
              context, 'Error : Please try again after some time ');
        }
      }
      facebookAppEvents.logCompletedRegistration();
    }

    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
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
                        ' Winners Team',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                          '\nLogin or Signup to continue',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                if (load)
                  SpinKitThreeInOut(
                    duration: Duration(seconds: 1),
                    color: Colors.black,
                    size: 30.0,
                  ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, bottom: 50, right: 20),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        load = !load;
                      });

                      googleLogin();
                    },
                    child: Card(
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
                          text: "By continuing, you agree to Winners Team ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 128, 253, 3)),
                          text: "  T&C  ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var url =
                                  "https://winnerteam11next.blogspot.com/2023/08/terms.html";
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
                              var url =
                                  "https://winnerteam11next.blogspot.com/2023/08/privacy-policy.html";
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
          ),
        );
      },
    );
  }
}

class showMessage {
  static void show(BuildContext context, String MYmessage) {
    final overlay = Overlay.of(context);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            child: Card(
              color: Colors.black54,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  MYmessage,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the toast after a short delay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
