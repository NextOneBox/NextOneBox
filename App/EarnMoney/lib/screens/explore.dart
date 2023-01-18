import '../otherfiles/widgets.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late WebViewController controller;

  BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore',
      home: Scaffold(
        body: Column(
          children: [
            isLoaded
                ? Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: AdWidget(ad: _ad!),
                  )
                : const SizedBox(),
            Flexible(
              child: Container(
                child: WebView(
                  initialUrl: 'https://www.nextonebox.com/PaisKamaooAppWebPage',
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
    );
  }
}
