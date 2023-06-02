import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_openmoney/flutter_openmoney.dart';
import 'package:http/http.dart' as http;

class NewPay extends StatefulWidget {
  const NewPay({Key? key}) : super(key: key);

  @override
  State<NewPay> createState() => _NewPayState();
}

class _NewPayState extends State<NewPay> {
  late final FlutterOpenmoney flutterOpenmoney;

  @override
  void initState() {
    super.initState();

    flutterOpenmoney = FlutterOpenmoney();
    flutterOpenmoney.on(
      FlutterOpenmoney.eventPaymentSuccess,
      _handlePaymentSuccess,
    );
    flutterOpenmoney.on(
      FlutterOpenmoney.eventPaymentError,
      _handlePaymentError,
    );
  }

  void _initPayment() async {
    var url =
        Uri.parse('https://sandbox-icp-api.bankopen.co/api/payment_token');

    var payload = {
      "amount": "99.00",
      "contact_number": "9682524922",
      "email_id": "shahid@gmail.com",
      "currency": "INR",
      "mtx": "234213764",
   
    };

    var headers = {
      "accept": "application/json",
      "content-type": "application/json",
      "Authorization": "Bearer 68df1430-df05-11ed-a344-8b18a109c69c"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(payload),
    );

    print(response.body);

    /// get from openmoney dashboard
    const accessKey = '5354daa0-df06-11ed-82f8-2dcb9a8b8a08';

    /// Generated using openmoney create token api in server
    /// refer https://docs.bankopen.com/reference/generate-token
    var paymentToken = response.body.toString();
    final options = PaymentOptions(accessKey, paymentToken);

    try {
      flutterOpenmoney.initPayment(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(
    //   msg: 'SUCCESS: ${response.paymentId}',
    //   toastLength: Toast.LENGTH_LONG,
    // );
    print('don');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(
    //   msg: 'ERROR: ${response.code} - ${response.message}',
    //   toastLength: Toast.LENGTH_LONG,
    // );
    print('error');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('FlutterOpenmoney Plugin example app'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _initPayment,
                child: const Text('initPayment'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
