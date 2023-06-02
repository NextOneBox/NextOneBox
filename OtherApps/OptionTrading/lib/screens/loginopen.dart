import 'package:futuretrading/screens/getphone.dart';
import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class LoginScr extends StatefulWidget {
  LoginScr({super.key});

  @override
  State<LoginScr> createState() => _LoginScrState();
}

var lc = BackColor;

class _LoginScrState extends State<LoginScr> {
  Box? tasks = Hive.box('tasks');
  TextEditingController emailCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
              'email': 'shahidmir9682@gmail.com',
              'name': 'shahid',
              'otp': 'googleotplogin',
              // 'email': reslut.email.toString(),
              // 'name': reslut.displayName.toString(),
              // 'otp': 'googleotplogin',
            });

        if (response.body == 'Login') {
          SendAllData();
          dynamic dat = {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'Ballance': '0',
            'Refercode': '..',
          };
          await localballance!.put(0, 0);
          await user.add(dat);
          await adsbox!.put(4, {'clicks': 0});
          await adsbox!.put(3, {'lastclick': DateTime.now()});
          await adsbox!.put(10, {'dailygift': DateTime.now()});
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
            (Route<dynamic> route) => false,
          );
          Timer(Duration(seconds: 15), () async {
            SystemNavigator.pop();
          });
        }

        if (response.body == 'account created') {
          SendAllData();
          dynamic dat = {
            'email': reslut.email.toString(),
            'name': reslut.displayName.toString(),
            'Ballance': '0',
            'Refercode': '..',
          };
          await localballance!.put(0, 0);
          await user.add(dat);
          await adsbox!.put(4, {'clicks': 0});
          await adsbox!.put(3, {'lastclick': DateTime.now()});
          await adsbox!.put(10, {'dailygift': DateTime.now()});

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
          'https://www.nextonebox.com/futuretrading/NotGetUrls/AppTasks',
          tasks!),
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
                          controller: emailCont,
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
                              .hasMatch(emailCont.text)) {
                            {
                              showMessage(context, 'Please wait');
                            }

                            http.Response response = await http.post(
                                Uri.parse(
                                    'https://www.nextonebox.com/futuretrading/NotGetUrls/AppCreateAccountNew'),
                                body: {
                                  'email': emailCont.text,
                                  'otp': '',
                                  'name': 'user'
                                });

                            print(response.body);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginOtp(
                                      data: emailCont.text.toString())),
                            );
                          } else {
                            {
                              showMessage(
                                  context, 'Pleace enter correct email Id');
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
                      color: lc,
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
