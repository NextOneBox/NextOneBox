import '../OtherFiles/widgets.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key, required this.data});
  final data;
  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller;
  final cookieManager = WebviewCookieManager();

  BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
 
    BannerAd(
      adUnitId: 'ca-app-pub-6690747295108713/1024392773',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          isLoaded
              ? Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: AdWidget(ad: _ad!),
                )
              : const SizedBox(),
           Flexible(
            child: Container(
              child: WebViewWidget(controller: controller),

              // WebView(
              //   initialUrl: widget.data.toString(),
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onWebViewCreated: (controller) async {
              //     this.controller = controller;
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
// overlay