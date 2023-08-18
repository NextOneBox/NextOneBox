import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cash/navbar.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:cash/webview.dart';
import 'Widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class Loginscreen extends StatefulWidget {
  Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBiglDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  var phonecontroller = TextEditingController();
  var agecontroller = TextEditingController();
  var gendercontroller = TextEditingController();
  var reffercontroller = TextEditingController();
  final __formkey = GlobalKey<FormState>();
  gettask() async {
    http.Response taskget =
        await http.get(Uri.parse('https://realcash.nextonebox.com/ShowTasks'));
    if (taskget.reasonPhrase == 'OK') {
      await tasks!.clear();
      var da = jsonDecode(taskget.body);
      for (var a in da) {
        await tasks!.add(a);
      }
    }
  }

  void initState() {
    super.initState();
    gettask();
  }

  final FacebookAppEvents facebookAppEvents = FacebookAppEvents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: c6,
      body: Form(
        key: __formkey,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -getSmallDiameter(context) / 3,
              top: -getSmallDiameter(context) / 3,
              child: Container(
                width: getSmallDiameter(context),
                height: getSmallDiameter(context),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 59, 38, 178),
                          Color.fromARGB(255, 20, 75, 241)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
            ),
            Positioned(
              left: -getBiglDiameter(context) / 4,
              top: -getBiglDiameter(context) / 4,
              child: Container(
                child: Center(
                  child: Text(
                    "LoveCash",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                width: getBiglDiameter(context),
                height: getBiglDiameter(context),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 59, 38, 178),
                          Color.fromARGB(255, 20, 75, 241)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: [
                  SizedBox(
                    height: 500,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        bool result =
                            await InternetConnectionChecker().hasConnection;
                        if (result == true) {
                          signInWithGoogle();
                          // signInWithGoogle();
                        } else {
                          Fluttertoast.showToast(
                              msg: "No Iternet Connection",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        elevation: 5,
                        shadowColor: c1,
                        child: Container(
                          width: 360,
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border.all(color: c6),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 40,
                                    height: 40,
                                    child: Image(
                                        image: AssetImage('images/g.png'))),
                                Text(
                                  "   Continue with Google",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      color: Colors.black),
                                )
                              ]), // child: MaterialButton(
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
                            text: "By continuing, you agree to LoveCash ",
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
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => termcondation()));
                                }
                              }),
                        const TextSpan(
                            text: " and ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            style: const TextStyle(color: Colors.green),
                            text: "Privacy Policy",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url =
                                    "https://aitoolsnext.blogspot.com/2023/08/privacypoclicy.html";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => privacy()));
                                }
                              }),
                      ])),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
        await account!.add(dat);
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

        await account!.add(dat);

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

    http.Response getleaderbord = await http
        .get(Uri.parse('https://www.realcash.nextonebox.com/LeaderBoardReq'));
    if (getleaderbord.reasonPhrase == 'OK') {
      await leaderboa!.clear();
      var da = jsonDecode(getleaderbord.body);
      for (var a in da) {
        await leaderboa!.add(a);
      }
    }
    http.Response taskget =
        await http.get(Uri.parse('https://realcash.nextonebox.com/ShowTasks'));
    if (taskget.reasonPhrase == 'OK') {
      await tasks!.clear();
      var da = jsonDecode(taskget.body);
      for (var a in da) {
        await tasks!.add(a);
      }
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
        await account!.add(dat);
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

        await account!.add(dat);
        http.Response resp = await http.post(
            Uri.parse('https://realcash.nextonebox.com/UpdateAccount'),
            body: {
              'name': reslut.displayName.toString(),
              'email': reslut.email.toString(),
              'gender': gendercontroller.text.toString(),
              'phone': phonecontroller.text.toString(),
              'age': agecontroller.text.toString(),
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

    http.Response getleaderbord = await http
        .get(Uri.parse('https://www.realcash.nextonebox.com/LeaderBoardReq'));
    if (getleaderbord.reasonPhrase == 'OK') {
      await leaderboa!.clear();
      var da = jsonDecode(getleaderbord.body);
      for (var a in da) {
        await leaderboa!.add(a);
      }
    }
    http.Response taskget =
        await http.get(Uri.parse('https://realcash.nextonebox.com/ShowTasks'));
    if (taskget.reasonPhrase == 'OK') {
      await tasks!.clear();
      var da = jsonDecode(taskget.body);
      for (var a in da) {
        await tasks!.add(a);
      }
    }
  }

  Box? account = Hive.box('account');
  Box? tasks = Hive.box('tasks');
  Box? leaderboa = Hive.box('leaderboa');
}
