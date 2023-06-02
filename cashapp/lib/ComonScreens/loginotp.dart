import 'package:cashapp/ComonScreens/getphone.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';

class LoginOtp extends StatefulWidget {
  LoginOtp({super.key, required this.data});
  final data;
  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

var loco = Color.fromARGB(255, 0, 0, 0);

class _LoginOtpState extends State<LoginOtp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otpCont = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 200, left: 30, bottom: 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/Nob.png',
                    fit: BoxFit.fill,
                    height: 50,
                  ),
                  Text(
                    'NextOneBox',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40, left: 30),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Enter otp send to \n ' '${widget.data}',
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScr()),
                          );
                        },
                        icon: Icon(
                          Icons.edit_note_outlined,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: otpCont,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: loco,
                          )),
                          border: OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: loco),
                          labelText: 'Otp',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.insert_comment_sharp,
                              color: loco,
                            ),
                          )),
                    ),
                  ),
                  GFButton(
                    onPressed: () async {
                      {
                        showMessage(context, 'Please wait');
                      }

                      http.Response response = await http.post(
                          Uri.parse(
                              'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
                          body: {
                            'email': widget.data,
                            'otp': otpCont.text,
                            'name': 'user'
                          });

                      if (response.body == 'Login') {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigation()),
                          (Route<dynamic> route) => false,
                        );
                        dynamic dat = {
                          'email': widget.data.toString(),
                          'name': 'user',
                          'Ballance': '0',
                          'EMPremium': 'true',
                          'Refercode': '..'
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
                          MaterialPageRoute(
                              builder: (context) => GetPhone()),
                          (Route<dynamic> route) => false,
                        );
                        dynamic dat = {
                          'email': widget.data.toString(),
                          'name': 'user',
                          'Ballance': '0',
                          'EMPremium': 'false',
                          'Refercode': '..'
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
                      {
                        showMessage(context, response.body);
                      }
                    },
                    color: loco,
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    text: 'n e x t',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
