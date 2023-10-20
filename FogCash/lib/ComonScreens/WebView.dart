import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key, required this.data});
  final data;
  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller;

  // BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late WebViewController controller;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Flexible(
            child: Container(
              child: WebView(
                initialUrl: 'http://nextonebox.com/lovecash',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) async {
                  this.controller = controller;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// overlay