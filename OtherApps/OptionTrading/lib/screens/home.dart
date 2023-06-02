import '../otherfiles/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

void geturldata() async {
  http.Response response =
      await http.get(Uri.parse('https://groww.in/options/nifty'));
  final document = parse(response.body);
  print(document);
  // final links = document.querySelectorAll('.ocp71TopSecDiv');

  // for (final link in links) {
  //   print(link);
  // }
}

class _HomeState extends State<Home> {
  late WebViewController controller;
  final cookieManager = WebviewCookieManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () {
                geturldata();
              },
              child: Text('getdata'))),
    );
  }
}
// var myurl = 'https://groww.in/options/nifty';
//     if (myurl == 'https://groww.in/options/nifty') {
//     } else {
//       myurl == 'https://groww.in';
//     }
//     return WebView(
//       initialUrl: myurl,
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (controller) async {
//         this.controller = controller;

// //write style in html file
//         controller.evaluateJavascript("""
// document.querySelector(".h12Wrapper").style.display = "none";
// document.querySelector(".foot21Billion").style.display = "none";
// document.querySelector(".foot21Box").style.display = "none";
// document.querySelector(".foot21ExploreHead").style.display = "none";
// document.querySelector(".foot21Div").style.display = "none";
// document.querySelector(".foot21MoreAbout").style.display = "none";
// document.querySelector(".footCollapsibleDiv").style.display = "none";
// document.querySelector("a.opr84PriceVal").style.display = "none";
// window.onload = function() {
//   // Display an alert message
//   alert("Page has finished loading!");
// };







//           """);
//       },
//     );
//   }