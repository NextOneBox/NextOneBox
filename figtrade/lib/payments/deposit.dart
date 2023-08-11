import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quantupi/quantupi.dart';

import '../Profile_Page.dart';
import '../otherfiles/Trans_history.dart';
import 'package:figtrade/widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:http/http.dart' as http;

class Deposit_page extends StatefulWidget {
  const Deposit_page({super.key});

  @override
  State<Deposit_page> createState() => _Deposit_pageState();
}

class _Deposit_pageState extends State<Deposit_page> {
  final FacebookAppEvents facebookAppEvents = FacebookAppEvents();

  paymentkro() async {
    //  transhistory?.clear();?
    DateTime now = DateTime.now();
    String monthName = DateFormat.MMMM().format(now); // Get month name
    String date = DateFormat.d().format(now); // Get date
    String hour = DateFormat.H().format(now); // Get hour in 24-hour format
    String minute = DateFormat.m().format(now); // Get minute
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox.97041493@sbi',
      receiverName: 'FigTrade',
      transactionRefId: '',
      transactionNote: '',
      amount: sendamount?.get('depositamount'),
    );
    final response = await zupi.startTransaction();

    // Split the response string into individual key-value pairs
    List<String> keyValuePairs = response.split('&');

    // Iterate over each key-value pair
    for (String pair in keyValuePairs) {
      // Split the pair into key and value
      List<String> keyValuePair = pair.split('=');
      String key = keyValuePair[0];
      String value = keyValuePair[1];

      // Check if the key is "Status"
      if (key == "Status") {
        if (value == 'SUCCESS') {
          setState(() {
            RealDemo?.put('real', sendamount?.get('depositamount'));
            transhistory?.add({
              "amount": sendamount?.get('depositamount'),
              "date": "$monthName $date",
              "time": "$hour:$minute",
              "status": 'Sucess',
              'sucess': true
            });
            facebookAppEvents.logPurchase(
              amount: sendamount?.get('depositamount'),
              currency: 'INR',
            );
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              transitionAnimationDuration: Duration(seconds: 0),
              dialogType: DialogType.success,
              showCloseIcon: true,
              title: 'Succes',
              desc: 'Congratulation you Sucessfuly added Fund',
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {},
            ).show();

            payint();
          });
        } else {
          facebookAppEvents.logAddToCart(
            currency: 'INR',
            price: sendamount?.get('depositamount'),
            type: '',
            id: '',
          );
          Fluttertoast.showToast(
              msg: "Transaction Faild",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: c6,
              textColor: c3,
              fontSize: 16.0);
          transhistory?.add({
            'sucess': false,
            "amount": sendamount?.get('depositamount'),
            "date": "$monthName $date",
            "time": "$hour:$minute",
            "status": 'Failure',
          });
        }
        break; // Exit the loop since we have found the Status key
      }
    }
  }

  payint() async {
    await http
        .post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'), body: {
      'message': "${userdata?.get(0)['email']}",
    });
  }

  bool hundred = false;
  bool two = false;
  bool three = true;
  bool five = false;
  bool eight = false;
  bool sixteen = false;
  bool thirty = false;
  bool fifty = false;
  bool sixty = false;
  bool seventy = false;
  bool eighty = false;
  bool ninety = false;

  double height = 55;
  double width = 110;

  @override
  Widget build(BuildContext context) {
    var bctff = Color.fromARGB(255, 32, 32, 42);
    var concolor = Color.fromARGB(255, 55, 55, 78);
    var txcolor = Color.fromARGB(255, 38, 106, 243);
    var amountcontroller = TextEditingController(
        text: sendamount?.get('depositamount').toString());
    return Scaffold(
        bottomNavigationBar: Container(
          color: bctff,
          height: 57,
          child: GestureDetector(
              onTap: () {
                if (double.parse(amountcontroller.text) < 69) {
                  Fluttertoast.showToast(
                      msg: "Mini Deposit is ₹69",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: c6,
                      textColor: c3,
                      fontSize: 16.0);
                } else {
                  setState(() {
                    sendamount?.put(
                        'depositamount', double.parse(amountcontroller.text));
                  });
                  paymentkro();
                }
              },
              child: Container(
                  child: Center(
                      child: Text(
                    'Deposit',
                    style: TextStyle(
                        fontSize: 17, color: c3, fontWeight: FontWeight.bold),
                  )),
                  decoration: BoxDecoration(
                      color: buttoncolor,
                      borderRadius: BorderRadius.circular(8)))),
        ),
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => trans_history()));
                },
                child: Icon(
                  Icons.history,
                ))
          ],
          automaticallyImplyLeading: false,
          leading: BackButton(color: c3),
          title: Text(
            'Deposit',
            style: textstyle,
          ),
          centerTitle: true,
          backgroundColor: c6,
        ),
        backgroundColor: c6,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text('Deposit amount', style: textstyle),
                    sh(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('69'));
                              hundred = true;
                              two = false;
                              three = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: 55,
                            width: 110,
                            child: Center(
                                child: Text(
                              '₹69',
                              style: TextStyle(
                                  color: hundred ? txcolor : Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: hundred ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: hundred ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: hundred ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: hundred ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: concolor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('79'));
                              two = true;
                              hundred = false;
                              three = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹79',
                              style: TextStyle(
                                color: two ? txcolor : Colors.white,
                              ),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: two ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: two ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: two ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: two ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('89'));
                              three = true;
                              hundred = false;
                              two = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹89',
                              style: TextStyle(color: three ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: three ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: three ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: three ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: three ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //////.........SecondRow............
                    sh(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('99'));
                              hundred = false;
                              two = false;
                              three = false;
                              five = true;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹99',
                              style: TextStyle(color: five ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: five ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: five ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: five ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: five ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('129'));
                              two = false;
                              hundred = false;

                              three = false;
                              five = false;
                              eight = true;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹129',
                              style: TextStyle(color: eight ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: eight ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: eight ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: eight ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: eight ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('149'));
                              three = false;
                              hundred = false;
                              two = false;
                              five = false;
                              eight = false;
                              sixteen = true;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹149',
                              style: TextStyle(color: sixteen ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: sixteen ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: sixteen ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: sixteen ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: sixteen ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sh(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('500'));
                              hundred = false;
                              two = false;
                              three = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = true;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹500',
                              style: TextStyle(color: thirty ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: thirty ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: thirty ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: thirty ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: thirty ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('1000'));
                              two = false;
                              hundred = false;

                              three = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = true;
                              sixty = false;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹1000',
                              style: TextStyle(color: fifty ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: fifty ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: fifty ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: fifty ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: fifty ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('2000'));
                              three = false;
                              hundred = false;
                              two = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = true;
                              seventy = false;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹2000',
                              style: TextStyle(color: sixty ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: sixty ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: sixty ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: sixty ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: sixty ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sh(20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('3000'));
                              hundred = false;
                              two = false;
                              three = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = true;
                              eighty = false;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹3000',
                              style: TextStyle(color: seventy ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: seventy ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: seventy ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: seventy ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: seventy ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('5000'));
                              two = false;
                              hundred = false;

                              three = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;
                              seventy = false;
                              eighty = true;
                              ninety = false;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹5000',
                              style: TextStyle(color: eighty ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: eighty ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: eighty ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: eighty ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: eighty ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sendamount?.put(
                                  'depositamount', double.parse('7000'));
                              three = false;
                              hundred = false;
                              two = false;
                              five = false;
                              eight = false;
                              sixteen = false;
                              thirty = false;
                              fifty = false;
                              sixty = false;

                              seventy = false;
                              eighty = false;
                              ninety = true;
                            });
                          },
                          child: Container(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              '₹7000',
                              style: TextStyle(color: ninety ? txcolor : c3),
                            )),
                            decoration: BoxDecoration(
                              color: concolor,
                              border: Border(
                                bottom: BorderSide(
                                  color: ninety ? txcolor : c3,
                                ),
                                top: BorderSide(
                                  color: ninety ? txcolor : c3,
                                ),
                                left: BorderSide(
                                  color: ninety ? txcolor : c3,
                                ),
                                right: BorderSide(
                                  color: ninety ? txcolor : c3,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    sh(20),

                    ///.........TextFormField.......
                    Container(
                      // height: 50,
                      decoration: BoxDecoration(
                          color: bctff,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: amountcontroller,
                        keyboardType: TextInputType.number,
                        cursorColor: c3,
                        autocorrect: true,
                        style: textstyle,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            color: Color.fromARGB(255, 3, 129, 231),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter Deposit Amount',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 128, 123, 123),
                          ),
                        ),
                        onFieldSubmitted: (value) => sendamount?.put(
                            'depositamount',
                            double.parse(amountcontroller.text)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Box? account = Hive.box('account');
}
