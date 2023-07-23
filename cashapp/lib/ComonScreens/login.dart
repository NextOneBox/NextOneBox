// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:cashapp/ComonScreens/getphone.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';

import 'NavigationScreen.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  TextEditingController emaiSecondaryColoront = TextEditingController();
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    adsbox!.put(11, {'WatchCount': 8});
    adsbox!.put(12, {'WatchLastClickOn': DateTime.now()});

    adsbox!.put(13, {'SpinCount': 8});
    adsbox!.put(14, {'SpinLastClickOn': DateTime.now()});

    adsbox!.put(15, {'ScrachCount': 8});
    adsbox!.put(16, {'ScrachLastClickOn': DateTime.now()});
    localballance!.put(0, 0);

    var maincolor = const Color.fromARGB(255, 0, 0, 0);
    @override
    googleLogin() async {
      GoogleSignIn googleSignIn = GoogleSignIn();
      try {
        var reslut = await googleSignIn.signIn();
        if (reslut == null) {
          return;
        }
        {
          showMessage(context, '\nPlease wait');
        }

        http.Response response = await http.post(
            Uri.parse('https://fogcash.nextonebox.com/CreateAccount'),
            body: {'Email': reslut.email, 'Name': reslut.displayName});
  var da = jsonDecode(response.body);
        if (da != 'Signup') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
            (Route<dynamic> route) => false,
          );
        
          await user.add(da);
          await localballance!.put(0, da['Ballance']);
        }

        if (da == 'Signup') {
          dynamic dat = {
            'Email': reslut.email,
            'Name': reslut.displayName,
          };
          await user.add(dat);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GetPhone()),
            (Route<dynamic> route) => false,
          );
        }
      } catch (error) {
        {
          showMessage(context, '$error');
        }
      }
    }

    return FutureBuilder(
      future: GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', task!),
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
                        'FogCash',
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
                          'Login or Signup to continue',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, bottom: 50, right: 20),
                  child: InkWell(
                    onTap: () {
                      googleLogin();
                    },
                    child: Card(
                      color: SecondaryColor,
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
                              var url =
                                  "https://nextonebox.com/TermAndConditions";
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
          ),
        );
      },
    );
  }
}
