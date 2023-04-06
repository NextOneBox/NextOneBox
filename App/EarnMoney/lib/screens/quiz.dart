import 'package:earnmoney/screens/quizquestions.dart';

import '../otherfiles/widgets.dart';

class Quiz extends StatefulWidget {
  Quiz({
    super.key,
  });

  @override
  State<Quiz> createState() => _QuizState();
}

dynamic newlis = quiz?.values.toList();
var seen = Set<dynamic>();
List<dynamic> newb =
    newlis.where((country) => seen.add(country['topic'])).toList();

class _QuizState extends State<Quiz> {
  BannerAd? _ad;
  bool isLoaded = false;

  @override
  initState() {
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
  @override
  Widget build(BuildContext context) {
   
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
        return false;
      },
      child: Scaffold(
        appBar:  AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Quiz',
          style: TextStyle(
              color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Scaffold(
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
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
                        child: ListView.builder(
                            itemCount: newb?.length,
                            itemBuilder: (context, index) {
                              var image = newb?[index]['image'];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizQuesions(
                                              topic: newb?[index]['topic'],
                                            )),
                                  );
                                  var question = newb[index]['topic'];
                                SetAnalytic('topic');
                                     
                                },
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      GFListTile(
                                        padding: EdgeInsets.all(10),
                                        margin: EdgeInsets.all(10),
                                        avatar: Image.asset(
                                          'assets/brain.png',
                                          width: 50,
                                        ),
                                        titleText: newb?[index]['topic'],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: MainColor,
                                          border: Border.all(color: MainColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        height: 35,
                                        margin: EdgeInsets.only(
                                            left: 40, right: 40, bottom: 20),
                                        child: Card(
                                          elevation: 100,
                                          color: MainColor,
                                          child: Center(
                                              child: Text(
                                            'Play now',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
