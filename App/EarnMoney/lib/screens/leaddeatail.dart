import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class LeadDeaail extends StatefulWidget {
  final task_name;
  LeadDeaail({super.key, required this.task_name});

  @override
  State<LeadDeaail> createState() => _LeadDeaailState();
}

var list;
Future getdata(id) async {
  var b = leadsteps?.get(id);

  http.Response leadstep = await http.get(Uri.parse(
      'https://www.nextonebox.com/earnmoney/NotGetUrls/AppLeadsStepCompleted?$id'));
  print(leadstep.body);
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
    var id = (widget.task_name['product']);
    var onetick = Icons.info_outline;
    var twotick = Icons.info_outline;
    var threetick = Icons.info_outline;
    if (widget.task_name['steps'] == 'one') {
      onetick = Icons.check_circle;
    }
    if (widget.task_name['steps'] == 'two') {
      onetick = Icons.check_circle;
      twotick = Icons.check_circle;
    }
    if (widget.task_name['steps'] == 'three') {
      onetick = Icons.check_circle;
      twotick = Icons.check_circle;
      threetick = Icons.check_circle;
    } else {
      var onetick = Icons.info_outline;
      var twotick = Icons.info_outline;
      var threetick = Icons.info_outline;
    }

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor:BackColor,
          elevation: 0,
          title: Text(
            'Leads details',
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: FutureBuilder(
        future: getdata(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                      'Added : ${widget.task_name['currentdate'].substring(0, 10)}'),
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
                            shadow: BoxShadow(offset: Offset.infinite),
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
                            shadow: BoxShadow(offset: Offset.infinite),
                              icon: Icon(Icons.phone),
                              titleText: 'Phone number ',
                              subTitleText: '${widget.task_name['phone']}',
                            ),
                            Divider(
                              height: 5,
                              color: Colors.black,
                            ),
                            GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
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
                    GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        subTitleText:
                            'The account opening process is started. Complete and earn your reward',
                        icon: Icon(Icons.check_circle)),
                    GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        subTitleText: leadsteps!.get(id)[0]['one'].toString(),
                        icon: Icon(onetick)),
                    GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        subTitleText: leadsteps!.get(id)[0]['two'].toString(),
                        icon: Icon(twotick)),
                    GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        subTitleText: leadsteps!.get(id)[0]['three'].toString(),
                        icon: Icon(threetick)),

                    // Container(
                    //   width: 500,
                    //   height: 500,
                    //   margin: EdgeInsets.all(10),
                    //   child: GFListTile(
                            // shadow: BoxShadow(offset: Offset.infinite),
                    //             padding: EdgeInsets.all(15),
                    //             margin: EdgeInsets.all(15),
                    //             subTitleText:
                    //                 '${list?['one'].toString()}',
                    //             icon: Icon(Icons.check_circle))

                    // ),
                    // Container(
                    //   width: 500,
                    //   height: 500,
                    //   margin: EdgeInsets.all(10),
                    //   child: ListView.builder(
                    //       itemCount: list.length,
                    //       itemBuilder: (context, index) {
                    //         String stepname;
                    //         if (leadsteps == '') {
                    //           stepname = 'get';
                    //         } else {
                    //           stepname = 'wait';
                    //         }
                    //         return GFListTile(
                            // shadow: BoxShadow(offset: Offset.infinite),
                    //             padding: EdgeInsets.all(15),
                    //             margin: EdgeInsets.all(15),
                    //             subTitleText:
                    //                 '${list?[index]['one'].toString()}',
                    //             icon: Icon(Icons.check_circle));
                    //       }),
                    // )
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
