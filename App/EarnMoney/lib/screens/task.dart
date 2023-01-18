import '../otherfiles/widgets.dart';

class Task extends StatefulWidget {
  final val;
  Task({super.key, this.val});

  @override
  State<Task> createState() => _TaskState();
}

var newb = task?.values.toList();

class _TaskState extends State<Task> {
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
    if (widget.val == '') {
      newb = task?.values.toList();
    } else {
      newb =
          task?.values.where((tet) => tet['catagories'] == widget.val).toList();
    }
  }

  void fintercountries(value) {
    setState(() {
      if (value == '') {
        newb = task?.values.toList();
      } else {
        newb = task?.values.where((tet) => tet['catagories'] == value).toList();
      }
    });
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
        body: FutureBuilder(
          future: GetRequest(
              'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks',
              tasks!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    height: 30,
                    width: 500,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'All');
                                fintercountries('');
                              },
                              text: "All",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'Other');
                                fintercountries('Other');
                              },
                              text: "Easy Tasks",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'Demart');
                                fintercountries('Demart');
                              },
                              text: "Demart Account",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'Credit');
                                fintercountries('Credit');
                              },
                              text: "Credit Card",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'Saving');
                                fintercountries('Saving');
                              },
                              text: "Saving Account",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'Coin');
                                fintercountries('Coin');
                              },
                              text: "Crypto",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                MyAnalytic!
                                    .put(DateTime.now().toString(), 'Loan');
                                fintercountries('Loan');
                              },
                              text: "Loan",
                            ),
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
                  Flexible(
                    child: Container(
                      child: ListView.builder(
                          itemCount: newb?.length,
                          itemBuilder: (context, index) {
                            var image = newb?[index]['image'];
                            return InkWell(
                              onTap: () {
                                var taskName = newb?[index];
                                MyAnalytic!.put(DateTime.now().toString(),
                                    taskName['name']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TasksDetails(task_name: taskName)),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    GFListTile(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.all(10),
                                      avatar: Image(
                                        width: 60,
                                        height: 60,
                                        image: NetworkImage(
                                          'https://nextonebox.com/media/$image',
                                        ),
                                      ),
                                      titleText: newb?[index]['name'],
                                      subTitleText: newb?[index]['description'],
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
                                          ' Earn    ₹ ${newb?[index]['price']}',
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
            );
          },
        ),
      ),
    );
  }
}
