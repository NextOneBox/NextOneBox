import 'package:cashapp/ComonScreens/widgets.dart';
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
                                Text('     Subject :-         '),
                                DropdownButtonExample(),
                              ],
                            ),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  BottomNavigation()),
                              );
                              setState(() {});
                                  var data = "Email: $email ,Name: $name ,Problem: ${problem.text}, Phone:$phonenumber ,Date: ${DateTime.now().toString()}";
                             

                              {
                                showMessage(context,
                                    'Reply in 24 hours');
                              }

                              http.Response response = await http.post(
                                  Uri.parse(
                                      'https://fogcash.nextonebox.com/ContactUs'),
                                  body: {
                                    'message': data.toString(),
                                  });
                            },
                            text: "Send",
                          ),
                        ),
                        const Text(
                            '\n\n\n\n Email : info@nextonebox.com \n\n Social media  : nextonebox \n'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                var url = 'https://www.facebook.com/nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.facebook,
                                size: 20,
                                color: MainColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                var url = 'https://www.youtube.com/@nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.youtube,
                                size: 20,
                                color: MainColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                var url =
                                    'https://www.instagram.com/nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.instagram,
                                size: 20,
                                color: MainColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                var url =
                                    'https://www.instagram.com/NextOneBox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.twitter,
                                size: 20,
                                color: MainColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                var url =
                                    'https://web.telegram.org/k/#@nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: const Icon(
                                FontAwesomeIcons.telegram,
                                size: 20,
                                color: MainColor,
                              ),
                            ),
                          ],
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

const List<String> genderlist = <String>[
  "Withdraw",
  'Ads',
  'Payment',
  'Task',
  'Other',
];

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

String genderlistdropdownValue = genderlist.first;

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: genderlistdropdownValue,
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      underline: Container(
        height: 2,
        color: MainColor,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          genderlistdropdownValue = value!;
        });
      },
      items: genderlist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
