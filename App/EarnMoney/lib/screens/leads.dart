import '../otherfiles/widgets.dart';

var statusicon;

class Leadsadded extends StatefulWidget {
  Leadsadded({super.key});

  @override
  State<Leadsadded> createState() => _LeadsaddedState();
}

var newlist = lead?.values.toList().reversed;
var profitlin = profitlink?.values.toList().reversed;

class _LeadsaddedState extends State<Leadsadded> {
  @override
  Future getleadsdata() async {
    dynamic refercode = user.get(0)['Refercode'];
    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppLeads?$refercode',
        lead!);
    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/ProfitLinkShow?$email',
        profitlink!);
  }

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
                text: 'Apps',
              ),
              Tab(
                text: 'Products',
              ),
            ],
          ),
          title: Text(
            'Leads',
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          future: getleadsdata(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TabBarView(
              children: [
                Apps(),
                Products(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Apps extends StatefulWidget {
  Apps({super.key});

  @override
  State<Apps> createState() => _AppsState();
}

class _AppsState extends State<Apps> {
  final newb = newlist?.toList();
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
    if (newb!.isEmpty) {
      return Scaffold(
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: 500,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          isLoaded
                              ? Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: AdWidget(ad: _ad!),
                                )
                              : const SizedBox(),
                          Text(
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              'Your Tasks Shared \n    Shows here'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'If shared wait for changes to happen',
                        style: TextStyle(fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Scaffold(
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Column(
              children: [
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
                          var taskName = newb?[index];

                          if (newb?[index]['status'] == 'pending') {
                            statusicon = Icons.info_outline;
                          } else {
                            if (newb?[index]['status'] == 'don') {
                              statusicon = Icons.done;
                            } else {
                              statusicon = FontAwesomeIcons.xmark;
                            }
                          }
                          return InkWell(
                            onTap: () {
                              MyAnalytic!.put(DateTime.now().toString(),
                                  taskName['product']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LeadDeaail(task_name: taskName)),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: UseBorder,
                              child: Column(
                                children: [
                                  GFListTile(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(5),
                                      avatar: Image(
                                        width: 50,
                                        height: 50,
                                        image: NetworkImage(
                                            "https://nextonebox.com/media/$image"),
                                      ),
                                      titleText: newb?[index]['product'],
                                      subTitleText: '',
                                      description: Text(
                                          'Added on  ${newb?[index]['currentdate']}'),
                                      icon: Icon(statusicon)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 30,
                                        margin: EdgeInsets.only(
                                            left: 50, right: 0, bottom: 20),
                                        child: Card(
                                        
                                          child: Center(
                                            child: Text(
                                              'Status :',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: MainColor,
                                          border: Border.all(color: MainColor),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        height: 30,
                                        margin: EdgeInsets.only(
                                            left: 40, right: 50, bottom: 20),
                                        child: Card(
                                          color: MainColor,
                                          child: Center(
                                            child: Text(
                                              '  ${newb?[index]['status']}  '
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Roboto',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }
}

class Products extends StatefulWidget {
  Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final newf = profitlin?.toList();
  @override
  Widget build(BuildContext context) {
    if (newf!.isEmpty) {
      return Scaffold(
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: 500,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                              'Your Profit link shared \n    Shows here'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        'If shared wait for changes to happen',
                        style: TextStyle(fontSize: 10),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Scaffold(
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Column(
              children: [
                Flexible(
                  child: Container(
                    child: ListView.builder(
                        itemCount: newf?.length,
                        itemBuilder: (context, index) {
                          var image = newf?[index]['image'];
                          var taskName = newf?[index];

                          if (newf?[index]['status'] == 'cancel') {
                            statusicon = FontAwesomeIcons.xmark;
                          } else {
                            if (newf?[index]['status'] == 'don') {
                              statusicon = Icons.done;
                            } else {
                              statusicon = Icons.info_outline;
                            }
                          }
                          return Container(
                            decoration: UseBorder,
                            margin: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                GFListTile(
                                    padding: EdgeInsets.all(5),
                                    titleText: newf?[index]['link'],
                                    subTitleText: '',
                                    description: Text(
                                        'Added on  ${newf?[index]['date']}'),
                                    icon: Center(
                                      child: IconButton(
                                        icon: Icon(statusicon),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Web()),
                                          );
                                        },
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 30,
                                      margin: EdgeInsets.only(
                                          left: 50, right: 0, bottom: 20),
                                      child: Card(
                                        child: Center(
                                          child: Text(
                                            'Status :',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Roboto',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MainColor,
                                        border: Border.all(color: MainColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      height: 30,
                                      margin: EdgeInsets.only(
                                          left: 40, right: 50, bottom: 20),
                                      child: Card(
                                        color: MainColor,
                                        child: Center(
                                          child: Text(
                                            '  ${newf?[index]['status']}  '
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
  }
}
