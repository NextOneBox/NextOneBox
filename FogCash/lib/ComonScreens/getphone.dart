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
  @override
  void initState() {
    super.initState();
    SendAllData();
  }

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
                              var refercode = refercodegetcontr.text;
                              http.Response response = await http.put(
                                  Uri.parse(
                                      'https://fogcash.nextonebox.com/referupdate'),
                                  body: {
                                    'ReferCode': refercode.toString(),
                                  });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavigation()),
                                (Route<dynamic> route) => false,
                              );
                            },
                            text: "Next  |   Skip",
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
