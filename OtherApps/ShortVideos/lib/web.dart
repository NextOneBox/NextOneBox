import 'widgets.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key, required this.data});
  final data;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: WillPopScope(
                onWillPop: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                    return false;
                  } else {
                    return true;
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
          ),
        ],
      ),
    );
  }
}
