import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:youget/utils.dart';
import 'HomePage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class withdrawalhistory extends StatefulWidget {
  const withdrawalhistory({Key? key}) : super(key: key);

  @override
  State<withdrawalhistory> createState() => _withdrawalhistoryState();
}

var email = account!.get(0)['email'];
Box? widrawreq = Hive.box('widrawreq');
getwidreq() async {
  http.Response getwithdrareq = await http.get(
      Uri.parse('https://realcash.nextonebox.com/ShowWidrawStatus?$email'));
  if (getwithdrareq.reasonPhrase == 'OK') {
    await widrawreq!.clear();
    var da = jsonDecode(getwithdrareq.body);
    for (var a in da) {
      await widrawreq!.add(a);
    }
  }
}

// var widshow = widrawreq?.values.toList();

class _withdrawalhistoryState extends State<withdrawalhistory> {
  @override
  void initState() {
    super.initState();
    getwidreq();
  }

  var textstyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 15);
  DateTime pre_backpress = DateTime.now();
  var widshow = widrawreq?.values.toList();
  DatabaseReference dbRef = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    // getwidreq();
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: white,
          title: const Text(
            "Payout History",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('No withdrawal request yet.'),
          ),
        )

        );
  }
}
