import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:figtrade/History_Page.dart';
import 'widget.dart';
import 'dart:async';

import 'Charts/fl_charts.dart';
import 'Profile_Page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'payments/deposit.dart';

class Home_Page extends StatefulWidget {
  Home_Page({super.key, this.Widget});
  final Widget;
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String monthName = DateFormat.MMMM().format(now); // Get month name
    String date = DateFormat.d().format(now); // Get date
    String hour = DateFormat.H().format(now); // Get hour in 24-hour format
    String minute = DateFormat.m().format(now); // Get minute
    String seconds = DateFormat.s().format(now); // Get sec
    bool assetslected = assets?.get('assetslected');
    var cashcontroller =
        TextEditingController(text: "${RealDemo?.get('tradeamount')}");
    return SafeArea(
        child: Scaffold(
      backgroundColor: c6,
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 300,
                            decoration: BoxDecoration(
                                color: c6,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Column(children: [
                              sh(10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 5,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2)),
                                ),
                              ),
                              sh(40),
                              // !------------------------------------------------------------------------{Row 1}
                              Container(
                                color: c6,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              sw(13),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    RealDemo?.put(0, false);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: c3,
                                                            width: 2),
                                                        color: RealDemo?.get(0)
                                                            ? c6
                                                            : Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50))),
                                              ),
                                              sw(10),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    RealDemo?.put(0, false);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text(
                                                  'REAL ACCOUNT',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),

                                          // !------------------------------------------------------------------------{Create}

                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            child: Text(
                                              'Balance:  ₹ ${RealDemo?.get("real")}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: c3),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      Deposit_page())));
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: buttoncolor,
                                              width: 3,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'Deposit',
                                            style: textstyle,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                          );
                        },
                      );
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        RealDemo?.get(0) ? 'DEMO ACCOUNT' : "REAL ACCOUNT",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                RealDemo?.get(0) ? Colors.red : Colors.green),
                      ),
                      Row(
                        children: [
                          Text(
                            RealDemo?.get(0)
                                ? '₹ ${RealDemo?.get("demo")}'
                                : '₹ ${RealDemo?.get("real")}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // !------------------------------------------------------------------------{deposit}

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Deposit_page())));
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: buttoncolor,
                      border: Border.all(
                        color: buttoncolor,
                        width: 3,
                      ),
                    ),
                    child: Center(child: Text('Deposit', style: textstyle)),
                  ),
                ),
              ],
            ),
          ),
        ),

        ///////...........ASSESTS.......////
        Expanded(
          flex: 15,
          child: Column(
            children: [
              sh(15),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: c6,
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          Container(
                            height: 5,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    account?.put(
                                      0,
                                      {
                                        'name': data[index]['name'],
                                        'image': data[index]['image'],
                                        'link': data[index]['link'],
                                        'per': data[index]['percentage']
                                      },
                                    );
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: c6,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      sh(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${data[index]['image']}"),
                                          ),
                                          Text(
                                            '${data[index]['name']}',
                                            style: textstyle,
                                          ),
                                          Text(
                                            '${data[index]['percentage']}',
                                            style: textstyle,
                                          ),
                                        ],
                                      ),
                                      Divider(color: c3, thickness: 1),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },

                ///////........SLECT ASSET FOR TRADE....../////
                child: Row(
                  children: [
                    // ! Image
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              assetslected
                                  ? account?.get(0)['image']
                                  : 'https://t4.ftcdn.net/jpg/05/11/11/67/360_F_511116703_djZ9CLaCKJQIja8iRIoZ2MThVcTbT5OS.jpg',
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    // ! Column
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ! EUR-USD/ICON
                        Row(
                          children: [
                            Text(
                              assetslected ? account?.get(0)['name'] : 'BTC',
                              style: textstyle,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: c3,
                            )
                          ],
                        ),
                        // ! 75% container
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 25,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: buttoncolor, width: 2),
                            ),
                            child: Center(
                                child: Text(
                              assetslected ? account?.get(0)['per'] : '90%',
                              style: textstyle,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              sh(30),
              Expanded(
                child: Container(
                  child: assetslected
                      ? fl_charts()
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  assets?.put('assetslected', true);
                                  account?.put(
                                    0,
                                    {
                                      'name': data[index]['name'],
                                      'image': data[index]['image'],
                                      'link': data[index]['link'],
                                      'per': data[index]['percentage']
                                    },
                                  );
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: c6,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: [
                                    sh(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "${data[index]['image']}"),
                                        ),
                                        Text(
                                          '${data[index]['name']}',
                                          style: textstyle,
                                        ),
                                        Text(
                                          '${data[index]['percentage']}',
                                          style: textstyle,
                                        ),
                                      ],
                                    ),
                                    Divider(color: c3, thickness: 1),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
              sh(10),

              ////............SLECT AMOUNT .......////
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: c6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              // !------------------------------------------------------------------------{Sell}
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    if (int.parse(cashcontroller.text) > 19) {
                                      var minus =
                                          int.parse(cashcontroller.text) - 20;
                                      setState(() {
                                        RealDemo?.put(
                                            'tradeamount', minus.toString());
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 25,
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.minus,
                                      size: 15,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              ),
                              // !------------------------------------------------------------------------{Sell}

                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.only(left: 25),
                                    height: 25,
                                    decoration: BoxDecoration(),
                                    child: Center(
                                        child: TextFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      cursorColor: c3,
                                      onFieldSubmitted: (value) =>
                                          RealDemo?.put('tradeamount',
                                              cashcontroller.text),
                                      controller: cashcontroller,
                                      keyboardType: TextInputType.number,
                                    )),
                                  ),
                                ),
                              ),
                              // !------------------------------------------------------------------------{Sell}
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    var plus =
                                        int.parse(cashcontroller.text) + 20;
                                    setState(() {
                                      RealDemo?.put(
                                          'tradeamount', plus.toString());
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.plus,
                                      size: 15,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        sw(5),
                        Expanded(
                            child: Container(
                          height: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey, width: 2)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Time 1m',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.white)),
                              ]),
                        )),
                      ],
                    ),

                    sh(5),
/////...................TRADE PLACE BUTTON................////
                    ///...............Demo slected................
                    RealDemo?.get(0)
                        ? Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  if (RealDemo?.get('demo') < 19 ||
                                      int.parse(cashcontroller.text) >
                                          RealDemo?.get('demo')) {
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.info,
                                      buttonsBorderRadius:
                                          BorderRadius.circular(10),
                                      animType: AnimType.bottomSlide,
                                      btnOkColor: buttoncolor,
                                      btnCancelText: "Skip",
                                      btnOkText: "Refill",
                                      title: 'Your account balance is low',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                          'Please Add balance to countinue trade',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  } else {
                                    if (int.parse(cashcontroller.text) < 20 ||
                                        int.parse(cashcontroller.text) > 3000) {
                                      Fluttertoast.showToast(
                                          msg: "Mini amount is 20 max is 3000",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: c6,
                                          textColor: c3,
                                          fontSize: 16.0);
                                    } else {
                                      if (horizontalLines.length > 4) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You can place 4 trade at a time in demo acount",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: c6,
                                            textColor: c3,
                                            fontSize: 16.0);
                                      } else {
                                        var indexxx = trade?.get('index1');
                                        var indexx = indexxx + 1;
                                        setState(() {
                                          sendamount?.put(
                                              1, cashcontroller.text);
                                        });

                                        addHorizontalLinescall();

                                        setState(() {
                                          //...minus trade amount from balance
                                          var minus = RealDemo?.get('demo') -
                                              int.parse(cashcontroller.text);
                                          RealDemo?.put('demo', minus);
                                          trade?.put(indexx,
                                              Datachart!.last.y.toDouble());
                                          trade?.put('index1', indexx);
                                          tradehistory.add({
                                            'assetname':
                                                account?.get(0)['name'],
                                            'buy': true,
                                            'amount':
                                                cashcontroller.text.toString(),
                                            'image': account?.get(0)['image'],
                                            'per': account?.get(0)['per'],
                                          });

                                          /////....RESULT AFTER 1 MINUTE..UP...
                                          Future.delayed(Duration(seconds: 59),
                                              () {
                                            tradehistory.removeAt(0);
                                            if (Datachart!.last.y.toDouble() >
                                                trade?.get(indexx)) {
                                              var amm = cashcontroller.text
                                                  .toString();
                                              var amoun = int.parse(amm);
                                              var perr = account
                                                  ?.get(0)['per']
                                                  .toString();
                                              var finalper =
                                                  perr!.replaceAll('%', '');
                                              var persent = int.parse(finalper);
                                              double percentage =
                                                  (amoun / 100) * persent;
                                              var winingamount =
                                                  amoun + percentage;
                                              History?.add({
                                                'assetname':
                                                    account?.get(0)['name'],
                                                'buy': true,
                                                'amount': cashcontroller.text
                                                    .toString(),
                                                'image':
                                                    account?.get(0)['image'],
                                                'per': account?.get(0)['per'],
                                                'wining': '$winingamount',
                                                'win': true
                                              });

                                              RealDemo?.put(
                                                  'demo',
                                                  RealDemo?.get('demo') +
                                                      winingamount.toInt());
                                              AwesomeDialog(
                                                context: context,
                                                animType: AnimType.leftSlide,
                                                headerAnimationLoop: false,
                                                transitionAnimationDuration:
                                                    Duration(seconds: 0),
                                                dialogType: DialogType.success,
                                                showCloseIcon: true,
                                                title: 'Profit',
                                                descTextStyle: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 30),
                                                desc: '+₹${winingamount}',
                                                btnOkOnPress: () {
                                                  debugPrint('OnClcik');
                                                },
                                                btnOkIcon: Icons.check_circle,
                                                onDismissCallback: (type) {},
                                              ).show();
                                              setState(() {});
                                            } else {
                                              History?.add({
                                                'assetname':
                                                    account?.get(0)['name'],
                                                'buy': true,
                                                'amount': cashcontroller.text
                                                    .toString(),
                                                'image':
                                                    account?.get(0)['image'],
                                                'per': account?.get(0)['per'],
                                                'wining': cashcontroller.text
                                                    .toString(),
                                                'win': false
                                              });
                                              AwesomeDialog(
                                                context: context,
                                                animType: AnimType.leftSlide,
                                                headerAnimationLoop: false,
                                                transitionAnimationDuration:
                                                    Duration(seconds: 0),
                                                dialogType: DialogType.success,
                                                showCloseIcon: true,
                                                title: 'Lose',
                                                descTextStyle: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 30),
                                                desc:
                                                    '-₹${cashcontroller.text.toString()}',
                                                btnOkOnPress: () {
                                                  debugPrint('OnClcik');
                                                },
                                                btnOkIcon: Icons.check_circle,
                                                onDismissCallback: (type) {},
                                              ).show();
                                            }
                                          });
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue),
                                  child: Center(
                                    child: Text(
                                      'UP',
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              sw(5),
                              // ------------------------------------------------------------------------{Sell}
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  if (RealDemo?.get('demo') < 19 ||
                                      int.parse(cashcontroller.text) >
                                          RealDemo?.get('demo')) {
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.info,
                                      buttonsBorderRadius:
                                          BorderRadius.circular(10),
                                      animType: AnimType.bottomSlide,
                                      btnOkColor: buttoncolor,
                                      btnCancelText: "Skip",
                                      btnOkText: "Refill",
                                      title: 'Your account balance is low',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                          'Please Add balance to countinue trade',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {},
                                    ).show();
                                  } else {
                                    if (int.parse(cashcontroller.text) < 20 ||
                                        int.parse(cashcontroller.text) > 3000) {
                                      Fluttertoast.showToast(
                                          msg: "Mini amount is 20 max is 3000",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: c6,
                                          textColor: c3,
                                          fontSize: 16.0);
                                    } else {
                                      if (horizontalLines.length > 4) {
                                        Fluttertoast.showToast(
                                            msg:
                                                "You can place 4 trade at a time in demo acount",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: c6,
                                            textColor: c3,
                                            fontSize: 16.0);
                                      } else {
                                        addHorizontalLinesput();
                                        // History?.clear();
                                        // trade?.put('index1', 1);
                                        var indexxx = trade?.get('index1');
                                        var indexx = indexxx + 1;

                                        setState(() {
                                          //...minus trade amount from balance
                                          var minus = RealDemo?.get('demo') -
                                              int.parse(cashcontroller.text);
                                          RealDemo?.put('demo', minus);
                                          trade?.put(indexx,
                                              Datachart!.last.y.toDouble());
                                          trade?.put('index1', indexx);
                                          tradehistory.add({
                                            'assetname':
                                                account?.get(0)['name'],
                                            'buy': false,
                                            'amount':
                                                cashcontroller.text.toString(),
                                            'image': account?.get(0)['image'],
                                            'per': account?.get(0)['per'],
                                          });

                                          ///.............RESULT AFTER 1 MINUTE.................////
                                          Future.delayed(Duration(seconds: 59),
                                              () {
                                            tradehistory.removeAt(0);
                                            if (Datachart!.last.y.toDouble() <
                                                trade?.get(indexx)) {
                                              debugPrint('win');
                                              print(
                                                  Datachart!.last.y.toDouble());
                                              var amm = cashcontroller.text
                                                  .toString();
                                              var amoun = int.parse(amm);
                                              var perr = account
                                                  ?.get(0)['per']
                                                  .toString();
                                              var finalper =
                                                  perr!.replaceAll('%', '');
                                              var persent = int.parse(finalper);

                                              double percentage =
                                                  (amoun / 100) * persent;
                                              var winingamount =
                                                  amoun + percentage;
                                              History?.add({
                                                'assetname':
                                                    account?.get(0)['name'],
                                                'buy': false,
                                                'amount': cashcontroller.text
                                                    .toString(),
                                                'image':
                                                    account?.get(0)['image'],
                                                'per': account?.get(0)['per'],
                                                'wining': '$winingamount',
                                                'win': true
                                              });
                                              RealDemo?.put(
                                                  'demo',
                                                  RealDemo?.get('demo') +
                                                      winingamount.toInt());
                                              AwesomeDialog(
                                                context: context,
                                                animType: AnimType.leftSlide,
                                                headerAnimationLoop: false,
                                                transitionAnimationDuration:
                                                    Duration(seconds: 0),
                                                dialogType: DialogType.success,
                                                showCloseIcon: true,
                                                title: 'Profit',
                                                descTextStyle: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 30),
                                                desc:
                                                    '+₹${winingamount.toString()}',
                                                btnOkOnPress: () {
                                                  debugPrint('OnClcik');
                                                },
                                                btnOkIcon: Icons.check_circle,
                                                onDismissCallback: (type) {},
                                              ).show();
                                              setState(() {});
                                            } else {
                                              History?.add({
                                                'assetname':
                                                    account?.get(0)['name'],
                                                'buy': false,
                                                'amount': cashcontroller.text
                                                    .toString(),
                                                'image':
                                                    account?.get(0)['image'],
                                                'per': account?.get(0)['per'],
                                                'wining': cashcontroller.text
                                                    .toString(),
                                                'win': false
                                              });
                                              AwesomeDialog(
                                                context: context,
                                                animType: AnimType.leftSlide,
                                                headerAnimationLoop: false,
                                                transitionAnimationDuration:
                                                    Duration(seconds: 0),
                                                dialogType: DialogType.success,
                                                showCloseIcon: true,
                                                title: 'Lose',
                                                descTextStyle: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 30),
                                                desc:
                                                    '-₹${cashcontroller.text.toString()}',
                                                btnOkOnPress: () {
                                                  debugPrint('OnClcik');
                                                },
                                                btnOkIcon: Icons.check_circle,
                                                onDismissCallback: (type) {},
                                              ).show();
                                            }
                                          });
                                        });
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      'Down',
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          )
                        :

                        ///...............Real account slected................
                        Row(
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  // result();

                                  if (RealDemo?.get('real') < 19 ||
                                      int.parse(cashcontroller.text) >
                                          RealDemo?.get('real')) {
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.info,
                                      buttonsBorderRadius:
                                          BorderRadius.circular(10),
                                      animType: AnimType.bottomSlide,
                                      btnOkColor: buttoncolor,
                                      btnCancelText: "Skip",
                                      btnOkText: "Deposit",
                                      title: 'Your account balance is low',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                          'Please Add balance to countinue trade',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    Deposit_page())));
                                      },
                                    ).show();
                                  } else {
                                    if (int.parse(cashcontroller.text) < 20 ||
                                        int.parse(cashcontroller.text) > 3000) {
                                      Fluttertoast.showToast(
                                          msg: "Mini amount is 20 max is 3000",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: c6,
                                          textColor: c3,
                                          fontSize: 16.0);
                                    } else {
                                      addHorizontalLinescall();

                                      var indexxx = trade?.get('index1');
                                      var indexx = indexxx + 1;
                                      setState(() {
                                        //...minus trade amount from balance
                                        var minus = RealDemo?.get('real') -
                                            int.parse(cashcontroller.text);
                                        RealDemo?.put('real', minus);

                                        trade?.put(indexx,
                                            Datachart!.last.y.toDouble());
                                        trade?.put('index1', indexx);
                                        tradehistory.add({
                                          'assetname': account?.get(0)['name'],
                                          'buy': true,
                                          'amount':
                                              cashcontroller.text.toString(),
                                          'image': account?.get(0)['image'],
                                          'per': account?.get(0)['per'],
                                        });

                                        ///.....RESULT AFTER 1 MINUTE.....///
                                        Future.delayed(Duration(seconds: 60),
                                            () {
                                          tradehistory.removeAt(0);
                                          if (Datachart!.last.y.toDouble() >
                                              trade?.get(indexx)) {
                                            var amm =
                                                cashcontroller.text.toString();
                                            var amoun = int.parse(amm);
                                            var perr = account
                                                ?.get(0)['per']
                                                .toString();
                                            var finalper =
                                                perr!.replaceAll('%', '');
                                            var persent = int.parse(finalper);
                                            double percentage =
                                                (amoun / 100) * persent;
                                            var winingamount =
                                                amoun + percentage;
                                            History?.add({
                                              'assetname':
                                                  account?.get(0)['name'],
                                              'buy': true,
                                              'amount': cashcontroller.text
                                                  .toString(),
                                              'image': account?.get(0)['image'],
                                              'per': account?.get(0)['per'],
                                              'wining': '$winingamount',
                                              'win': true
                                            });
                                            RealDemo?.put(
                                                'real',
                                                RealDemo?.get('real') +
                                                    winingamount.toInt());

                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.leftSlide,
                                              headerAnimationLoop: false,
                                              transitionAnimationDuration:
                                                  Duration(seconds: 0),
                                              dialogType: DialogType.success,
                                              showCloseIcon: true,
                                              title: 'Profit',
                                              descTextStyle: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 30),
                                              desc:
                                                  '+₹${winingamount.toString()}',
                                              btnOkOnPress: () {
                                                debugPrint('OnClcik');
                                              },
                                              btnOkIcon: Icons.check_circle,
                                              onDismissCallback: (type) {},
                                            ).show();
                                            setState(() {});
                                          } else {
                                            History?.add({
                                              'assetname':
                                                  account?.get(0)['name'],
                                              'buy': true,
                                              'amount': cashcontroller.text
                                                  .toString(),
                                              'image': account?.get(0)['image'],
                                              'per': account?.get(0)['per'],
                                              'wining': cashcontroller.text
                                                  .toString(),
                                              'win': false
                                            });
                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.leftSlide,
                                              headerAnimationLoop: false,
                                              transitionAnimationDuration:
                                                  Duration(seconds: 0),
                                              dialogType: DialogType.success,
                                              showCloseIcon: true,
                                              title: 'Lose',
                                              descTextStyle: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 30),
                                              desc:
                                                  '-₹${cashcontroller.text.toString()}',
                                              btnOkOnPress: () {
                                                debugPrint('OnClcik');
                                              },
                                              btnOkIcon: Icons.check_circle,
                                              onDismissCallback: (type) {},
                                            ).show();
                                          }
                                        });
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blue),
                                  child: Center(
                                    child: Text(
                                      'UP',
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                              sw(5),
                              // ------------------------------------------------------------------------{Sell}
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  RealDemo?.put('tradecash',
                                      int.parse(cashcontroller.text));
                                  if (RealDemo?.get('real') < 19 ||
                                      int.parse(cashcontroller.text) >
                                          RealDemo?.get('real')) {
                                    AwesomeDialog(
                                      context: context,
                                      keyboardAware: true,
                                      dismissOnBackKeyPress: false,
                                      dialogType: DialogType.info,
                                      buttonsBorderRadius:
                                          BorderRadius.circular(10),
                                      animType: AnimType.bottomSlide,
                                      btnOkColor: buttoncolor,
                                      btnCancelText: "Skip",
                                      btnOkText: "Deposit",
                                      title: 'Your account balance is low',
                                      // padding: const EdgeInsets.all(5.0),
                                      desc:
                                          'Please Add balance to countinue trade',
                                      btnCancelOnPress: () {},
                                      btnOkOnPress: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    Deposit_page())));
                                      },
                                    ).show();
                                  } else {
                                    if (int.parse(cashcontroller.text) < 20 ||
                                        int.parse(cashcontroller.text) > 3000) {
                                      Fluttertoast.showToast(
                                          msg: "Mini amount is 20 Max is 3000",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: c6,
                                          textColor: c3,
                                          fontSize: 16.0);
                                    } else {
                                      addHorizontalLinesput();
                                      var indexxx = trade?.get('index1');
                                      var indexx = indexxx + 1;
                                      setState(() {
                                        //...minus trade amount from balance
                                        var minus = RealDemo?.get('real') -
                                            int.parse(cashcontroller.text);
                                        RealDemo?.put('real', minus);

                                        trade?.put(indexx,
                                            Datachart!.last.y.toDouble());
                                        trade?.put('index1', indexx);
                                        tradehistory.add({
                                          'assetname': account?.get(0)['name'],
                                          'buy': false,
                                          'amount':
                                              cashcontroller.text.toString(),
                                          'image': account?.get(0)['image'],
                                          'per': account?.get(0)['per'],
                                        });
                                        ////result after one minute
                                        Future.delayed(Duration(seconds: 59),
                                            () {
                                          tradehistory.removeAt(0);
                                          if (Datachart!.last.y.toDouble() <
                                              trade?.get(indexx)) {
                                            var amm =
                                                cashcontroller.text.toString();
                                            var amoun = int.parse(amm);
                                            var perr = account
                                                ?.get(0)['per']
                                                .toString();
                                            var finalper =
                                                perr?.replaceAll('%', '');
                                            var persent = int.parse(finalper!);

                                            double percentage =
                                                (amoun / 100) * persent;
                                            var winingamount =
                                                amoun + percentage;
                                            History?.add({
                                              'assetname':
                                                  account?.get(0)['name'],
                                              'buy': false,
                                              'amount': cashcontroller.text
                                                  .toString(),
                                              'image': account?.get(0)['image'],
                                              'per': account?.get(0)['per'],
                                              'wining': '$winingamount',
                                              'win': true
                                            });
                                            RealDemo?.put(
                                                'real',
                                                RealDemo?.get('real') +
                                                    winingamount.toInt());

                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.leftSlide,
                                              headerAnimationLoop: false,
                                              transitionAnimationDuration:
                                                  Duration(seconds: 0),
                                              dialogType: DialogType.success,
                                              showCloseIcon: true,
                                              title: 'Profit',
                                              descTextStyle: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 30),
                                              desc:
                                                  '+₹${winingamount.toString()}',
                                              btnOkOnPress: () {
                                                debugPrint('OnClcik');
                                              },
                                              btnOkIcon: Icons.check_circle,
                                              onDismissCallback: (type) {},
                                            ).show();
                                            setState(() {});
                                          } else {
                                            print('lose');
                                            print(Datachart!.last.y.toDouble());
                                            History?.add({
                                              'assetname':
                                                  account?.get(0)['name'],
                                              'buy': false,
                                              'amount': cashcontroller.text
                                                  .toString(),
                                              'image': account?.get(0)['image'],
                                              'per': account?.get(0)['per'],
                                              'wining': cashcontroller.text
                                                  .toString(),
                                              'win': false
                                            });

                                            AwesomeDialog(
                                              context: context,
                                              animType: AnimType.leftSlide,
                                              headerAnimationLoop: false,
                                              transitionAnimationDuration:
                                                  Duration(seconds: 0),
                                              dialogType: DialogType.success,
                                              showCloseIcon: true,
                                              title: 'Lose',
                                              descTextStyle: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 30),
                                              desc:
                                                  '-₹${cashcontroller.text.toString()}',
                                              btnOkOnPress: () {
                                                debugPrint('OnClcik');
                                              },
                                              btnOkIcon: Icons.check_circle,
                                              onDismissCallback: (type) {},
                                            ).show();
                                          }
                                        });
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      'Down',
                                      style: TextStyle(
                                        color: c3,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // !------------------------------------------------------------------------{Sell}
      ]),
    ));
  }

  // result() {
  //   return  AwesomeDialog(
  //     context: context,
  //     animType: AnimType.leftSlide,
  //     headerAnimationLoop: false,
  //     transitionAnimationDuration: Duration(seconds: 0),
  //     dialogType: DialogType.success,
  //     showCloseIcon: true,
  //     dialogBackgroundColor: c6,
  //     body:
  //   Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     CircleAvatar(
  //                       backgroundImage:
  //                       NetworkImage(account?.get(0)['image']),
  //                     ),
  //                     sw(3),
  //                     Text(
  //                       account?.get(0)['name'],
  //                       style: textstyle,
  //                     ),
  //                     Icon(
  //                       color: alertdata?.get(index)['buy']
  //                           ? blue
  //                           : Colors.red,
  //                       alertdata?.get(index)['buy']
  //                           ? Icons.arrow_upward_outlined
  //                           : Icons.arrow_downward_outlined,
  //                       size: 20,
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       alertdata2?.get(index)['win']?
  //                       "+₹${alertdata2?.get(index)['wining']}"
  //                           : "-₹${alertdata2?.get(index)['amount']}",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.bold, color: green),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //             sh(10),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Invest Amount',
  //                   style: textstyle,
  //                 ),
  //                 Text(
  //                   '₹${alertdata?.get(index)['amount']}',
  //                   style: textstyle,
  //                 )
  //               ],
  //             ),
  //             Divider(
  //               color: c3,
  //             ),
  //             // sh(10),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Invest Account', style: textstyle),
  //                 Text('demo', style: textstyle)
  //               ],
  //             ),
  //             // sh(10),
  //             Divider(
  //               color: c3,
  //               thickness: 0.50,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Opening price', style: textstyle),
  //                 Text( '${alertdata?.get(index)['opening price']}', style: textstyle)
  //               ],
  //             ),
  //             // sh(10),
  //             Divider(
  //               color: c3,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('opening time', style: textstyle),
  //                 Text( '${alertdata?.get(index)['opening time']}', style: textstyle)
  //               ],
  //             ),
  //             Divider(
  //               color: c3,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Closing price', style: textstyle),
  //                 Text('${alertdata2?.get(index)['closing price']}', style: textstyle)
  //               ],
  //             ),
  //             Divider(
  //               color: c3,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text('Closing time', style: textstyle),
  //                 Text('${alertdata2?.get(index)['closing time']}', style: textstyle)
  //               ],
  //             ),]),
  //
  //
  //     // title: 'Succes',
  //     // desc: 'Congratulation you Sucessfuly added Fund',
  //     btnOkOnPress: () {
  //
  //       alertdata2?.clear();
  //       alertdata?.clear();
  //       debugPrint('OnClcik');
  //     },
  //     btnOkIcon: Icons.check_circle,
  //     onDismissCallback: (type) {},
  //   ).show();
  //   //   showDialog(
  //   //   context: context,
  //   //   builder: (BuildContext context) {
  //   //     return AlertDialog(
  //   //       backgroundColor: c6,
  //   //       actions: [
  //   //         Container(
  //   //           width: MediaQuery.of(context).size.width / 1.4,
  //   //           child: Column(
  //   //             children: [
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Row(
  //   //                     children: [
  //   //                       CircleAvatar(
  //   //                         backgroundImage:
  //   //                             NetworkImage(account?.get(0)['image']),
  //   //                       ),
  //   //                       sw(3),
  //   //                       Text(
  //   //                         account?.get(0)['name'],
  //   //                         style: textstyle,
  //   //                       ),
  //   //                       Icon(
  //   //                         Icons.arrow_upward_outlined,
  //   //                         color: blue,
  //   //                       )
  //   //                     ],
  //   //                   ),
  //   //                   Row(
  //   //                     children: [
  //   //                       Text(
  //   //                         '+54',
  //   //                         style: TextStyle(
  //   //                             fontWeight: FontWeight.bold, color: green),
  //   //                       )
  //   //                     ],
  //   //                   )
  //   //                 ],
  //   //               ),
  //   //               sh(10),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text(
  //   //                     'Invest Amount',
  //   //                     style: textstyle,
  //   //                   ),
  //   //                   Text(
  //   //                     '',
  //   //                     style: textstyle,
  //   //                   )
  //   //                 ],
  //   //               ),
  //   //               Divider(
  //   //                 color: c3,
  //   //               ),
  //   //               // sh(10),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text('Invest Account', style: textstyle),
  //   //                   Text('demo', style: textstyle)
  //   //                 ],
  //   //               ),
  //   //               // sh(10),
  //   //               Divider(
  //   //                 color: c3,
  //   //                 thickness: 0.50,
  //   //               ),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text('Opening price', style: textstyle),
  //   //                   Text('505216.0', style: textstyle)
  //   //                 ],
  //   //               ),
  //   //               // sh(10),
  //   //               Divider(
  //   //                 color: c3,
  //   //               ),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text('opening time', style: textstyle),
  //   //                   Text('02:45:51', style: textstyle)
  //   //                 ],
  //   //               ),
  //   //               Divider(
  //   //                 color: c3,
  //   //               ),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text('Closing price', style: textstyle),
  //   //                   Text('505216.0', style: textstyle)
  //   //                 ],
  //   //               ),
  //   //               Divider(
  //   //                 color: c3,
  //   //               ),
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   //                 children: [
  //   //                   Text('Closding time', style: textstyle),
  //   //                   Text('02:45:51', style: textstyle)
  //   //                 ],
  //   //               ),
  //   //               Divider(
  //   //                 color: c3,
  //   //               ),
  //   //               GestureDetector(
  //   //                   onTap: () {
  //   //                     Navigator.pop(context);
  //   //                   },
  //   //                   child: Container(
  //   //                       child: Center(
  //   //                           child: Text(
  //   //                         'OK',
  //   //                         style: textstyle,
  //   //                       )),
  //   //                       width: 250,
  //   //                       height: 45,
  //   //                       decoration: BoxDecoration(
  //   //                           color: buttoncolor,
  //   //                           borderRadius: BorderRadius.circular(8))))
  //   //             ],
  //   //           ),
  //   //         )
  //   //       ],
  //   //     );
  //   //   },
  //   // );
  // }
}
