import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ipl/home.dart';
import 'package:quantupi/quantupi.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Promo extends StatefulWidget {
  const Promo({super.key});

  @override
  State<Promo> createState() => _PromoState();
}

class _PromoState extends State<Promo> {
  TextEditingController account = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var colors;
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 200,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextFormField(
            controller: account,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              floatingLabelStyle: TextStyle(
                color: Colors.white24,
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.white24,
              )),
              border: OutlineInputBorder(),
              hintText: "Promo Code",
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Container(
            width: 300,
            height: 50,
            color: Colors.green,
            child: TextButton(
              onPressed: () {
                if (account.text == 'googlepromocode1') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No promo code found')));
                }
              },
              child: Text(
                'Check',
              ),
            ))
      ],
    ));
  }
}
