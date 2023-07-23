import 'package:onesite/helper.dart';

import 'package:http/http.dart' as http;


class LoginOtp extends StatefulWidget {
  const LoginOtp({super.key, required this.data});
  final data;
  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

var loco = const Color.fromARGB(255, 0, 0, 0);

class _LoginOtpState extends State<LoginOtp> {
  @override
  Widget build(BuildContext context) {
    TextEditingController otpCont = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 200, left: 30, bottom: 10),
              child: Row(
                children: [
                  Image.asset(
                    'assets/Nob.png',
                    fit: BoxFit.fill,
                    height: 50,
                  ),
                  const Text(
                    'NextOneBox',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 40, left: 30),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                      'Enter otp send to \n ' '${widget.data}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    IconButton(
                        onPressed: () {
           
                        },
                        icon: const Icon(
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
                    padding: const EdgeInsets.only(left: 20),
                    child: TextField(
                      controller: otpCont,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: loco,
                          )),
                          border: const OutlineInputBorder(),
                          floatingLabelStyle: TextStyle(color: loco),
                          labelText: 'Otp',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.insert_comment_sharp,
                              color: loco,
                            ),
                          )),
                    ),
                  ),
                  GFButton(
                    onPressed: () async {
                  
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
