import 'package:cashapp/AppScreens/widthrawhistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cashapp/ComonScreens/widgets.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

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
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Wallet ',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WidthrawHistory()),
                  );
                },
                icon: Icon(Icons.history))
          ],
          toolbarHeight: 50,
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return const Invite();
          },
          future: null,
        ),
      ),
    );
  }
}

var ballance;

bool isLoaded = false;

class Invite extends StatefulWidget {
  const Invite({super.key});

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
        padding: const EdgeInsets.fromLTRB(10, 80, 10, 10),
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Ballance(₹)',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                '₹${localballance!.get(0) / 10}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: MainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '(\$)',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              Text(
                                '\$${localballance!.get(0) / 800}',
                                style: const TextStyle(
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: amount,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: MainColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: MainColor,
                        )),
                        border: OutlineInputBorder(),
                        hintText: "Enter amount",
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 70,
                    margin: const EdgeInsets.fromLTRB(20, 80, 20, 2),
                    child: GFButton(
                      fullWidthButton: true,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                      color: MainColor,
                      child: const Text(
                        'Withdraw',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'RobotoMono'),
                      ),
                      onPressed: () async {
                        setState(() {});
                        if (user.get(0)['Account'] == 'UPI id /paytm number' ||
                            user.get(0)['Account'] == null) {
                          {
                            showMessage.show(context,
                                'Please complete your account information first');
                          }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountSetting()),
                          );
                        } else {
                          int ammount = int.parse(amount.text);
                          int ball = (localballance!.get(0));
                          if (ammount != '') {
                            if (249 < ammount && ammount < ball) {
                              if (user.get(0)['Pro'] == 'true') {
                                if (user.get(0)['TaskCompleted'] == 'true') {
                                  {
                                    showMessage.show(
                                        context, ' Request accepted');
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation()),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Restrictions! Controling scam & fake users\n10k+ users already got withdrawal this month 💸 '),
                                        content: const Text(
                                            '*Pleace Open app daily and watch ads for atleast 30 days\n*Please complete at least 5 tasks to get instant withdrawal. \n\n Enjoy Earning 😋 \n Feel save to earn and withdrawal 🙂\n Dont panic you get withdrawal after completing this steps🕺🏼.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                buyMessage(context, '');
                              }
                            } else {
                              {
                                showMessage.show(
                                    context, "\n* Min Withdrawal ₹250");
                              }
                            }
                          } else {
                            {
                              showMessage.show(context, "\n* Enter amount ");
                            }
                          }
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Minimum ballance ₹250',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
