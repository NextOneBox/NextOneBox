import '../otherfiles/widgets.dart';

class Referandearn extends StatefulWidget {
  Referandearn({super.key});

  @override
  State<Referandearn> createState() => _ReferandearnState();
}

class _ReferandearnState extends State<Referandearn> {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            labelColor: PrColor,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'Invite',
              ),
              Tab(
                text: 'Status',
              ),
            ],
          ),
          title: Text(
            'Invite & Earn',
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          future: GetRequest(
              'https://www.nextonebox.com/earnmoney/NotGetUrls/AppReferAndEarn?$Refercode',
              refer!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TabBarView(
              children: [
                Invite(),
                Status(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Status extends StatefulWidget {
  Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

var list = refer?.values.toList().reversed;

class _StatusState extends State<Status> {
  var arrNames = list?.toList();

  @override
  Widget build(BuildContext context) {
    if (arrNames!.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No refer yet! \n if have wait for changes to happen.'),
        ),
      );
    } else {
      return Scaffold(
          body: ListView.builder(
        itemBuilder: (context, index) {
          IconData fonticon = Icons.info_outline;
          if (arrNames == '') {
          } else {
            if (arrNames?[index]['completed'] != 'true') {
              fonticon = Icons.info_outline;
            } else {
              fonticon = FontAwesomeIcons.circleCheck;
            }
          }
          return Card(
            margin: EdgeInsets.all(15),
            elevation: 1,
            child: GFListTile(
                titleText:
                    'Your friend ${arrNames?[index]['email'].toString().substring(0, 6)}... ',
                subTitleText:
                    'Let them complete at least 3 task and you will earn ₹100',
                icon: Icon(fonticon)),
          );
        },
        itemCount: arrNames?.length,
      ));
    }
  }
}

class Invite extends StatefulWidget {
  Invite({super.key});

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 500,
            height: 180,
            child: Image(fit: BoxFit.fill, image: AssetImage('assets/re.PNG')),
          ),
          isLoaded
              ? Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: AdWidget(ad: _ad!),
                )
              : const SizedBox(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      ' Refer your friend and earn ₹100.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 10, 10),
                    child: Text(
                      'Your friend have to completed just three tasks to get refer don. They get ₹25 on Signup. ',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 10, 10),
                    child: Row(
                      children: [
                        Text(
                          'Lucky refer will get \n iPhone 14 Pro.\n Offer began every month.',
                        ),
                        Image.asset(
                          'assets/iphone.png',
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    child: Card(
                        color: BackColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                                child: Text(
                              '${Refercode}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                onPressed: () {
                                  MyAnalytic!.put(
                                      DateTime.now().toString(), 'ReferCopy');
                                  FlutterClipboard.copy(
                                          '${user.get(0)['Refercode']}')
                                      .then((value) =>
                                          {showMessage(context, 'Copied')});
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: MainColor,
                                ))
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 200,
                    height: 40,
                    child: GFButton(
                      fullWidthButton: true,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                      color: MainColor,
                      onPressed: () async {
                        MyAnalytic!
                            .put(DateTime.now().toString(), 'ReferShare');
                        await Share.share(
                            '\n \n Hey, Do you want to earn \n \n 📲💰 10,000 per/month without any investment.\n \n ➡️ Then what are you waiting for Download now earnmoney \n ➡️ And use my refer code '
                            '"${user.get(0)['Refercode']}". \n \n To earn 25 ₹ rupees cash bonus 💰💥💥  '
                            '\n ➡️ https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney');
                      },
                      text: "Refer Now ",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
