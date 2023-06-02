import '../otherfiles/widgets.dart';

class LeadboadScreen extends StatefulWidget {
  LeadboadScreen({super.key});

  @override
  State<LeadboadScreen> createState() => _LeadboadScreenState();
}

var VarLeadBoard = leadboard?.values.toList().reversed;

class _LeadboadScreenState extends State<LeadboadScreen> {
  var LIstLeadBoard = List.from(VarLeadBoard!);
  BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    BannerAd(
      adUnitId: 'ca-app-pub-3946644332709876/6246084818',
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
    if (LIstLeadBoard.isEmpty) {
      return FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              
              elevation: 0,
              title: Text(
                'Leaderboard',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
              ),
              backgroundColor: Color.fromARGB(255, 247, 247, 250),
            ),
            body: Center(
                child: Text(
              '',
              style: TextStyle(
                  color: Color.fromARGB(255, 116, 110, 110),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )));
      });
    } else {
      return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
              appBar: AppBar(
                
                elevation: 0,
                title: Text(
                  'Leaderboard',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                backgroundColor:BackColor,
              ),
              body: Column(
                children: [
                  isLoaded
                      ? Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: AdWidget(ad: _ad!),
                        )
                      : const SizedBox(),
                  Container(
                    width: 500,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(7),
                          decoration: UseBorder,
                          width: 80,
                          height: 70,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GFAvatar(
                                size: 15,
                                backgroundColor: MainColor,
                                child: Icon(
                                  FontAwesomeIcons.two,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                LIstLeadBoard[1]['name'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                LIstLeadBoard[1]['description'] + ' ₹',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.all(7),
                          decoration: UseBorder,
                          width: 100,
                          height: 100,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GFAvatar(
                                size: 15,
                                backgroundColor: MainColor,
                                child: Icon(
                                  Icons.offline_bolt_sharp,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                LIstLeadBoard[0]['name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                LIstLeadBoard[0]['description'] + ' ₹',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.all(7),
                          decoration: UseBorder,
                          width: 80,
                          height: 70,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GFAvatar(
                                size: 15,
                                backgroundColor: MainColor,
                                child: Icon(
                                  FontAwesomeIcons.three,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                LIstLeadBoard[2]['name'],
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                LIstLeadBoard[2]['description'] + ' ₹',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: LIstLeadBoard.length,
                        itemBuilder: (context, index) {
                          String listgetname;
                          String listgetdescription;
                          String listgetdate;

                          if (LIstLeadBoard[index]['name'] == null) {
                            listgetdescription =
                                'you have successfully shared to ${LIstLeadBoard[index]['email'].toString().substring(0, 6)}';
                            listgetname = '';
                            listgetdate = '';
                          } else {
                            listgetname =
                                LIstLeadBoard[index]['name'].toString();
                            listgetdescription =
                                LIstLeadBoard[index]['description'].toString();
                            var a = index + 1;
                            listgetdate = a.toString();
                          }
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(7),
                                decoration: UseBorder,
                                child: GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                                  avatar: GFAvatar(
                                    size: 25,
                                    backgroundColor: MainColor,
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  subTitle: Text(
                                    listgetname,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  icon: Text('' + listgetdescription + ' ₹'),
                                ),
                              ),
                            ],
                          );
                        }),
                  )
                ],
              ));
        },
      );
    }
  }
}
