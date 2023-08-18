import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController problem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SecondaryColor,
        elevation: 0,
        title: const Text(
          'Contact us',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Text('     Message :-           '),
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: TextField(
                                  maxLines: 5,
                                  keyboardType: TextInputType.name,
                                  controller: problem,
                                  decoration: const InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: OutlineInputBorder(),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          width: 200,
                          height: 40,
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: GFButton(
                            shape: GFButtonShape.pills,
                            size: GFSize.LARGE,
                            color: MainColor,
                            fullWidthButton: true,
                            textStyle: const TextStyle(
                              fontSize: 25,
                            ),
                            onPressed: () async {
                              if (problem.text.length > 30) {
                                {
                                  var subject = 'MugCash';
                                  var message = problem.text.toString();
                                  var data =
                                      "          \n\nEmail: $email \nName: $name \nApp:MugCash";
                                  launch(
                                      'mailto:nextoneboxcheck@gmail.com?subject=$subject&body=$message$data');
                                }

                                // http.Response response = await http.post(
                                //     Uri.parse(
                                //         'https://fogcash.nextonebox.com/ContactUs'),
                                //     body: {
                                //       'message': data.toString(),
                                //     });

                                // setState(() {
                                //   problem.clear();
                                // });
                                // {
                                //   showMessage.show(context,
                                //       ' Successfully sent \n Reply in 24 hours through Email');
                                // }
                              } else {
                                {
                                  showMessage.show(context,
                                      'Define your problem in atleast in 30 words');
                                }
                              }
                            },
                            text: "Send",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
