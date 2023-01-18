import 'package:flutter/material.dart';
import 'package:downloadbrowser/web.dart';
import 'package:downloadbrowser/webview_tab.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'models/browser_model.dart';
import 'models/webview_model.dart';

class EmptyTab extends StatefulWidget {
  const EmptyTab({Key? key}) : super(key: key);

  @override
  State<EmptyTab> createState() => _EmptyTabState();
}

class _EmptyTabState extends State<EmptyTab> {
  final _controller = TextEditingController();

  var texstyle = TextStyle(fontSize: 17, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);
    var settings = browserModel.getSettings();
    var boxsize = 60.0;
    var sizeboxsize = 20.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: sizeboxsize,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Social Media Websites',
                        style: texstyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://www.facebook.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/facebook.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://www.twitter.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/twitter.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://www.youtube.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/youtube.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://www.instagram.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/instagram.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: sizeboxsize,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Shorts Websites',
                        style: texstyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://www.youtube.com/shorts/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/shorts.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WebPage(data: 'https://share.myjosh.in/')),
                        ),
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/josh.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://mojapp.in/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/moj.jpeg',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data:
                                        'https://www.instagram.com/reels/videos/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/instareels.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: sizeboxsize,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Video Downloads Websites',
                        style: texstyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://en.savefrom.net/379/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/savefromnet.jpeg',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://snapinsta.app/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/snap.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://igram.io/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/toolzo.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: sizeboxsize,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Moves Download Websites',
                        style: texstyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizeboxsize,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://vegamovies.page/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/vagamoves.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                    data: 'https://themoviezflix.co.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/movesflix.jpg',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://ww1.flixtor.life/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/fixtor.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void openNewTab(value) {
    var browserModel = Provider.of<BrowserModel>(context, listen: false);
    var settings = browserModel.getSettings();

    browserModel.addTab(WebViewTab(
      key: GlobalKey(),
      webViewModel: WebViewModel(
          url: WebUri(value.startsWith("http")
              ? value
              : settings.searchEngine.searchUrl + value)),
    ));
  }
}
