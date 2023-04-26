import '../OtherFiles/widgets.dart';
import 'package:http/http.dart' as http;

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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Contact us',
          style: TextStyle(
              color: PrColor, fontWeight: FontWeight.bold, fontSize: 30),
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
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text('     Subject :-         '),
                                DropdownButtonExample(),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
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
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                  ),
                                )),
                          ],
                        ),
                        Container(
                          width: 200,
                          height: 40,
                          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                                    builder: (context) => BottomNavigation()),
                              );
                              setState(() {});
                              var name = problem.text;

                              {
                                showMessage(context,
                                    'You have successfully send message');
                              }

                              http.Response response = await http.post(
                                  Uri.parse(
                                      'https://www.nextonebox.com/earnmoney/NotGetUrls/Appcontact'),
                                  body: {
                                    'message': name.toString(),
                                  });
                            },
                            text: "Send",
                          ),
                        ),
                        Text(
                            '\n\n\n\n Email : info@nextonebox.com \n\n Whatsapp only  :+91 8082803429  \n\n Social media  : nextonebox \n'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                SetAnalytic('Facebook');

                                var url = 'https://www.facebook.com/nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                size: 20,
                                color: PrColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                SetAnalytic('Youtube');

                                var url = 'https://www.youtube.com/@nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Icon(
                                FontAwesomeIcons.youtube,
                                size: 20,
                                color: PrColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                SetAnalytic('instagram');

                                var url =
                                    'https://www.instagram.com/nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Icon(
                                FontAwesomeIcons.instagram,
                                size: 20,
                                color: PrColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                SetAnalytic('instagram');

                                var url =
                                    'https://www.instagram.com/NextOneBox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Icon(
                                FontAwesomeIcons.twitter,
                                size: 20,
                                color: PrColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                SetAnalytic('telegram');

                                var url =
                                    'https://web.telegram.org/k/#@nextonebox';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Icon(
                                FontAwesomeIcons.telegram,
                                size: 20,
                                color: PrColor,
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
  "Premium",
  'Ads',
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
