import '../otherfiles/widgets.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;

class Referandearn extends StatefulWidget {
  Referandearn({super.key});

  @override
  State<Referandearn> createState() => _ReferandearnState();
}

class _ReferandearnState extends State<Referandearn> {
  buysuperspin() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      body: Center(
        child: Text(
          'Unlock Super Spin now for bigger earnings!. Do not miss out on Super Spin for only ₹49 rupees  limited time offer.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      keyboardAware: true,
      btnOkText: "Share",
      title: 'Continue to pay ₹49 rupees',
      padding: const EdgeInsets.all(5.0),
      btnCancelOnPress: () {
        showMessage(context, 'You missed the big earning opportunity');
      },
      btnOkOnPress: () {},
    )..show();
  }

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
          return Card(
            margin: EdgeInsets.all(15),
            elevation: 1,
            child: GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                titleText:
                    'Your friend ${arrNames?[index]['email'].toString().substring(0, 6)}... ',
                subTitleText: 'You have earned 100 Coins ',
                icon: Icon(FontAwesomeIcons.circleCheck)),
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

// List listitem = [];
class _InviteState extends State<Invite> {
  // void getper() async {
  // if (contacts!.isEmpty) {
  //   Timer(Duration(seconds: 20), () async {
  //     http.Response response = await http.post(
  //         Uri.parse(
  //             'https://www.nextonebox.com/earnmoney/NotGetUrls/SendContacts'),
  //         body: {
  //           'contactItems': listitem.toString(),
  //           'email': email,
  //         });
  //     if (response.body == 'don') {
  //       contacts!.add(response.body);
  //     }
  //   });
  //   if (await Permission.contacts.isGranted) {
  //     // Permission granted, proceed to fetch contacts\
  //     List<Contact> contact = await ContactsService.getContacts();

  //     for (var i = 0; i < contact.length; i++) {
  //       dynamic val = contact[i].phones![0].value;
  //       listitem.add(val);
  //     }
  //   } else {
  //     await Permission.contacts.request();
  //     // Permission denied, handle accordingly
  //   }
  // }
  // }
  BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    // BannerAd(
    //   adUnitId: 'ca-app-pub-3946644332709876/6246084818',
    //   size: AdSize.banner,
    //   request: AdRequest(),
    //   listener: BannerAdListener(
    //     onAdLoaded: (ad) {
    //       setState(() {
    //         _ad = ad as BannerAd;
    //         isLoaded = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, error) {
    //       // Releases an ad resource when it fails to load
    //       ad.dispose();
    //       print('Ad load failed (code=${error.code} message=${error.message})');
    //     },
    //   ),
    // ).load();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 500,
            height: 180,
            child: Image(
                fit: BoxFit.fill, image: AssetImage('assets/referpage.jpg')),
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
                      ' Refer and earn 100 Coins . ',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 10, 20),
                    child: Column(
                      children: [
                        Text(
                          'When they Sign up you earn 100 coins\n\n',
                          style: TextStyle(fontSize: 15, color: PrColor),
                        ),
                        Text(
                          'Top refer will get \n   iPhone 14',
                          style: TextStyle(fontSize: 15, color: PrColor),
                        ),
                        SizedBox(
                          height: 10,
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
                              '${user.get(0)['Refercode']}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                onPressed: () {
                                  SetAnalytic('ReferCopy');

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
                        SetAnalytic('ReferShare');

                        await Share.share(
                            '\n \n Hey, Do you want to earn \n \n 📲💰 10,000 per/month without any investment.\n \n ➡️ Then what are you waiting for Download now EarnMoney \n ➡️ And use my refer code '
                            '"${user.get(0)['Refercode']}". \n \n  💰💥💥  '
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
