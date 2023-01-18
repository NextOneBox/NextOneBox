import '../otherfiles/widgets.dart';
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
                        SizedBox(
                          height: 100,
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, bottom: 3),
                              child: Row(
                                children: [
                                  Text(
                                    'Happy to hear from you.',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
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
                                    labelText: '       Explain  ',
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
                              var name = problem.text;

                              {
                                showMessage(context,
                                    'You have successfully send message');
                              }

                              http.Response response = await http.post(
                                  Uri.parse(
                                      'https://www.nextonebox.com/earnmoney/NotGetUrls/Appcontact'),
                                  body: {
                                    'name': name.toString(),
                                  });
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
