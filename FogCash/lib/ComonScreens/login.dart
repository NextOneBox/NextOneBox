// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';

import 'package:mugcash/ComonScreens/getphone.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'NavigationScreen.dart';
import 'local_notification_service.dart';

class LoginScr extends StatefulWidget {
  const LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  bool load = false;
  TextEditingController emaiSecondaryColoront = TextEditingController();
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    adsbox!.put(11, {'WatchCount': 10});
    adsbox!.put(12, {'WatchLastClickOn': DateTime.now()});

    adsbox!.put(13, {'SpinCount': 10});
    adsbox!.put(14, {'SpinLastClickOn': DateTime.now()});

    adsbox!.put(15, {'ScrachCount': 10});
    adsbox!.put(16, {'ScrachLastClickOn': DateTime.now()});

    adsbox!.put(17, {'SuperSpinCount': 10});
    adsbox!.put(18, {'SuperSpinLastClickOn': DateTime.now()});

    adsbox!.put(20, {'logintime': DateTime.now()});

    adsbox!.put(21, {'vip': 'false'});
    adsbox!.put(22, {'teligram': false});



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

        adsbox!.put(1000, {'image': reslut.photoUrl.toString()});

        print('errr' + reslut.photoUrl.toString());
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
          setState(() {
            load = !load;
          });
        }

        if (da == 'Signup') {
          dynamic dat = {
            'Email': reslut.email,
            'Name': reslut.displayName,
          };
          await user.add(dat);
          await localballance!.put(0, 0);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GetPhone()),
            (Route<dynamic> route) => false,
          );

          setState(() {
            load = !load;
          });
        }
      } catch (error) {
        setState(() {
          load = !load;
        });
        {
          showMessage.show(context, 'Error : Please try again after some time');
        }
      }
      facebookAppEvents.logCompletedRegistration();
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
                        'MugCash',
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
                          'No.1 & Trusted earning app 2023\nLogin or Signup to continue',
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
                          text: "By continuing, you agree to MugCash ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 128, 253, 3)),
                          text: "  T&C  ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              var url =
                                  "https://aitoolsnext.blogspot.com/2023/08/term.html";
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
                              var url = "https://aitoolsnext.blogspot.com/2023/08/privacypoclicy.html";
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
