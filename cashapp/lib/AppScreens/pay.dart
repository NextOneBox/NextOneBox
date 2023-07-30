import 'dart:async';
import 'dart:math';

import 'package:cashapp/AppScreens/cosmofeed.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:quantupi/quantupi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Pay extends StatefulWidget {
  const Pay({
    super.key,
    required this.link,
    required this.price,
    required this.type,
  });

  final link;
  final price;
  final type;
  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  paymentkro() async {
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox@sbi',
      receiverName: 'NextOneBox CEO',
      transactionRefId: '',
      transactionNote: '$email',
      amount: widget.price,
    );
    final response = await zupi.startTransaction();

    List<String> keyValuePairs = response.split('&');

    for (String pair in keyValuePairs) {
      List<String> keyValuePair = pair.split('=');
      String key = keyValuePair[0];
      String value = keyValuePair[1];

      if (key == "Status") {
        if (value == 'SUCCESS') {
          facebookAppEvents.logPurchase(amount: widget.price, currency: "INR");
          if (widget.price == 69.0) {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'JackPot': 'true',
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }
            setState(() {});
          }

          if (widget.price == 99.0) {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'LuckeySpin': 10,
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }

            setState(() {});
          }

          if (widget.price == 89.0) {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'Pro': 'true',
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }

            setState(() {});
          }
          if (widget.price == 39.0) {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'MystryScrach': 'true',
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }

            setState(() {});
          }
          if (widget.price == 149.0) {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'MystryScrach': 'true',
                  'LuckeySpin': 10,
                  'JackPot': 'true',
                  'Pro': 'true',
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }

            setState(() {});
          }
          setState(() {
            QuickAlert.show(
              context: context,
              title: 'SUCCES',
              type: QuickAlertType.success,
              text: 'Congratulation you are upgraded please restart the app',
            );
            SendAllData();
            buysuccessfacebook();
          });
        } else {
          setState(() {
            QuickAlert.show(
              context: context,
              title: 'Failed',
              type: QuickAlertType.error,
              text: 'If you have paid please contact us',
            );
          });
        }
        break;
      }
    }
  }

  payint() async {
    var data =
        "Email: $email ,Name: $name, Price: ₹${widget.price} ,Phone:$phonenumber ,Date: ${DateTime.now().toString()}";

    http.Response response = await http
        .post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'), body: {
      'message': data.toString(),
    });
  }

  @override
  void initState() {
    super.initState();
    paymentkro();
    payint();
  }

  @override
  Widget build(BuildContext context) {
    addtocartfacebook();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUs()),
                );
              },
              child: const Text('Help!')),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              paymentkro();

              facebookAppEvents.logAddToCart(
                id: Random().nextInt(100).toString(),
                type: 'product${widget.price}',
                price: widget.price,
                currency: 'INR',
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '   Pay Fast With  UPI :',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Row(
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
                        const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.navigate_next_rounded,
                              color: Colors.green,
                              size: 40,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CosmoFeed(
                          data: widget.link.toString(),
                          price: widget.price,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '   Pay With Card|Wallet|NetBanking :\n',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/card.png',
                        width: 500,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
