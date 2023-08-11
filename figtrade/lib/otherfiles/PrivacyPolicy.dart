import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class webview extends StatefulWidget {
  final prourl;

  webview({Key? key, this.prourl}) : super(key: key);

  @override
  State<webview> createState() => _webviewState();
}

class _webviewState extends State<webview> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Fig',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: 'Trade',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: '${widget.prourl["u"]}',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) async {
          this.controller = controller;
        },
      ),
    );
  }
}

class termcondation extends StatefulWidget {
  final privacy;
  final terms;

  termcondation({Key? key, this.privacy, this.terms}) : super(key: key);

  @override
  State<termcondation> createState() => _termcondationState();
}

class _termcondationState extends State<termcondation> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Fig',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: 'Trade',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl:
            'https://indtradebusiness.blogspot.com/2023/05/termscondition.html',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) async {
          this.controller = controller;
        },
      ),
    );
  }
}

//
class privacy extends StatefulWidget {
  privacy({
    Key? key,
  }) : super(key: key);

  @override
  State<privacy> createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Fig',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: 'Trade',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple)),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl:
            'https://indtradebusiness.blogspot.com/2023/05/privacy-policy.html',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) async {
          this.controller = controller;
        },
      ),
    );
  }
}
//