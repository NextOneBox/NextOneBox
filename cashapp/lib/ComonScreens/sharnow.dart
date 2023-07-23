import 'dart:async';

import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShareNow extends StatefulWidget {
  const ShareNow({super.key});

  @override
  State<ShareNow> createState() => _ShareNowState();
}

List<dynamic> contact = [];

class _ShareNowState extends State<ShareNow> {
  bool isLoaded = false;
  void fetchContactsAndPrint() async {
    bool permissionStatus = await Permission.contacts.isGranted;

    if (permissionStatus == true) {
      contact = await FastContacts.getAllContacts();

      setState(() {});
    } else {
      await Permission.contacts.request();
      setState(() {
        fetchContactsAndPrint();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    fetchContactsAndPrint();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 500,
            height: 120,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/refer.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              'Share Now 5 Friends Earn ₹125 ',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: GFButton(
                    fullWidthButton: true,
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    color: const Color.fromARGB(255, 245, 245, 245),
                    onPressed: () async {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigation()),
                        (Route<dynamic> route) => false,
                      );
                                  fallyoutube(context,);
                    },
                    textColor: Colors.blueAccent,
                    text: "Done | Skip",
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                 

                  var url =
                      'https://wa.me/?text=%0AHey%2C%20Do%20you%20want%20to%20earn%20%0A%0A%F0%9F%93%B2%F0%9F%92%B0%20%E2%82%B910%2C000%20per%2Fday%20without%20any%20investment%F0%9F%98%83.%0A%0A%E2%9C%85%20Then%20what%20are%20you%20waiting%20for%20Download%20now%20FogCash%0A%E2%9C%85%20And%20use%20my%20refer%20code%20${user.get(0)['Refercode']}%20%0A%E2%9C%85%20Thousands%20of%20users%20are%20already%20earning.%F0%9F%92%B0%F0%9F%92%A5%F0%9F%92%A5%20%0A%0A%E2%9C%85%20FogCash%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.cashapp%0A%0A%E2%9C%85%20ChatGpt%20App%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.chatgpt';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Card(
                  color: Colors.blueAccent,
                  child: Container(
                    margin: const EdgeInsets.only(left: 50),
                    width: 150,
                    height: 60,
                    child: const Row(
                      children: [
                        Text('Share now '),
                        Icon(
                          FontAwesomeIcons.whatsapp,
                          size: 50,
                          color: Color.fromARGB(255, 11, 75, 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              color: Colors.white,
              child: StreamBuilder<Object>(
                  stream: null,
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: contact.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              
                              var v = contact[index].phones[0].number;

                              var url =
                                  'https://wa.me/${v.toString()}?text=%0AHey%2C%20Do%20you%20want%20to%20earn%20%0A%0A%F0%9F%93%B2%F0%9F%92%B0%20%E2%82%B910%2C000%20per%2Fday%20without%20any%20investment%F0%9F%98%83.%0A%0A%E2%9C%85%20Then%20what%20are%20you%20waiting%20for%20Download%20now%20CashApp%0A%E2%9C%85%20And%20use%20my%20refer%20code%20${user.get(0)['Refercode']}%20%0A%E2%9C%85%20Thousands%20of%20users%20are%20already%20earning.%F0%9F%92%B0%F0%9F%92%A5%F0%9F%92%A5%20%0A%0A%E2%9C%85%20FogCash%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.cashapp%0A%0A%E2%9C%85%20ChatGpt%20App%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.chatgpt';
                              if (await canLaunch(url)) {
                                await launch(url);
                              }
                            },
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                          ' Earn\n  ₹25',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 108, 106, 106)),
                                        )),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: 150,
                                            child: Text(
                                              contact[index]
                                                  .displayName!
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 68, 68, 68),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            contact[index]
                                                .phones[0]
                                                .number
                                                .toString(),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 68, 68, 68),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 50),
                                      width: 60,
                                      height: 40,
                                      child: const Icon(
                                        FontAwesomeIcons.whatsapp,
                                        size: 50,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
