import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CosmoFeed extends StatefulWidget {
  const CosmoFeed({super.key, required this.data, this.price});
  final data;
  final price;
  @override
  State<CosmoFeed> createState() => _CosmoFeedState();
}

class _CosmoFeedState extends State<CosmoFeed> {
  late WebViewController controller;

  // BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  CheckPayment() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigation()),
    );

    var curl = await controller.currentUrl();

    if (curl != widget.data.toString()) {
      facebookAppEvents.logPurchase(amount: widget.price, currency: "INR");
      if (widget.price == 139.0) {
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
      if (widget.price == 19.0) {
        http.Response response = await http.put(
            Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
            body: {
              'Email': email.toString(),
              'SlotMachine': 'true',
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
      showMessage(context, 'Payment Failed ');
    }
  }

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
                  MaterialPageRoute(builder: (context) => const ContactUs()),
                );
              },
              child: const Text('Help!')),
          IconButton(
              icon: const Icon(
                Icons.cancel_sharp,
                color: Colors.blue,
              ),
              onPressed: () {
                CheckPayment();
              })
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: WillPopScope(
          onWillPop: () async {
            if (await controller.canGoBack()) {
              controller.goBack();
              var curl = await controller.currentUrl();
              String baseUrl = curl.toString();
              CheckPayment();
              return false;
            } else {
              CheckPayment();
              return false;
            }
          },
          child: WebView(
            initialUrl: widget.data.toString(),
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) async {
              this.controller = controller;
            },
          ),
        ),
      ),
    );
  }
}
// overlay