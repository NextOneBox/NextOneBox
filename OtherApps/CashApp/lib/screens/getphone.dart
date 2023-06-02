import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class GetPhone extends StatefulWidget {
  @override
  State<GetPhone> createState() => _GetPhoneState();
}

class _GetPhoneState extends State<GetPhone> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationID;

  showdi() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.info,
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
          int getammount = 10;

          int Ballance = localballance!.get(0);
          int newBall = (Ballance + getammount);
          localballance!.put(0, newBall);
          http.Response resp = await http.post(
              Uri.parse(
                  'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
              body: {
                'email': email.toString(),
                'Ballance': getammount.toString(),
              });

          Timer(Duration(seconds: 5), () {
            setState(() {
              {
                showMessage(context, 'You have earned your reward');
              }
            });
          });

          var url = 'https://www.instagram.com/nextonebox/';
          if (await canLaunch(url)) {
            await launch(url);
          }
          Timer(Duration(seconds: 20), () {
            setState(() {
              AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.info,
                  body: Center(
                    child: Text(
                      'Subscribe us on Youtube \n\n\n Get instant 10 Coins \n\n Get latest updates',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  keyboardAware: true,
                  btnOkText: "Follow",
                  title: 'Follow us on Youtube',
                  padding: const EdgeInsets.all(5.0),
                  btnCancelOnPress: () {},
                  btnOkOnPress: () async {
                    var url = 'https://www.youtube.com/@nextonebox';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                    int getammount = 10;

                    int Ballance = localballance!.get(0);
                    int newBall = (Ballance + getammount);
                    localballance!.put(0, newBall);
                    http.Response resp = await http.post(
                        Uri.parse(
                            'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
                        body: {
                          'email': email.toString(),
                          'Ballance': getammount.toString(),
                        });

                    Timer(Duration(seconds: 5), () {
                      setState(() {
                        {
                          showMessage(context, 'You have earned your reward');
                        }
                      });
                    });
                  })
                ..show();
            });
          });
        })
      ..show();
    ;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController refercodegetcontr = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 20, bottom: 3, top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '+91',
                                            style: TextStyle(
                                                fontSize: 18, color: MainColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, bottom: 3, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Gender           ',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              DropdownButtonExample(),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, bottom: 3, top: 10),
                          child: Row(
                            children: [
                              Text(
                                'Date of Birth (Year)     ',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SlectAge(),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 20),
                            child: TextField(
                              controller: refercodegetcontr,
                              decoration: InputDecoration(
                                floatingLabelStyle: TextStyle(color: MainColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: MainColor,
                                )),
                                border: const OutlineInputBorder(),
                                labelText: ' Refer code if any (optional) ',
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(Icons.gif_outlined,
                                      color: MainColor),
                                ),
                              ),
                            )),
                        Container(
                          width: 200,
                          height: 40,
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: GFButton(
                            shape: GFButtonShape.pills,
                            size: GFSize.LARGE,
                            color: MainColor,
                            fullWidthButton: true,
                            textStyle: const TextStyle(
                              fontSize: 25,
                            ),
                            onPressed: () async {
                              var phone = phoneController.text;

                              var refercode = refercodegetcontr.text;

                              if (refercode == '$Refercode') {
                                {
                                  showMessage(context,
                                      'Please enter Correct refer code');
                                }
                              } else {
                                if (phone.length == 10) {
                                  {
                                    showMessage(context, 'Please wait');
                                  }
                                  http.Response response = await http.post(
                                      Uri.parse(
                                          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppAccountUpdateSignup'),
                                      body: {
                                        'gender':
                                            genderlistdropdownValue.toString(),
                                        'email': email.toString(),
                                        'phone': phone.toString(),
                                        'age': agelistdropdownValue.toString(),
                                        'referby': refercode.toString(),
                                      });

                                  if (response.body ==
                                      'Setting updated with refer code') {
                                    {
                                      showMessage(context, 'You have earn 10');
                                    }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation()),
                                    );
                                    SendAllData();
                                  } else {
                                    {
                                      showMessage(context, response.body);
                                    }
                                    dynamic dat = {
                                      'email': email.toString(),
                                      'name': name.toString(),
                                      'phonenumber': phone.toString(),
                                      'Ballance': '0',
                                      'Refercode': '...',
                                    };
                                    await user.clear();
                                    await user.add(dat);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation()),
                                    );

                                    showdi();
                                  }
                                } else {
                                  _loadingWidget(context,
                                      'Please enter 10 digit Phone number');
                                }
                              }
                            },
                            text: "Next",
                          ),
                        ),
                      ],
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
}

Widget _loadingWidget(BuildContext context, message) {
  return Flushbar(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    backgroundColor: Colors.black,
    margin: EdgeInsets.all(20),
    duration: Duration(seconds: 3),
  )..show(context);
}

const List<String> genderlist = <String>[
  "Select",
  'Male',
  'Female',
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

String genderlistdropdownValue = genderlist.first;

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: genderlistdropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      underline: Container(
        height: 2,
        color: MainColor,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          genderlistdropdownValue = value!;
        });
      },
      items: genderlist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

const List<String> agelist = <String>[
  "Select",
  "2023",
  " 2022",
  " 2021",
  " 2020",
  " 2019",
  " 2018",
  " 2017",
  " 2016",
  " 2015",
  " 2014",
  " 2013",
  " 2012",
  " 2011",
  " 2010",
  " 2009",
  " 2008",
  " 2007",
  " 2006",
  " 2005",
  " 2004",
  " 2003",
  " 2002",
  " 2001",
  " 2000",
  " 1999",
  " 1998",
  " 1997",
  " 1996",
  " 1995",
  " 1994",
  " 1993",
  " 1992",
  " 1991",
  " 1990",
  " 1989",
  " 1988",
  " 1987",
  " 1986",
  " 1985",
  " 1984",
  " 1983",
  " 1982",
  " 1981",
  " 1980",
  " 1979",
  " 1978",
  " 1977",
  " 1976",
  " 1975",
  " 1974",
  " 1973",
  " 1972",
  " 1971",
  " 1970"
];

class SlectAge extends StatefulWidget {
  const SlectAge({super.key});

  @override
  State<SlectAge> createState() => _SlectAgeState();
}

String agelistdropdownValue = agelist.first;

class _SlectAgeState extends State<SlectAge> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownButton<String>(
        value: agelistdropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        underline: Container(
          height: 2,
          color: MainColor,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            agelistdropdownValue = value!;
          });
        },
        items: agelist.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
