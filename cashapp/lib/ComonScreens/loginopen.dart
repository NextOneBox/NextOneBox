import 'package:cashapp/ComonScreens/getphone.dart';
import 'package:cashapp/ComonScreens/loginotp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';

class LoginScr extends StatefulWidget {
  LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  Box? tasks = Hive.box('tasks');
  TextEditingController emaiSecondaryColoront = TextEditingController();
  @override
  Widget build(BuildContext context) {
    adsbox!.put(9, {'superSpin': 'false'});
    adsbox!.put(5, {'clicks': 0});
    adsbox!.put(7, {'lastclick': DateTime.now()});
    var maincolor = Color.fromARGB(255, 0, 0, 0);
    @override
    googleLogin() async {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      try {
        var reslut = await _googleSignIn.signIn();
        if (reslut == null) {
          return;
        }
        {
          showMessage(context, 'Please wait');
        }

        http.Response response = await http.post(
            Uri.parse(
                'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
            body: {
              'email': reslut.email.toString(),
              'name': reslut.displayName.toString(),
              'otp': 'googleotplogin',
            });

        if (response.body == 'Login') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
            (Route<dynamic> route) => false,
          );
          dynamic dat = {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'Ballance': '0',
            'EMPremium': 'true',
            'Refercode': '..',
          };
          await localballance!.put(0, 0);
          await user.add(dat);
          await adsbox!.put(4, {'clicks': 0});
          await adsbox!.put(3, {'lastclick': DateTime.now()});
          await adsbox!.put(10, {'dailygift': DateTime.now()});

          Ontimecall();
        }

        if (response.body == 'account created') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GetPhone()),
            (Route<dynamic> route) => false,
          );
          dynamic dat = {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'Ballance': '0',
            'EMPremium': 'false',
            'Refercode': '..',
          };
          await localballance!.put(0, 0);
          await user.add(dat);
          await adsbox!.put(4, {'clicks': 0});
          await adsbox!.put(3, {'lastclick': DateTime.now()});
          await adsbox!.put(10, {'dailygift': DateTime.now()});

          Ontimecall();
          AwesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.INFO,
              body: Center(
                child: Text(
                  'Follow us on Instagram \n\n\n Get instant 10 Coins \n\n Get latest updates',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              keyboardAware: true,
              btnOkText: "Follow",
              title: 'Follow us on Instagram',
              padding: const EdgeInsets.all(5.0),
              btnCancelOnPress: () {},
              btnOkOnPress: () async {
                var url = 'https://www.instagram.com/nextonebox/';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              });
        }
      } catch (error) {
        {
          showMessage(context, '$error');
        }
      }
    }

    return FutureBuilder(
      future: GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', tasks!),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 250, left: 30, bottom: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/Nob.png',
                        fit: BoxFit.fill,
                        height: 50,
                      ),
                      Text(
                        'NextOneBox',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 100, left: 30),
                  child: Padding(
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
                  width: 400,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 240,
                        child: TextField(
                          controller: emaiSecondaryColoront,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: maincolor,
                            )),
                            border: OutlineInputBorder(),
                            floatingLabelStyle: TextStyle(color: maincolor),
                            labelText: 'Email',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.email,
                                color: maincolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GFButton(
                        onPressed: () async {
                          if (RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(emaiSecondaryColoront.text)) {
                            {
                              showMessage(context, 'Please wait');
                            }

                            http.Response response = await http.post(
                                Uri.parse(
                                    'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
                                body: {
                                  'email': emaiSecondaryColoront.text,
                                  'otp': '',
                                  'name': 'user'
                                });

                            print(response.body);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginOtp(
                                      data: emaiSecondaryColoront.text
                                          .toString())),
                            );
                          } else {
                            {
                              showMessage(
                                  context, 'Please enter correct email Id');
                            }
                          }
                        },
                        color: maincolor,
                        shape: GFButtonShape.pills,
                        size: GFSize.LARGE,
                        text: 'n e x t',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(
                    child: Text(
                      'Or',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: maincolor),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 50, right: 20),
                  child: InkWell(
                    onTap: () {
                      googleLogin();
                    },
                    child: Card(
                      color: SecondaryColor,
                      elevation: 5,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/googleicon.png',
                                fit: BoxFit.fill,
                                height: 30,
                              ),
                              Padding(
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
                  child: Container(
                    width: 250,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "By continuing, you agree to NextOneBox ",
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          style: TextStyle(
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
                      TextSpan(
                          text: " and ", style: TextStyle(color: Colors.black)),
                      TextSpan(
                          style: TextStyle(color: Colors.green),
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
