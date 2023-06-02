import 'dart:async';

import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:quantupi/quantupi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  paymentkro() async {
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox@sbi',
      receiverName: 'NextOneBox CEO',
      transactionRefId: '',
      transactionNote: 'Pro version of CashApp',
      amount: 39.0,
    );
    final response = await zupi.startTransaction();
    print(response);

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
        print("Transaction status: $value");
        if (value == 'SUCCESS') {
          http.Response response = await http.post(

              // how to print current date in flutter
              Uri.parse(
                  'https://www.nextonebox.com/earnmoney/NotGetUrls/EMPremium'),
              body: {
                'email': email.toString(),
                'EMPremium': 'true',
              });

          setState(() {
            AwesomeDialog(
              context: context,
              animType: AnimType.LEFTSLIDE,
              headerAnimationLoop: false,
              dialogType: DialogType.SUCCES,
              showCloseIcon: true,
              title: 'Succes',
              desc: 'Congratulation you are upgraded please restart the app',
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              onDissmissCallback: (type) {},
            ).show();
          });
        } else {
          setState(() {
            AwesomeDialog(
              context: context,
              animType: AnimType.LEFTSLIDE,
              headerAnimationLoop: false,
              dialogType: DialogType.SUCCES,
              showCloseIcon: true,
              title: 'Failed',
              desc: ' If you have paid please contact us',
              btnOkOnPress: () {},
              btnOkIcon: Icons.check_circle,
              onDissmissCallback: (type) {},
            ).show();
          });
        }
        break;
      }
    }
  }

  CheckPayment() {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.QUESTION,
      body: Center(
        child: Column(children: [
          Text(
            '',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ]),
      ),
      keyboardAware: true,
      btnOkText: "Close Payment",
      title: '',
      padding: const EdgeInsets.all(5.0),
      onDissmissCallback: (type) {
        Navigator.of(context).pop();
      },
      btnOkOnPress: () async {
        var curl = await controller.currentUrl();
        String baseUrl = curl.toString().split('#')[1];
        if (baseUrl == 'true') {
          showMessage(context, 'Payment Success');
        } else {
          showMessage(context, 'Payment Failed ');
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );

        callnow();
        Timer(Duration(seconds: 10), () {
          SystemNavigator.pop();
        });
        setState(() {});
      },
    )..show();
  }

  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
              child: Text('Help!')),
          IconButton(
              icon: Icon(
                Icons.cancel_sharp,
                color: Colors.blue,
              ),
              onPressed: () {
                CheckPayment();
              })
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              paymentkro();
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Pay with UPI : ₹39',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      paymentkro();
                    },
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/paytm.png',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/phonepay.png',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/gpay.png',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/phmi.png',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        GFButton(
                            onPressed: () async {
                              paymentkro();

                              // var url =
                              //     'upi://pay?cu=INR&pa=nextonebox@sbi&pn=nextonebox&am=89&tn=nextonebox';
                              // if (await canLaunch(url)) {
                              //   await launch(url);
                              // }
                            },
                            color: Colors.green,
                            child: Text('Other'))
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Pay with Credit/Debit Cards etc :       ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    child: WillPopScope(
                      onWillPop: () async {
                        if (await controller.canGoBack()) {
                          controller.goBack();
                          var curl = await controller.currentUrl();
                          String baseUrl = curl.toString().split('#')[1];
                          if (baseUrl == 'true') {
                            CheckPayment();
                            return true;
                          }
                          if (baseUrl == 'false') {
                            CheckPayment();
                            return true;
                          } else {
                            return false;
                          }
                        } else {
                          CheckPayment();
                          return true;
                        }
                      },
                      child: WebView(
                        initialUrl:
                            'https://nextonebox.com/ccavRequestHandler?EMPremium=39.0+${email}-true',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) async {
                          this.controller = controller;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
