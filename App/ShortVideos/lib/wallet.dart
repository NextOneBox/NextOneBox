import 'package:nobs/request.dart';

import 'widgets.dart';

Box? localballance = Hive.box('localballance');

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

void showMessage(BuildContext context, String MYmessage) {
  showFlash(
      context: context,
      duration: Duration(seconds: 2),
      builder: (_, c) {
        return Flash.bar(
          barrierDismissible: true,
          controller: c,
          backgroundColor: Colors.black,
          position: FlashPosition.top,
          margin: EdgeInsets.all(50),
          borderRadius: BorderRadius.circular(20),
          child: FlashBar(
            padding: EdgeInsets.all(20),
            content: Text(
              MYmessage,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      });
}

class _WalletState extends State<Wallet> {
  // googleLogin() async {
  //   GoogleSignIn _googleSignIn = GoogleSignIn();
  //   try {
  //     var reslut = await _googleSignIn.signIn();
  //     if (reslut == null) {
  //       return;
  //     }

  //     http.Response response = await http.post(
  //         Uri.parse(
  //             'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
  //         body: {
  //           'email': reslut.email.toString(),
  //           'name': reslut.displayName.toString(),
  //         });

  //     if (response.reasonPhrase == 'OK') {
  //       await localballance!.put(0, int.parse('Ballance'));
  //     }

  //     if (response.body == 'account created') {
  //       await localballance!.put(0, 0);
  //     }
  //   } catch (error) {
  //     {
  //       showMessage(context, '$error');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Account',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   margin: EdgeInsets.only(left: 20, bottom: 50, right: 20),
              //   child: InkWell(
              //     onTap: () {
              //       googleLogin();
              //     },
              //     child: Card(
              //       color: Colors.black54,
              //       elevation: 5,
              //       child: Center(
              //         child: Padding(
              //           padding: EdgeInsets.all(15.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Image.asset(
              //                 'assets/googleicon.png',
              //                 fit: BoxFit.fill,
              //                 height: 30,
              //               ),
              //               Padding(
              //                 padding: EdgeInsets.only(left: 10),
              //                 child: Text(
              //                   'Continue with Google',
              //                   style: TextStyle(
              //                       fontSize: 17,
              //                       fontWeight: FontWeight.w500,
              //                       fontFamily: 'Proxima Nova'),
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                width: 400,
                height: 200,
                child: Center(
                    child: Text(
                  '${localballance!.get(0) ?? 0} Coins',
                  style: TextStyle(fontSize: 30, color: Colors.black54),
                )),
              ),

              InkWell(
                onTap: () {
                  int a = localballance!.get(0) ?? 0;
                  if (a > 5000) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Request(ammount: 5000)),
                    );
                  } else {
                    {
                      showMessage(context, 'Low ballance ');
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/Paytm_logo.png',
                            width: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                '      5000 Coins is 500 Rupees',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              Text(' Transfer to Paytm'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  int a = localballance!.get(0) ?? 0;
                  if (a > 7000) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Request(ammount: 70000)),
                    );
                  } else {
                    {
                      showMessage(context, 'Low ballance ');
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/paypal.png',
                            width: 50,
                          ),
                          Column(
                            children: [
                              Text(
                                '      7000 Coins is 10 Doller',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black54),
                              ),
                              Text(' Transfer to PayPal'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'After every one minute you earn a coin.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              )
            ],
          ),
        ));
  }
}
