import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class mycourse extends StatefulWidget {
  mycourse({
    Key? key,
  }) : super(key: key);

  @override
  State<mycourse> createState() => _mycourseState();
}

class _mycourseState extends State<mycourse> {
  @override
  void initState() {
    super.initState();
  }

  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(child: CircularProgressIndicator()),
            WebView(
              initialUrl: 'https://cosmofeed.com/vp/64c804d3b0f811001d1f45d1',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) async {
                this.controller = controller;
              },
            ),
          ],
        ),
      ),
    );
  }
}
