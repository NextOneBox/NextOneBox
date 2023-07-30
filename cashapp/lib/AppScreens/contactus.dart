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
                      if(problem.text.length > 0 ){


                    setState(() {});
                                  var data = "Email: $email ,Name: $name ,Problem: ${problem.text}, Phone:$phonenumber ,Date: ${DateTime.now().toString()}";
                             

                              {
                                showMessage.show(context,
                                    ' Successfully sent \n Reply in 24 hours through Email');
                              }

                              http.Response response = await http.post(
                                  Uri.parse(
                                      'https://fogcash.nextonebox.com/ContactUs'),
                                  body: {
                                    'message': data.toString(),
                                  });   }
                             else{

   {
                                showMessage.show(context,
                                    'Define your problem');
                              }


                             }
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
                                color: Colors.red,
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
                                color: Colors.blue,
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
                                color: Colors.red,
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
                                color: Colors.blue,
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
