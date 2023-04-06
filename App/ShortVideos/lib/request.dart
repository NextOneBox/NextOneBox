import 'package:getwidget/getwidget.dart';
import 'package:nobs/wallet.dart';

import 'widgets.dart';
import 'package:http/http.dart' as http;

class Request extends StatefulWidget {
  final ammount;
  const Request({super.key, required, this.ammount});

  @override
  State<Request> createState() => _RequestState();
}

final MainColor = Color.fromARGB(255, 196, 198, 196);

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    TextEditingController accountController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Send request',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 3),
            child: Row(
              children: [
                Text(
                  'Account Details',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
              child: TextField(
                controller: accountController,
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: MainColor),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: MainColor,
                  )),
                  border: const OutlineInputBorder(),
                  labelText: 'Paytm no / PayPal id / Upi id',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.account_balance, color: MainColor),
                  ),
                ),
              )),
          SizedBox(
            height: 100,
          ),
          Container(
            height: 50,
            width: 250,
            child: GFButton(
              text: 'send',
              onPressed: () async {
                int a = localballance!.get(0) ?? 0;
                if (a > widget.ammount) {
                  if (accountController.text.length > 5) {
                    http.Response response = await http.post(
                        Uri.parse('https://www.nextonebox.com/NobSWidraw'),
                        body: {
                          'account': accountController.text.toString(),
                          'ballance': widget.ammount.toString(),
                        });
                    {
                      showMessage(context,
                          'Your request is sended. Wait for 24 hours.');
                    }
                    int a = localballance!.get(0) ?? 0;
                    int b = widget.ammount;
                    localballance!.put(0, (a - b));
                  } else {
                    {
                      showMessage(context, 'Please enter correct id.');
                    }
                  }
                } else {
                  {
                    showMessage(context,
                        'You have already sended request wait for 24 hours');
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
