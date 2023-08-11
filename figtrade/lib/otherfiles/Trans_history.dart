import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:figtrade/widget.dart';

import '../Profile_Page.dart';

class trans_history extends StatefulWidget {
  const trans_history({super.key});

  @override
  State<trans_history> createState() => trans_historyState();
}

class trans_historyState extends State<trans_history> {
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
              "Transcation History",
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
                        "Deposit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // !------------------------------------------{Flowers}

                  Tab(
                      child: Container(
                    child: Text(
                      "Withdraw",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: c6,
        body: ListView.builder(
          itemCount: transhistory?.length,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                 "${transhistory?.get(index)['time']}",
                                  style: TextStyle(
                                    color: c3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                 "${transhistory?.get(index)['date']}",
                                  style: TextStyle(
                                    color: c3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Deposit',
                              style: TextStyle(
                                color: c3,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        // ! Price/earn
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "+₹${transhistory?.get(index)['amount']}",
                                  style: TextStyle(
                                    color: c3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                               "${transhistory?.get(index)['status']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  
                                  color:transhistory?.get(index)['sucess']? Colors.green:Colors.red),
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: c6,
        body: ListView.builder(
          itemCount: transwithdralhistory?.length,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${transwithdralhistory?.get(index)['time']}",
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${transwithdralhistory?.get(index)['date']}",
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Withdraw',
                                  style: TextStyle(
                                    color: c3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            // ! Price/earn
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "-₹${transwithdralhistory?.get(index)['amount']}",
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${transwithdralhistory?.get(index)['status']}",
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
