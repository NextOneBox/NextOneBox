// ignore_for_file: use_build_context_synchronously, avoid_single_cascade_in_expression_statements
import 'package:http/http.dart' as http;
import 'widgets.dart';
import 'package:quantupi/quantupi.dart';

class PayYear extends StatefulWidget {
  const PayYear({super.key});

  @override
  State<PayYear> createState() => _PayYearState();
}

class _PayYearState extends State<PayYear> {
  paymentkro() async {
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox@sbi',
      receiverName: 'user',
      transactionRefId: '',
      transactionNote: 'AiPremium',
      amount: 145.0,
    );
    final response = await zupi.startTransaction();
    print(response);

// Split the response string into individual key-value pairs
    List<String> keyValuePairs = response.split('&');

// Iterate over each key-value pair
    for (String pair in keyValuePairs) {
// Split the pair into key and value
      List<String> keyValuePair = pair.split('=');
      String key = keyValuePair[0];
      String value = keyValuePair[1];

// Check if the key is "Status"
      if (key == "Status") {
        print("Transaction status: $value");
        if (value == 'SUCCESS') {
          DateTime now = DateTime.now();
          String formattedDate = "${now.year + 1}${now.month + 1}${now.day}";

          http.Response response = await http.post(

              // how to print current date in flutter
              Uri.parse(
                  'https://www.nextonebox.com/earnmoney/NotGetUrls/Premium'),
              body: {
                'email': email.toString(),
                'ChatAiPrem': formattedDate.toString(),
              });

          dynamic dat = {
            'email': email.toString(),
            'name': name.toString(),
            'ChatAiPrem': formattedDate.toString(),
          };

          {
            showMessage(context, response.body);
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
          setState(() {
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              showCloseIcon: true,
              title: 'Success',
              desc: 'Congratulation you are upgraded please restart the app',
              btnOkOnPress: () {
                debugPrint('OnClcik');
              },
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {},
            ).show();
          });
        } else {
          setState(() {
            AwesomeDialog(
              context: context,
              animType: AnimType.leftSlide,
              headerAnimationLoop: false,
              dialogType: DialogType.success,
              showCloseIcon: true,
              title: 'Failed',
              desc: 'If you have paid please contact us',
              btnOkOnPress: () {},
              btnOkIcon: Icons.check_circle,
              onDismissCallback: (type) {},
            ).show();
          });
        }
        break; // Exit the loop since we have found the Status key
      }
    }
  }

  CheckPayment() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.question,
      body: Center(
        child: Column(children: [
          Text(
            'Do you have completed your payment.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                );
              },
              child: Text('Close Payment'))
        ]),
      ),
      keyboardAware: true,
      btnOkText: "Yes",
      btnCancelText: 'Cancel',
      title: '',
      padding: const EdgeInsets.all(5.0),
      onDismissCallback: (type) {
        Navigator.of(context).pop();
      },
      btnCancelOnPress: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
        showMessage(context, 'You missed the big earning opportunity');
      },
      btnOkOnPress: () async {
        var curl = await controller.currentUrl();
        String baseUrl = curl.toString().split('#')[1];
        if (baseUrl == 'true') {
          showMessage(context, 'Payment Success');
        } else {
          showMessage(context, 'Payment Failed ');
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );

        Timer(Duration(seconds: 10), () {
          SystemNavigator.pop();
        });
        setState(() {});
      },
    )..show();
  }

  late WebViewController controller;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate = "${now.year}${now.month + 1}${now.day}";

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.cancel_sharp,
                color: Colors.blue,
              ),
              onPressed: () {
                CheckPayment();
              })
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              child: Column(
                children: [
                  Container(
                      height: 50,
                      child: Row(
                        children: [
                          Text('           UPI           '),
                          GFButton(
                              onPressed: () async {
                                paymentkro();
                              },
                              color: Colors.green,
                              child: Text('Pay now'))
                        ],
                      )),
                  Flexible(
                    child: WillPopScope(
                      onWillPop: () async {
                        if (await controller.canGoBack()) {
                          controller.goBack();
                          var curl = await controller.currentUrl();
                          String baseUrl = curl.toString().split('#')[1];
                          if (baseUrl == 'true') {
                            CheckPayment();
                            return true;
                          }
                          if (baseUrl == 'false') {
                            CheckPayment();
                            return true;
                          } else {
                            return false;
                          }
                        } else {
                          CheckPayment();
                          return true;
                        }
                      },
                      child: WebView(
                        initialUrl:
                            'https://nextonebox.com/ccavRequestHandler?ChatAiPrem=999.0+${email}-${formattedDate.toString()}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) async {
                          this.controller = controller;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
