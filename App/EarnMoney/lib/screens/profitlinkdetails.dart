import '../otherfiles/widgets.dart';

class ProfitDetils extends StatefulWidget {
  const ProfitDetils({super.key});

  @override
  State<ProfitDetils> createState() => _ProfitDetilsState();
}

class _ProfitDetilsState extends State<ProfitDetils> {
  late WebViewController ccontroller;
  final cookieManager = WebviewCookieManager();
  void localhtmlfile() async {
    String fileText = await rootBundle.loadString('assets/stores.html');
    final uio = Uri.dataFromString(
      fileText,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    ccontroller.loadUrl(uio);
  }

  @override
  void initState() {
    super.initState();
    // Enable virtual display.

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Profit link Partners',
          style: TextStyle(
              color: PrColor, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 250),
      ),
      body: Column(
        children: [
          Container(
            width: 500,
            height: 100,
            color: BackColor,
            child: Column(
              children: [
                Text(
                  '1. Paste your shopping link in the box. \n 2.You will get a new reward lik.\n 3. Use this link to buy you product.\n 4. Wait for expiring your product return period. \n 5. you will earn real cash money as mention below.',
                  style: TextStyle(
                      color: PrColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 10),
                ),
                InkWell(
                  onTap: () {
                   SetAnalytic('ProfitLink'); 
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Web()),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 35,
                    child: Card(
                        color: MainColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                                child: Text(
                              'Create Link',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: PrColor,
                                  fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                onPressed: () {
                                  SetAnalytic('ProfitLink');
                           
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Web()),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_circle_right,
                                  color: PrColor,
                                ))
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: UseBorder,
              child: WebView(
                  initialUrl:
                      'https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/stores.html?alt=media&token=bafc78c4-682b-4af7-9577-8b4cffc86a33',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) async {
                    this.ccontroller = controller;
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
