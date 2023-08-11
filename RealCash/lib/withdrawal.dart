import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quantupi/quantupi.dart';
import 'package:test1/SuperSpin.dart';
import 'package:test1/withdrawalhistory.dart';
import 'HomePage.dart';
import 'Colors.dart';
import 'package:http/http.dart' as http;
import 'Widget.dart';

class withdrawal extends StatefulWidget {
  withdrawal({
    super.key,
  });

  @override
  State<withdrawal> createState() => _withdrawalState();
}

class _withdrawalState extends State<withdrawal> {
  var allcoin = account!.get(0)['Ballance'];

  var accountnumber = TextEditingController();
  var amountcontroller = TextEditingController();

  final __formkey = GlobalKey<FormState>();
  DateTime pre_backpress = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var paypal = false;
  var paytm = true;
  bool upgraded = limits?.get('pro');
  paymentkro() async {
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox.51084093@sbi',
      receiverName: 'NextOneBox CEO',
      transactionRefId: '',
      transactionNote: '${account!.get(0)['name']}',
      amount: 89,
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
            limits?.put('pro', true);
            limits?.put('watchad', 20);
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              showCloseIcon: true,
              title: 'Succes',
              desc: 'Congratulation you are upgraded please restart the app',
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {},
            ).show();
          });

          http.Response response = await http
              .put(Uri.parse('https://realcash.nextonebox.com/pro'), body: {
            'email': account!.get(0)['email'].toString(),
            'Pro': 'true',
          });

          await http.post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'),
              body: {
                'message': "${account!.get(0)['email']}",
              });
        }
        break; // Exit the loop since we have found the Status key
      }
    }
  }

  bool superlocked = superspin?.get('superunlocked');
  bool vip = VIP?.get('VIP');

  VipPaymentkro() async {
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox.51084093@sbi',
      receiverName: 'NextOneBox CEO',
      transactionRefId: '',
      transactionNote: '${account!.get(0)['name']}',
      amount: 149,
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
            superspin?.put('superunlocked', true);
            superspin?.put('luckspinbalance', 50);
            adsbox?.put(40, {'clicks': 0});
            superspin?.put('click', 0);
            limits?.put('watchad', 35);

            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              showCloseIcon: true,
              title: 'Succes',
              desc: 'Congratulation you are upgraded please restart the app',
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {},
            ).show();
          });

          await http.put(Uri.parse('https://realcash.nextonebox.com/superSpin'),
              body: {
                'email': account!.get(0)['email'].toString(),
                'SuperSpin': 'true',
              });

          await http.put(Uri.parse('https://realcash.nextonebox.com/luckySpin'),
              body: {
                'email': account!.get(0)['email'].toString(),
                'LuckySpin': '100',
              });

          await http.post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'),
              body: {
                'message': "${account!.get(0)['email']}",
              });
        }
        break; // Exit the loop since we have found the Status key
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var as = account!.get(0)['Ballance'];
    var a = int.parse(as);
    var b = a / 10;
    var dollor = a / 810;
    var dol = dollor.toString().split('.');
    var dolor = dol[0];

    return Scaffold(
      backgroundColor: white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            color: c6,
            height: 60,
            child: GestureDetector(
                onTap: () async {
                  if (__formkey.currentState!.validate()) {
                    var ammont = amountcontroller.text.trim();
                    var amountt = int.parse(ammont);
                    var coin = int.parse(allcoin);
                    if (amountt > coin) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: c6,
                          content: Text(
                            'Please enter Amount less than current Balance',
                            style: textstyle,
                          )));
                    } else if (coin > 2499 && amountt > 249) {
                      if (upgraded == true) {
                        if (VIP?.get('VIP') == true) {
                          if (account!.get(0)['completed'] == 'true') {
                            var requestamount =
                                int.parse(amountcontroller.text) * 10;
                            http.Response response = await http.post(
                                Uri.parse(
                                    'https://realcash.nextonebox.com/AddWidrawRequest'),
                                body: {
                                  'email': account!.get(0)['email'].toString(),
                                  'amount': requestamount.toString(),
                                  'accountnumber':
                                      accountnumber.text.toString(),
                                });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: c6,
                                  content: Text(
                                    '${response.body}',
                                    style: textstyle,
                                  )),
                            );
                            Navigator.pop(context);
                            amountcontroller.clear();
                            accountnumber.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: c6,
                                  content: Text(
                                      '1.  Pro Completed   ✅  \n2.  Vip completed  ✅ \n3.  Last step Complete atleast 8 Task to withdraw your money  ⌛\n\n\n\nFor more information read Term&Condition Carefully\n\n\n\n',
                                      style: textstyle)),
                            );
                          }
                        } else {
                          AwesomeDialog(
                            context: context,
                            keyboardAware: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            btnCancelText: "Cancel",
                            btnOkText: "pay ₹149",
                            body: Center(
                                child: Column(
                              children: [
                                Text(
                                  'Became VIP at just ₹149\n',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    '✅ Instant withdraw Your money\n'
                                    '✅ 50 watch ads per day\n'
                                    '✅ Super Spin Unlocked\n'
                                    '✅ Lucky Spin Unlocked\n'
                                    '✅ 24/7 Costumer Support\n'
                                    '✅ Unlimted Spin\n'
                                    '✅ Unlimted Scratch\n'
                                    '✅ Daily withdraw upto ₹1000',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600))
                              ],
                            )),
                            btnCancelOnPress: () {
                              Fluttertoast.showToast(
                                  msg: "You missed the big earning opportunity",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            },
                            btnOkOnPress: () {
                              VipPaymentkro();
                            },
                          ).show();
                        }
                      } else {
                        bool result =
                            await InternetConnectionChecker().hasConnection;
                        if (result == true) {
                          AwesomeDialog(
                            context: context,
                            keyboardAware: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            btnCancelText: "Cancel",
                            btnOkText: "Upgrade",
                            body: Center(
                                child: Text(
                              'Upgrade Your plan to get Your withdraw.\n\n'
                              'Upgrade Pro at just ₹89\n'
                              '✅ Instant withdraw Your money\n'
                              '✅ 30 watch ads per day\n'
                              '✅ Unlimted Spin \n'
                              '✅ Unlimted Scratch \n'
                              '✅ No Ads\n'
                              '✅ Instant Task Tracking\n'
                              '✅ Daily withdraw',
                            )),
                            btnCancelOnPress: () {
                              Fluttertoast.showToast(
                                  msg: "You missed the big earning opportunity",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            },
                            btnOkOnPress: () {
                              paymentkro();
                            },
                          ).show();
                        } else {
                          Fluttertoast.showToast(
                              msg: "No Iternet Connection",
                              toastLength: Toast.LENGTH_SHORT,
                              backgroundColor: c1,
                              textColor: c6,
                              fontSize: 16.0);
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: c6,
                          content: Text(
                            'Reach the minimum payout ₹250',
                            style: textstyle,
                          )));
                    }
                  }
                },
                child: Container(
                    child: Center(
                        child: Text(
                      'Withdraw',
                      style: TextStyle(
                          fontSize: 17, color: c6, fontWeight: FontWeight.bold),
                    )),
                    decoration: BoxDecoration(
                        color: c1, borderRadius: BorderRadius.circular(8))))),
      ),
//! App Bar-----------------------------------------------{Started}-------------
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => withdrawalhistory()));
                },
                child: Icon(
                  Icons.history,
                  color: c1,
                  size: 30,
                )),
          )
        ],
      ),
//! App Bar--------------------------------------------------{Ends}-------------

      body: SingleChildScrollView(
          child: Form(
        key: __formkey,
        child: Column(
          children: [
            Column(
              children: [
                sh(10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                paypal = false;
                              });
                              setState(() {
                                if (paytm == false) {
                                  paytm = true;
                                }
                              });
                            },
                            child: Container(
                              width: 100,
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Upi',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: paytm ? c6 : Colors.black),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: paytm ? c1 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border: const Border(
                                    bottom: BorderSide(
                                        color: Colors.blue, width: 2),
                                    top: BorderSide(
                                        color: Colors.blue, width: 2),
                                    left: BorderSide(
                                        color: Colors.blue, width: 2),
                                    right: BorderSide(
                                        color: Colors.blue, width: 2),
                                  )),
                            ),
                          ),

                          ///Gpauy
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                paytm = false;
                              });
                              setState(() {
                                if (paypal == false) {
                                  paypal = true;
                                }
                              });
                            },
                            child: Container(
                              child: Center(
                                child: Text(
                                  'paypal',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: paypal ? c6 : Colors.black),
                                ),
                              ),
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: paypal ? c1 : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border: const Border(
                                    bottom: BorderSide(
                                        color: Colors.blue, width: 2),
                                    top: BorderSide(
                                        color: Colors.blue, width: 2),
                                    left: BorderSide(
                                        color: Colors.blue, width: 2),
                                    right: BorderSide(
                                        color: Colors.blue, width: 2),
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      sh(20),
                      Center(
                        child: Text(
                          'Your Balance',
                        ),
                      ),
                      Center(
                        child: Text(
                          paypal
                              ? "\$${dolor.toString()}"
                              : "₹${b.toString()}" '',
                          style: TextStyle(
                              color: c3,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      sh(20),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return paypal
                                ? 'Enter paypal ID'
                                : paytm
                                    ? 'Enter Upi Id'
                                    : '';
                          }
                          return null;
                        },
                        controller: accountnumber,
                        cursorColor: c3,
                        autocorrect: true,
                        style: textstyle,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Set border corner radius
                            borderSide: BorderSide(
                                color: Colors.blue), // Set border color
                          ),
                          hintText: paypal
                              ? 'Enter paypal ID'
                              : paytm
                                  ? 'Enter Upi Id'
                                  : '',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 128, 123, 123),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Amount';
                          }
                          return null;
                        },
                        controller: amountcontroller,
                        keyboardType: TextInputType.number,
                        cursorColor: c6,
                        autocorrect: true,
                        style: textstyle,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Set border corner radius
                            borderSide: BorderSide(
                                color: Colors.blue), // Set border color
                          ),
                          hintText: 'Enter Withdrawal Amount',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 128, 123, 123),
                          ),
                        ),
                      ),
                      Text(
                        'Minimium withdrwal is ₹250 ',
                        style: TextStyle(color: c3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
