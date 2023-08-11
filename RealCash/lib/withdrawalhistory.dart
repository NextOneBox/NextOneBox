import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'HomePage.dart';
import 'Colors.dart';
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
  http.Response getwithdrareq = await http
      .get(Uri.parse('https://realcash.nextonebox.com/ShowWidrawStatus?$email'));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widshow!.length,
                      itemBuilder: (context, index) {
                       
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 100,
                              // width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Date'),
                                      Text('${widshow![index]['date']}',
                                          style: textstyle),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Amount'),
                                      Text(
                                        '₹${widshow![index]['amount']}',
                                        style: textstyle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Status'),
                                      Container(
                                          child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.green[500],
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        height: 30,
                                        child: Center(
                                            child: Text(
                                                '${widshow![index]['status']}',
                                                style: textstyle)),
                                        // Icon(Icons.check_circle,color: Colors.blue,)
                                      )
                                          //   :Container(
                                          // padding: EdgeInsets.symmetric(horizontal: 10),
                                          // decoration: BoxDecoration(
                                          //     color: Colors.green[100],
                                          //     borderRadius: BorderRadius.circular(40)
                                          // ),
                                          // height: 30,
                                          // child: Row(
                                          //   children: [
                                          //     Text('processing',style: textstyle),
                                          //     SizedBox(width: 5,),
                                          //     Icon(Icons.lock_clock,color: Colors.green,)
                                          //   ],))

                                          )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                        // !
                      }),
                ),
                // if (_bannerAd != null)
                //  Align(
                //  alignment: Alignment.topCenter,
                //  child: Container(
                //  width: _bannerAd!.size.width.toDouble(),
                //  height: _bannerAd!.size.height.toDouble(),
                //  child: AdWidget(ad: _bannerAd!),
                //  ),
                //  ),
              ],
            )),
      ),
    );
  }
}
