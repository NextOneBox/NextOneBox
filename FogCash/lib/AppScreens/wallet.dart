import 'package:mugcash/AppScreens/widthrawhistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:quantupi/quantupi.dart';

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
  void buyMessage(BuildContext context, String MYmessage) {
    paymentkro() async {
      Quantupi zupi = Quantupi(
        receiverUpiId: 'nextonebox@sbi',
        receiverName: 'NextOneBox CEO',
        transactionRefId: '',
        transactionNote: '${user.get(0)['Name']}',
        amount: 69,
      );
      final response = await zupi.startTransaction();
      List<String> keyValuePairs = response.split('&');
      for (String pair in keyValuePairs) {
        List<String> keyValuePair = pair.split('=');
        String key = keyValuePair[0];
        String value = keyValuePair[1];
        if (key == "Status") {
          if (value == 'SUCCESS') {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'Pro': 'true',
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }
            setState(() {
              QuickAlert.show(
                context: context,
                title: 'SUCCES',
                type: QuickAlertType.success,
                text: 'Congratulation you are upgraded please restart the app',
              );
              SendAllData();
            });
          } else {
            setState(() {
              QuickAlert.show(
                context: context,
                title: 'Failed',
                type: QuickAlertType.error,
                text: 'If you have paid please contact us',
              );
            });
          }
          break;
        }
      }
      payint() async {
        var data = "$email";
        await http
            .post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'), body: {
          'message': data.toString(),
        });
      }
    }
  }

  TextEditingController amount = TextEditingController();
  TextEditingController account = TextEditingController();
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
                  Column(
                    children: [
                      const Text(
                        'Ballance(₹)',
                        style: TextStyle(fontSize: 20, color: Colors.black),
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: TextFormField(
                      controller: account,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        floatingLabelStyle: TextStyle(color: MainColor),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: MainColor,
                        )),
                        border: OutlineInputBorder(),
                        hintText: "Upi id |  Paytm no.",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
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
                        if (amount.text.length > 1) {
                          if (account.text != '') {
                            int ammount = int.parse(amount.text);
                            int ball = (localballance!.get(0));
                            if (249 < ammount && ammount < ball) {
                              if (user.get(0)['Pro'] == 'true') {
                                if (adsbox?.get(21)['vip'] == 'true') {
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
                                              '😋10k+ users already got withdrawal this month💸 '),
                                          content: const Text(
                                              '*Upgrade compledted✅\n*Vip compledted✅\n*Complete at least 8 tasks⏳\n\n Enjoy Earning 😋 \n Feel save to earn and withdrawal 🙂\n Get your Instant withdrawal just after completing this last step🕺🏼.'),
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
                                  vipMessage(context, '');
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
                              showMessage.show(
                                  context, "\n* Enter your account number");
                            }
                          }
                        } else {
                          {
                            showMessage.show(context, "\n* Enter amount ");
                          }
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Minimum ballance ₹250\nWithdraw in just 1 minute.',
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
