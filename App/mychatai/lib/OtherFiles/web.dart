import '../OtherFiles/webpage.dart';
import '../OtherFiles/widgets.dart';

dynamic link;

class Web extends StatefulWidget {
  const Web({super.key});

  @override
  State<Web> createState() => _WebState();
}

class _WebState extends State<Web> {
  late WebViewController controller;
  final cookieManager = WebviewCookieManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 500,
            height: 140,
            color: BackColor,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  '1. Paste your shopping link from partner (Amazon, Flipkart etc) \n in the Input Link box. \n 2.Click on convert button.\n 3.You will get a new Output Link.\n 4.Use this link to buy product. \n 5. you will earn real cash money after buying your product.',
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
                      MaterialPageRoute(builder: (context) => WebPage(data: 'https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/stores.html?alt=media&token=bafc78c4-682b-4af7-9577-8b4cffc86a33',)),
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
                              'Check Partners',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: PrColor,
                                  fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                onPressed: () {
                                SetAnalytic('Partners');
                                    
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WebPage(
                                              data:
                                                  'https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/stores.html?alt=media&token=bafc78c4-682b-4af7-9577-8b4cffc86a33',
                                            )),
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
              child: WebView(
                  initialUrl: 'https://ek.dealsunlimited.in/converter.php',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) async {
                    this.controller = controller;

                    await cookieManager.setCookies([
                      Cookie('email', 'shahidmir8082@gmail.com')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('name', 'shahid')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('phone', '9682524922')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('password', '%40Shahid1')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('PHPSESSID', '6aa24bcd67998757c336b8461f880f26')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('uid', '3844')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('hash', 'fec2b72ce6cba57b53d2619aa303d545')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                      Cookie('ek_id', '1255450')
                        ..domain = 'ek.dealsunlimited.in'
                        ..expires = DateTime.now().add(Duration(days: 500))
                        ..httpOnly = false
                        ..path = '/',
                    ]);
                  },
                  onPageFinished: (String url) {
                    controller.runJavascript(
                      """     document.querySelector(".main-header").style.display = "none";
                         document.querySelector(".footer").style.display = "none";
                         document.querySelector(".wrapper").style.background = "white";
                          document.querySelector(".align-items-md-center").innerHTML = "";
                        
                          var textarea = document.getElementById("outputlinks");
          textarea.addEventListener("change", function() {
            content = this.value;
            const http = new XMLHttpRequest()
          
          http.open("GET", "https://www.nextonebox.com/earnmoney/NotGetUrls/ProfitLinkSave?$email+"+content)
          http.send()
          });
            
          
          
             """,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
