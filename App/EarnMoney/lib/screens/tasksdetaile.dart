import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class TasksDetails extends StatefulWidget {
  TasksDetails({super.key, required this.task_name});
  final task_name;
  @override
  State<TasksDetails> createState() => _TasksDetailsState();
}

Box? user = Hive.box('user');
Box? task = Hive.box('tasks');
String code = user?.get(0)['Refercode'];

class _TasksDetailsState extends State<TasksDetails> {
  var shortLink = 'No Data Yet';
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
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GFButton(
            onPressed: () async {
              MyAnalytic!.put(DateTime.now().toString(), 'ClaimTask');
              if (user?.get(0)['phonenumber'] == 'Phone Number') {
                {
                  showMessage(context,
                      'Please complete your account information first');
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSetting()),
                );
              } else {
                http.Response response = await http.post(
                    Uri.parse(
                        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTaskSharePage'),
                    body: {
                      'full_name': user?.get(0)['name'],
                      'mobile_no': user?.get(0)['phonenumber'],
                      'email': user?.get(0)['email'],
                      'image': widget.task_name['image'],
                      'product': widget.task_name['name'],
                      'refercode': code,
                      'city': 'non'
                    });

                String url = widget.task_name['referlink'];
                var urllaunchable = await canLaunch(
                    url); //canLaunch is from url_launcher package
                if (urllaunchable) {
                  await launch(
                      url); //launch is from url_launcher package to launch URL
                } else {
                  print("URL can't be launched.");
                }
              }
              ;
            },
            text: '  Download Now   ',
            color: Colors.black,
            shape: GFButtonShape.pills,
          ),
          GFButton(
            onPressed: () async {
              MyAnalytic!.put(DateTime.now().toString(), 'ShareTask');
              if (user?.get(0)['phonenumber'] == 'Phone Number') {
                {
                  showMessage(context,
                      'Please complete your account information first');
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSetting()),
                );
              } else {
                await Share.share(
                    '  ${widget.task_name['name'].toString().toUpperCase()} '
                    '\n \n'
                    '${widget.task_name['benifits'].toString().replaceAll(',', '\n \n')} '
                    ' \n \n Complete your account opening process with in 30 days to earn lucky win .📲💰 \n \n'
                    'For any help contact our verified earnmoney adviser '
                    ' \n Name :'
                    ' ${user?.get(0)['name'].toString().toUpperCase()} '
                    '\n'
                    '  Email id :  ${user?.get(0)['email']}  '
                    '\n \n ➡️ Use Promo code/refer code. or  \n '
                    '➡️ Use this link to Open account \n \n'
                    'https://www.nextonebox.com/earnmoney/t?id=${widget.task_name['name']}+$code');
              }
            },
            text: "  Share    ",
            color: Colors.black,
            shape: GFButtonShape.pills,
          ),
        ],
      ),
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 247, 247, 250),
          elevation: 0,
          title: Text(
            'Task details',
            style: TextStyle(
                color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
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
                                height: 50,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                '${widget.task_name['name']}',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 3,
                        ),
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
                          avatar: GFAvatar(
                            backgroundColor: Color.fromARGB(255, 247, 247, 250),
                            child: Icon(
                              Icons.currency_rupee_sharp,
                              color: Colors.black,
                            ),
                          ),
                          titleText: '${widget.task_name['price']}',
                          subTitleText: '${widget.task_name['description']}',
                        ),
                        Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Tracking : 1days'),
                              Text('Confirm  : 7days'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 80,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 80,
                      child: Center(
                          child: Text(
                        'Steps to Earn',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
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
                  width: 500,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GFListTile(
                          titleText: '\n \n How to Earn \n',
                          subTitleText:
                              '${widget.task_name['howtoearn'].toString().replaceAll(',', '\n \n')}',
                        ),
                        GFListTile(
                          titleText: '\n Benefits \n',
                          subTitleText:
                              '${widget.task_name['benifits'].toString().replaceAll(',', '\n \n')}',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
