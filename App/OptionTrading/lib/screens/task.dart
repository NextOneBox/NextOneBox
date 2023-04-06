import '../otherfiles/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Task extends StatefulWidget {
  final val;
  Task({super.key, this.val});

  @override
  State<Task> createState() => _TaskState();
}

var newb = ['hkjh', ''];

class _TaskState extends State<Task> {
  BannerAd? _ad;
  bool isLoaded = false;
  void fetchData() async {
    var url = Uri.parse(
        'https://apiconnect.angelbroking.com/rest/secure/angelbroking/historical/v1/getCandleData');
    var data = json.encode({
      "exchange": "NSE",
      "symboltoken": "3045",
      "interval": "ONE_MINUTE",
      "fromdate": "2021-02-08 09:00",
      "todate": "2021-02-08 09:16"
    });

    var headers = {
      'X-PrivateKey': 'NlqvYF0s',
      'Accept': 'application/json, application/json',
      'X-SourceID': 'WEB, WEB',
      'X-ClientLocalIP': 'CLIENT_LOCAL_IP',
      'X-ClientPublicIP': 'CLIENT_PUBLIC_IP',
      'X-MACAddress': 'MAC_ADDRESS',
      'X-UserType': 'USER',
      'Authorization': 'Bearer AUTHORIZATION_TOKEN',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      print(response.body);
    } catch (error) {
      print(error);
    }
  }

  @override
  initState() {
    fetchData();
    super.initState();
  }

  void fintercountries(value) {
    setState(() {
      if (value == '') {
      } else {}
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
                                SetAnalytic('All');

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
                                SetAnalytic('Other');

                                fintercountries('Other');
                              },
                              text: "Trending",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.white,
                              textColor: Colors.black,
                              onPressed: () {
                                SetAnalytic('Demart');

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
                                SetAnalytic('Credit');

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
                                SetAnalytic('Saving');

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
                                SetAnalytic('Coin');

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
                                SetAnalytic('Loan');

                                fintercountries('Loan');
                              },
                              text: "Loan",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: ListView.builder(itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [],
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
