

import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';

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
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            labelColor: Colors.black,
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          toolbarHeight: 50,
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
                  shadow: BoxShadow(offset: Offset.infinite),
                  padding: EdgeInsets.all(10),
                  listItemTextColor: Colors.black,
                  titleText:
                      'Your withdraw request for amount ₹${arrNames?[index]['amount']} ',
                  description: Text(
                    ' Date     ${arrNames?[index]['date'].substring(0, 10)}',
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
   
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 500,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Coins',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                '${localballance!.get(0).toString()}',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: MainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Ballance(₹)',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                '${localballance!.get(0) / 10}₹',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: MainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
      
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
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
                        if (user.get(0)['Account'] == 'UPI id /paytm number' ||
                            user.get(0)['Account'] == null) {
                          {
                            showMessage(context,
                                'Please complete your account information first');
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountSetting()),
                          );
                        } else {
                          MyAnalytic!
                              .put(DateTime.now().toString(), 'Withdraw');
                          int ammount = int.parse(amount.text);
                          int ball = (localballance!.get(0));

                          if (99 < ammount && ammount < ball) {
                            if (EMPremium == 'true') {
                              if (completed == 'true') {
                                http.Response response = await http.post(
                                    Uri.parse(
                                        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppWidrawRequest'),
                                    body: {
                                      'amount': amount.text,
                                      'email': email.toString(),
                                      'ballance': ball.toString()
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
                                      "* Please complete at least 5 tasks.last step to get withdraw. ");
                                }
                              }
                            } else {
                              buyMessage(context, '');
                            }
                          } else {
                            {
                              showMessage(context, "*min ballance 100₹   ");
                            }
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('1₹  = 10 coins'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Minimum ballance ₹100'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
