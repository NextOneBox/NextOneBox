import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cash/navbar.dart';

import 'package:cash/Authentication.dart';
import 'package:cash/SpinWheel.dart';
import 'Colors.dart';

Box? account = Hive.box('account');
Box? tasks = Hive.box('tasks');
Box? leaderboa = Hive.box('leaderboa');

class welcome extends StatefulWidget {
  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
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
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);

      http.Response response = await http.post(
          Uri.parse('https://realcash.nextonebox.com/CreateAccount'),
          body: {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'image':reslut.photoUrl.toString(),
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
          backgroundColor: Colors.purple,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (error) {

    }
    http.Response getleaderbord = await http.get(Uri.parse(
        'https://www.realcash.nextonebox.com/LeaderBoardReq'));
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

  signout() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  // this function is for when internet is of show alert diolog box
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  width: 200, child: Image(image: AssetImage('images/lo.png'))),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/Illustration.png'))),
                ),
              ),
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool result =
                          await InternetConnectionChecker().hasConnection;
                      if (result == true) {
                        Box? adsbox = Hive.box('adsbox');
                        adsbox.put(1, {'clicks': 0});
                        adsbox.put(2, {'lastclick': DateTime.now()});

                        adsbox.put(4, {'clicks': 0});
                        adsbox.put(3, {'lastclick': DateTime.now()});

                        adsbox.put(5, {'clicks': 0});
                        adsbox.put(6, {'lastclick': DateTime.now()});

                        adsbox.put(7, {'clicks': 0});
                        adsbox.put(8, {'lastclick': DateTime.now()});

                        adsbox.put(9, {'clicks': 0});
                        adsbox.put(10, {'lastclick': DateTime.now()});

                         signInWithGoogle();
                      } else {
                        Fluttertoast.showToast(
                            msg: "No Iternet Connection",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Card(
                      elevation: 30,
                      shadowColor: elecolor,
                      child: Container(
                        width: 360,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 50,
                                  height: 50,
                                  child:
                                      Image(image: AssetImage('images/g.png'))),
                              Text(
                                "Sign up with google",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: Colors.black),
                              )
                            ]), // child: MaterialButton(
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
