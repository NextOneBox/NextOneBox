import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ipl/home.dart';
import 'package:ipl/promo.dart';
import 'package:quantupi/quantupi.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

Box user = Hive.box('user');

class _PaymentPageState extends State<PaymentPage> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: MaterialButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          height: 60,
                          textColor: Colors.white,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            try {
                              Quantupi zupi = Quantupi(
                                receiverUpiId: 'nextonebox.95618657@sbi',
                                receiverName: 'NextOneBox CEO',
                                transactionRefId: '',
                                transactionNote: 'Pro',
                                amount: 149,
                              );
                              final response = await zupi.startTransaction();
                              List<String> keyValuePairs = response.split('&');
                              for (String pair in keyValuePairs) {
                                List<String> keyValuePair = pair.split('=');
                                String key = keyValuePair[0];
                                String value = keyValuePair[1];
                                if (key == "Status") {
                                  if (value == 'SUCCESS') {
                                    dynamic email = user.get(0)['email'];
                                    String formattedDate =
                                        "${now.year}${now.month + 1}${now.day}";
                                    http.Response response = await http.put(
                                        Uri.parse(
                                            'https://realcash.nextonebox.com/winners/UpdateAccount'),
                                        body: {
                                          'email': email.toString(),
                                          'plan': formattedDate.toString(),
                                        });
                                    if (response.reasonPhrase == 'OK') {
                                      await user.clear();
                                      var da = jsonDecode(response.body);
                                      await user.add(da);
                                    }

                                    setState(() {
                                      QuickAlert.show(
                                        context: context,
                                        title: 'SUCCES',
                                        type: QuickAlertType.success,
                                        text:
                                            'Congratulation you are upgraded please restart the app',
                                      );
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  } else {
                                    setState(() {
                                      QuickAlert.show(
                                        context: context,
                                        title: 'Failed',
                                        type: QuickAlertType.error,
                                        text:
                                            'If you have paid please contact us',
                                      );
                                    });
                                  }
                                  break;
                                }
                              }
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Please select a UPI app for payment. \n Or no UPI app found in device .')));
                            }
                          },
                          child: Text(' Monthly    ₹149/- '),
                        ),
                        MaterialButton(
                          height: 60,
                          textColor: Colors.white,
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () async {
                            try {
                              Quantupi zupi = Quantupi(
                                receiverUpiId: 'nextonebox.95618657@sbi',
                                receiverName: 'NextOneBox CEO',
                                transactionRefId: '',
                                transactionNote: 'Pro',
                                amount: 299,
                              );
                              final response = await zupi.startTransaction();
                              List<String> keyValuePairs = response.split('&');
                              for (String pair in keyValuePairs) {
                                List<String> keyValuePair = pair.split('=');
                                String key = keyValuePair[0];
                                String value = keyValuePair[1];
                                if (key == "Status") {
                                  if (value == 'SUCCESS') {
                                    dynamic email = user.get(0)['email'];
                                    String formattedDate =
                                        "${now.year + 1}${now.month}${now.day}";
                                    http.Response response = await http.put(
                                        Uri.parse(
                                            'https://realcash.nextonebox.com/winners/UpdateAccount'),
                                        body: {
                                          'email': email.toString(),
                                          'plan': formattedDate.toString(),
                                        });
                                    await user.clear();
                                    var da = jsonDecode(response.body);
                                    await user.add(da);
                                    setState(() {
                                      QuickAlert.show(
                                        context: context,
                                        title: 'SUCCES',
                                        type: QuickAlertType.success,
                                        text:
                                            'Congratulation you are upgraded please restart the app',
                                      );
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  } else {
                                    setState(() {
                                      QuickAlert.show(
                                        context: context,
                                        title: 'Failed',
                                        type: QuickAlertType.error,
                                        text:
                                            'If you have paid please contact us',
                                      );
                                    });
                                  }
                                  break;
                                }
                              }
                            } catch (error) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Please select a UPI app for payment. \n Or no UPI app found in device .')));
                            }
                          },
                          child: Text(' Yearly    ₹299/- '),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 350,
                      height: 70,
                      child: MaterialButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () async {
                          try {
                            Quantupi zupi = Quantupi(
                              receiverUpiId: 'nextonebox.95618657@sbi',
                              receiverName: 'NextOneBox CEO',
                              transactionRefId: '',
                              transactionNote: 'Pro',
                              amount: 499,
                            );
                            final response = await zupi.startTransaction();
                            List<String> keyValuePairs = response.split('&');
                            for (String pair in keyValuePairs) {
                              List<String> keyValuePair = pair.split('=');
                              String key = keyValuePair[0];
                              String value = keyValuePair[1];
                              if (key == "Status") {
                                if (value == 'SUCCESS') {
                                  dynamic email = user.get(0)['email'];
                                  String formattedDate =
                                      "${now.year + 10}${now.month}${now.day}";
                                  http.Response response = await http.put(
                                      Uri.parse(
                                          'https://realcash.nextonebox.com/winners/UpdateAccount'),
                                      body: {
                                        'email': email.toString(),
                                        'plan': formattedDate.toString(),
                                      });
                                  await user.clear();
                                  var da = jsonDecode(response.body);
                                  await user.add(da);
                                  setState(() {
                                    QuickAlert.show(
                                      context: context,
                                      title: 'SUCCES',
                                      type: QuickAlertType.success,
                                      text:
                                          'Congratulation you are upgraded please restart the app',
                                    );
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                } else {
                                  setState(() {
                                    QuickAlert.show(
                                      context: context,
                                      title: 'Failed',
                                      type: QuickAlertType.error,
                                      text:
                                          'If you have paid please contact us',
                                    );
                                  });
                                }
                                break;
                              }
                            }
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    'Please select a UPI app for payment. \n Or no UPI app found in device .')));
                          }
                        },
                        child: Text(' LifeTime  ₹499/- '),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: Text(
            'Start with just ₹149/- only',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          color: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Flexible(
            child: Container(
              child: WebView(
                initialUrl: 'https://www.nextonebox.com/lovecash',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) async {
                  this.controller = controller;
                },
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Promo()),
                );
              },
              child: Text('Have a promo code'))
        ],
      ),
    );
  }
}
