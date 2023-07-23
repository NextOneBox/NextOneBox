// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cashapp/ComonScreens/sharnow.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';

class GetPhone extends StatefulWidget {
  const GetPhone({super.key});

  @override
  State<GetPhone> createState() => _GetPhoneState();
}

class _GetPhoneState extends State<GetPhone> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationID;


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
                        const SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, bottom: 3, top: 10),
                              child: const Row(
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
                               
                                  decoration: const InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: OutlineInputBorder(),
                                    labelText: '',
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                         
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, bottom: 3, top: 10),
                          child: const Row(
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
                          margin: const EdgeInsets.only(
                              left: 20, bottom: 3, top: 10),
                          child: const Row(
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
                              decoration: const InputDecoration(
                                floatingLabelStyle: TextStyle(color: MainColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: MainColor,
                                )),
                                border: OutlineInputBorder(),
                                labelText: ' Refer code if any (optional) ',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(Icons.gif_outlined,
                                      color: MainColor),
                                ),
                              ),
                            )),
                        Container(
                          width: 200,
                          height: 40,
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
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

                    
                                if (phone.length >= 10) {
                                  {
                                    showMessage(context, 'Please wait');
                                  }

                                  http.Response response = await http.put(
                                      Uri.parse(
                                          'https://fogcash.nextonebox.com/UpdateAccount'),
                                      body: {
                                        'Email': email.toString(),
                                        'PhoneNumber': phone.toString(),
                                        'Age': agelistdropdownValue.toString(),
                                      });
                           
                             
                          if (response.reasonPhrase == 'OK') {
      SendAllData();
      Timer(const Duration(seconds: 3), () {
        setState(() {});
      });
    }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ShareNow()),
            (Route<dynamic> route) => false,
          );
     
                          
                                 
                                
                                } else {
                                  showMessage(context,
                                      'Please enter correct Phone number');
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
