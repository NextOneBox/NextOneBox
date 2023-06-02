
import 'package:http/http.dart' as http;
import 'widgets.dart';

class LoginOtp extends StatefulWidget {
  LoginOtp({super.key, required this.data});
  final data;
  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

var loco = Color.fromARGB(255, 0, 0, 0);

class _LoginOtpState extends State<LoginOtp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otpCont = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 200, left: 30, bottom: 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/Nob.png',
                    fit: BoxFit.fill,
                    height: 50,
                  ),
                  Text(
                    'NextOneBox',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40, left: 30),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Enter otp send to \n ' '${widget.data}',
                      style: TextStyle(fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScr()),
                          );
                        },
                        icon: Icon(
                          Icons.edit_note_outlined,
                          color: Colors.blue,
                        ))
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 250,
                    padding: EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: otpCont,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: loco,
                          )),
                          border: OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: loco),
                          labelText: 'Otp',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.insert_comment_sharp,
                              color: loco,
                            ),
                          )),
                    ),
                  ),
                  GFButton(
                    onPressed: () async {
                      {
                        showMessage(context, 'Please wait');
                      }

                      http.Response response = await http.post(
                          Uri.parse(
                              'https://www.nextonebox.com/earnmoney/NotGetUrls/AppCreateAccountNew'),
                          body: {
                            'email': widget.data,
                            'otp': otpCont.text,
                            'name': 'user'
                          });
                      DateTime now = DateTime.now();
                      final formattedDate = "${now.year}${now.month}${now.day}";
                      if (response.body == 'Login') {
                        dynamic dat = {
                          'email': widget.data.toString(),
                          'name': 'user',
                          'ChatAiPrem': formattedDate,
                          'Refercode': '..'
                        };

                        await account.add(dat);
                        await adtime.put(1, 0);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigation()),
                          (Route<dynamic> route) => false,
                        );
                        Ontimecall();
                        // callmyadsnow();
                      }
                      if (response.body == 'account created') {
                        dynamic dat = {
                          'email': widget.data.toString(),
                          'name': 'user',
                          'ChatAiPrem': formattedDate,
                          'Refercode': '..'
                        };

                        await account.add(dat);
                        await adtime.put(1, 0);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavigation()),
                          (Route<dynamic> route) => false,
                        );
                        Ontimecall();
                        // callmyadsnow();
                      }
                      {
                        showMessage(context, response.body);
                      }
                    },
                    color: loco,
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    text: 'n e x t',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
