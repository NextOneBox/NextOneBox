import 'dart:async';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timer_stop_watch/timer_stop_watch.dart';
import 'widget.dart';
import 'package:hive/hive.dart';
import 'Profile_Page.dart';

// Box? trade = Hive.box('trade');
// Box? History = Hive.box('History');
// Box? TradeHistory = Hive.box('TradeHistory');
List tradehistory = [];

class History_Page extends StatefulWidget {
  const History_Page({super.key});

  @override
  State<History_Page> createState() => History_PageState();
}

class History_PageState extends State<History_Page> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: c6,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 80,
          title: Center(
            child: Text(
              "History",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: c3,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: c6,
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TabBar(
                indicatorColor: c6,
                tabs: [
                  // !------------------------------------------{Plants}
                  Tab(
                    child: Container(
                      child: Text(
                        "Active",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // !------------------------------------------{Flowers}

                  Tab(
                      child: Container(
                    child: Text(
                      "Closed",
                      style: TextStyle(color: c3, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Active_Tab(),
                  Closed_tab(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}

// !--------------------------------------------Active_Tab
class Active_Tab extends StatefulWidget {
  const Active_Tab({super.key});

  @override
  State<Active_Tab> createState() => _Active_TabState();
}

class _Active_TabState extends State<Active_Tab> {
  @override
  void initState() {
    super.initState();
  }

  bool tradehistorylenght = true;
  @override
  Widget build(BuildContext context) {
    if (tradehistory.isNotEmpty) {
      tradehistorylenght = true;
    }
    return Scaffold(
        backgroundColor: c6,
        body: ListView.builder(
          itemCount: tradehistory.length ,
          itemBuilder: (context, index) {
           
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange[600],
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: c1,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      tradehistory[index]['image'],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              sw(10),
                              // ! Name/Percentage
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tradehistory[index]['assetname'],
                                    style: TextStyle(
                                      color: c3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    tradehistory[index]['per'],
                                    style: TextStyle(
                                      color: c3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          // ! Price/earn
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    color: tradehistory[index]['buy']
                                        ? blue
                                        : Colors.red,
                                    tradehistory[index]['buy']
                                        ? Icons.arrow_upward_outlined
                                        : Icons.arrow_downward_outlined,
                                    size: 20,
                                  ),
                                  sw(5),
                                  Text(
                                    '₹${tradehistory[index]['amount']}',
                                    style: TextStyle(
                                      color: c3,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                  ]),
                ),
              );
         
          },
        ));
  }
}

// !--------------------------------------------Closed_Tab
class Closed_tab extends StatefulWidget {
  const Closed_tab({super.key});

  @override
  State<Closed_tab> createState() => _Closed_tabState();
}

class _Closed_tabState extends State<Closed_tab> {
  bool historylength = true;
  @override
  Widget build(BuildContext context) {
    if (History!.isNotEmpty) {
      historylength = true;
    }
    return Scaffold(
        floatingActionButton: SizedBox.fromSize(
          size: Size(56, 56),
          child: ClipOval(
            child: Material(
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.green,
                onTap: () {
                  setState(() {
                    History?.clear();
                  });
                },
                child: Icon(
                  Icons.delete_rounded,
                  size: 30,
                ), // <-- Icon
              ),
            ),
          ),
        ),
        backgroundColor: c6,
        body: ListView.builder(
          itemCount:  History?.length,
          itemBuilder: (context, index) {
           
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  height: 100,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: Column(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: c1,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: c3,
                                ),
                                Text(
                                  '1 minute',
                                  style: TextStyle(
                                      color: c3,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              ]),
                        )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: c1,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          // ! Main Row
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ! Image
                              Row(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          History?.get(index)['image'],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  sw(10),
                                  // ! Name/Percentage
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        History?.get(index)['assetname'],
                                        style: TextStyle(
                                          color: c3,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        History?.get(index)['per'],
                                        style: TextStyle(
                                          color: c3,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              // ! Price/earn
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        color: History?.get(index)['buy']
                                            ? blue
                                            : Colors.red,
                                        History?.get(index)['buy']
                                            ? Icons.arrow_upward_outlined
                                            : Icons.arrow_downward_outlined,
                                        size: 20,
                                      ),
                                      sw(5),
                                      Text(
                                        "₹${History?.get(index)['amount']}",
                                        style: TextStyle(
                                          color: c3,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    History?.get(index)['win']
                                        ? "+₹${History?.get(index)['wining']}"
                                        : "-₹${History?.get(index)['amount']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: History?.get(index)['win']
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ]),
                ),
              );
           
          },
        ));
  }
}

class ClosedContainer extends StatelessWidget {
  const ClosedContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.deepOrange[600],
            borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: c1,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.alarm,
                    color: c3,
                  ),
                  Text(
                    '1 minute',
                    style: TextStyle(
                        color: c3, fontWeight: FontWeight.bold, fontSize: 12),
                  )
                ]),
              )),
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: c1,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                // ! Main Row
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ! Image
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                'https://firebasestorage.googleapis.com/v0/b/mir-nursery-kehnu.appspot.com/o/tools.jpg?alt=media&token=c17933f6-6f41-4a42-97fa-116f8302cd07',
                                fit: BoxFit.cover,
                              )),
                        ),
                        sw(10),
                        // ! Name/Percentage
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Bull Market Index',
                              style: TextStyle(
                                color: c3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '75%',
                              style: TextStyle(
                                color: c3,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    // ! Price/earn
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_outlined,
                              size: 20,
                            ),
                            sw(5),
                            Text(
                              '₹1000000',
                              style: TextStyle(
                                color: c3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '+₹1300',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}

class ActiveContainer extends StatelessWidget {
  const ActiveContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.deepOrange[600],
            borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: c1,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            // ! Main Row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ! Image
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      // child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(15),
                      //     child: Image.network(
                      //       trade?.get(0)['image'],

                      //       fit: BoxFit.cover,
                      //     )),
                    ),
                    sw(10),
                    // ! Name/Percentage
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          trade?.get(0)['assetname'],
                          style: TextStyle(
                            color: c3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          trade?.get(0)['per'],
                          style: TextStyle(
                            color: c3,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                // ! Price/earn
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_downward_outlined,
                          size: 20,
                          color: c3,
                        ),
                        sw(5),
                        Text(
                          '₹ ${trade?.get(0)['price']}',
                          style: TextStyle(
                            color: c3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '+₹1300',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green),
                    )
                  ],
                ),
              ],
            ),
          )),
        ]),
      ),
    );
  }
}
