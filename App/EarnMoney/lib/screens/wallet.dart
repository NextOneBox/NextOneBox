import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class Wallet extends StatefulWidget {
  Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: PrColor,
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'Withdraw'),
              Tab(
                text: 'Request',
              ),
            ],
          ),
          title: Text(
            'Wallet',
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          toolbarHeight: 50,
        ),
        body: FutureBuilder(
          future: GetRequest(
              'https://www.nextonebox.com/earnmoney/NotGetUrls/AppWidrawStatus?$email',
              widrawstaus!),
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

var widrawlist = widrawstaus?.values.toList().reversed;

class _StatusState extends State<Status> {
  var arrNames = widrawlist?.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      if (arrNames!.isEmpty) {
        return Scaffold(
          body: Center(
            child: Text(
                'No withdraw request available.\n if have wait for changes to happen.'),
          ),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) {
            IconData fonticon;
            if (arrNames?[index]['status'] == 'don') {
              fonticon = FontAwesomeIcons.circleCheck;
            } else {
              if (arrNames?[index]['status'] == 'cancel') {
                fonticon = FontAwesomeIcons.xmark;
              } else {
                fonticon = Icons.info_outline;
              }
            }
            return Container(
              margin: EdgeInsets.all(15),
              decoration: UseBorder,
              child: GFListTile(
                  padding: EdgeInsets.all(10),
                  listItemTextColor: PrColor,
                  titleText:
                      'Your withdraw request for amount ₹${arrNames?[index]['amount']} ',
                  description: Text(
                    ' Date     ${arrNames?[index]['date']}',
                    style: TextStyle(fontSize: 10, height: 3),
                  ),
                  icon: Icon(fonticon)),
            );
          },
          itemCount: arrNames?.length,
        );
      }
    }));
  }
}

var ballance;
BannerAd? _ad;
bool isLoaded = false;

class Invite extends StatefulWidget {
  Invite({super.key});

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  TextEditingController amount = TextEditingController();
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
    if (Ballance == null) {
      ballance = 0;
    } else {
      ballance = Ballance;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 400,
                height: 500,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        width: 500,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Current Ballance',
                                          style: TextStyle(
                                              fontSize: 30, color: PrColor),
                                        ),
                                        Text(
                                          '₹${user.get(0)['Ballance']}.0',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: MainColor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 10,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      isLoaded
                          ? Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: AdWidget(ad: _ad!),
                            )
                          : const SizedBox(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: amount,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: MainColor),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: MainColor,
                            )),
                            border: OutlineInputBorder(),
                            hintText: "Enter amount",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.currency_rupee,
                                color: MainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 45,
                        margin: EdgeInsets.fromLTRB(20, 50, 20, 2),
                        child: GFButton(
                          fullWidthButton: true,
                          shape: GFButtonShape.pills,
                          size: GFSize.LARGE,
                          color: MainColor,
                          child: Text(
                            'Withdraw',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'RobotoMono'),
                          ),
                          onPressed: () async {
                            // MyAnalytic!
                            //     .put(DateTime.now().toString(), 'Withdraw');
                            int ammount = int.parse(amount.text);
                            int ball = int.parse(Ballance);

                            if (498 < ammount && ammount < ball) {
                              if (user.get(0)['completed'] == 'true') {
                                http.Response response = await http.post(
                                    Uri.parse(
                                        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppWidrawRequest'),
                                    body: {
                                      'amount': amount.text,
                                      'email': email.toString(),
                                      'ballance': Ballance.toString()
                                    });

                                if (response.body == 'Request accepted') {
                                  dynamic dat = {
                                    'email': email,
                                    'password': ammount,
                                  };
                                  {
                                    showMessage(context, ' Request accepted');
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation()),
                                  );
                                } else {
                                  {
                                    showMessage(context, response.body);
                                  }
                                }
                              } else {
                                {
                                  showMessage(context,
                                      'You must have to complete at least 3 tasks to Withdraw ballance');
                                }
                              }
                            } else {
                              {
                                showMessage(context,
                                    "Due to High Withdraw request.\n You must need at least 500₹ wallet ballance to Withdraw. ");
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
