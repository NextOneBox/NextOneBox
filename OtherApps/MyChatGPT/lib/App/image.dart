import 'dart:convert';
import 'package:MyChatAi/App/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../OtherFiles/history.dart';
import '../OtherFiles/premium.dart';
import '../OtherFiles/widgets.dart';

class ImageGenerate extends StatefulWidget {
  @override
  State<ImageGenerate> createState() => _ImageGenerateState();
}

class _ImageGenerateState extends State<ImageGenerate> {
  prevusad() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Try MyChatAi Pro to generate ai image just in ₹35  \nGive your imagination a power in real world',
            ),
          ),
        ),
        keyboardAware: true,
        btnOkText: "Buy now",
        padding: const EdgeInsets.all(5.0),
        btnCancelOnPress: () {
          Navigator.of(context);
        },
        btnOkOnPress: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Premium()),
          );
        }).show();
  }

  void generateAIImage() async {
    if (inputText.text.isNotEmpty) {
      var data = {
        "prompt": inputText.text,
        "n": 1,
        "size": "256x256",
      };

      var res = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer ${apikey}",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));

      var jsonResponse = jsonDecode(res.body);

      image = jsonResponse['data'][0]['url'];
      setState(() {});
    } else {
      print("Enter something");
    }
  }

  TextEditingController inputText = TextEditingController();

  String url = 'https://api.openai.com/v1/images/generations';
  String? image;
  void getAIImage() async {
    if (inputText.text.isNotEmpty) {
      var data = {
        "prompt": inputText.text,
        "n": 1,
        "size": "256x256",
      };

      var res = await http.post(Uri.parse(url),
          headers: {
            "Authorization": "Bearer ${apikey!.get(0).toString()}",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));

      var jsonResponse = jsonDecode(res.body);

      image = jsonResponse['data'][0]['url'];
      print('this is what we are');
      print(image);

      setState(() {
        visitable = true;
        isloading = false;
        downlaod = true;
        inputText.clear();
      });
    } else {
      setState(() {
        {
          showMessage(context, 'Failed, try again after some time');
        }
        visitable = true;
        isloading = false;
        downlaod = false;
        inputText.clear();
      });
    }
  }

  var visitable = true;
  var isloading = false;
  var downlaod = false;
  BannerAd? _ad;

  bool adLoaded = false;
  @override
  void initState() {
    super.initState();

    runadd();
    BannerAd(
      adUnitId: 'ca-app-pub-3946644332709876/2184205785',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            // DateTime now = DateTime.now();
            // final formattedDate = "${now.year}${now.month}${now.day}";
            // if (int.parse(ChatAiPrem) < int.parse(formattedDate)) {
            adLoaded = true;
            // }
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
      appBar: AppBar(
        toolbarHeight: 48,
        actions: <Widget>[
          // Adding button on AppBar
          IconButton(
              icon: Icon(
                Icons.history,
                color: MainColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              })
        ],
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: MainColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BottomNavigation()),
              );
            }),
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Generate AI images",
            style: TextStyle(color: MainColor),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: botBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              adLoaded
                  ? Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: AdWidget(ad: _ad!),
                    )
                  : const SizedBox(),
              image != null
                  ? Container(
                      width: 256,
                      height: 256,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            image!,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 180, left: 130),
                        child: Visibility(
                            visible: downlaod,
                            child: IconButton(
                                onPressed: () async {
                                  var url = image!;
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                icon: Icon(
                                  Icons.downloading_outlined,
                                  size: 60,
                                  color: Colors.blue.shade100,
                                ))),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 256,
                      height: 265,
                    ),
              Visibility(
                visible: isloading,
                child: Container(
                  height: 60,
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: inputText,
                  decoration: InputDecoration(
                      hintText: "Enter Text to Generate AI Image",
                      filled: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: visitable,
        child: FloatingActionButton(
          onPressed: () {
            prevusad();
            // runadd();
            // getAIImage();
            // setState(() {
            //   visitable = false;
            //   isloading = true;
            // });
          },
          tooltip: 'Generate AI Image',
          child: const Icon(Icons.send),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
