import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class LeadDeaail extends StatefulWidget {
  final task_name;
  LeadDeaail({super.key, required this.task_name});

  @override
  State<LeadDeaail> createState() => _LeadDeaailState();
}

var a = [
  {
    'name': 'Just Started',
    'currentdate': '',
    'description':
        'Your customers have only begun the process; assist them in completing it so that you can earn your reward.',
  }
];
var b;
var list;
Future getdata(id) async {
  b = leadsteps?.get(id);

  http.Response leadstep = await http.get(Uri.parse(
      'https://www.nextonebox.com/earnmoney/NotGetUrls/AppLeadsSteps?$id'));
  if (leadstep.reasonPhrase == 'OK') {
    dynamic da = jsonDecode(leadstep.body);
    await leadsteps?.put(id, da);
  }
}

class _LeadDeaailState extends State<LeadDeaail> {
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
    var id = (widget.task_name['id']);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 247, 247, 250),
          elevation: 0,
          title: Text(
            'Leads details',
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: FutureBuilder(
        future: getdata(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          list = List.from(a)..addAll(b!);
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        'https://nextonebox.com/media/${widget.task_name['image']}'),
                                    width: 50,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text('${widget.task_name['product']}',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Divider(
                              height: 3,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                      'Added : ${widget.task_name['currentdate']}'),
                                  Text('    Expire : 45 days'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: 500,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GFListTile(
                              padding: EdgeInsets.fromLTRB(50, 10, 0, 10),
                              avatar: CircleAvatar(
                                  backgroundColor: MainColor,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  )),
                              titleText: '${widget.task_name['name']} ',
                            ),
                            Divider(
                              height: 5,
                              color: Colors.black,
                            ),
                            GFListTile(
                              icon: Icon(Icons.phone),
                              titleText: 'Phone number ',
                              subTitleText: '${widget.task_name['phone']}',
                            ),
                            Divider(
                              height: 5,
                              color: Colors.black,
                            ),
                            GFListTile(
                              icon: Icon(Icons.email),
                              titleText: 'Email id',
                              subTitleText: '${widget.task_name['email']}',
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
                    SizedBox(
                      width: 250,
                      height: 80,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: Center(
                              child: Text(
                            'Steps Taken',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    Container(
                      width: 500,
                      height: 500,
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            String stepname;
                            if (leadsteps == '') {
                              stepname = 'get';
                            } else {
                              stepname = 'wait';
                            }
                            return GFListTile(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.all(15),
                                titleText: '${list[index]['name'].toString()}',
                                description: Text(
                                    '${list?[index]['currentdate'].toString()}'),
                                subTitleText:
                                    '${list?[index]['description'].toString()}',
                                icon: Icon(Icons.check_circle));
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
