import 'package:http/http.dart' as http;
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

var check;
DateTime? selected;

class _AccountSettingState extends State<AccountSetting> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationID;
  var checkcodeenterbox = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController accountController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    if (phonenumber.toString().length != 10) {
      check = true;
    } else {
      check = false;
    }
    dynamic selecteddate = '';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: SecondaryColor,
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: MainColor,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 3),
                              child: const Row(
                                children: [
                                  Text(
                                    'Full Name',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextField(
                                  keyboardType: TextInputType.name,
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        const TextStyle(color: MainColor),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$name',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child:
                                          Icon(Icons.person, color: MainColor),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, bottom: 3, top: 10),
                              child: const Row(
                                children: [
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        const TextStyle(color: MainColor),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$phonenumber',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '+',
                                            style: TextStyle(
                                                fontSize: 18, color: MainColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 3),
                              child: const Row(
                                children: [
                                  Text(
                                    'Paypal | Paytm number',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextField(
                                  controller: accountController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        const TextStyle(color: MainColor),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$AccountNumber',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(Icons.account_balance,
                                          color: MainColor),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 3),
                              child: const Row(
                                children: [
                                  Text(
                                    'Gender Male | Femail',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextField(
                                  controller: genderController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        const TextStyle(color: MainColor),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$gender',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(FontAwesomeIcons.genderless,
                                          color: MainColor),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 3),
                              child: const Row(
                                children: [
                                  Text(
                                    'Date of Birth  - Year (2000)',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextField(
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        const TextStyle(color: MainColor),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$age  year',
                                    prefixIcon: const Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(Icons.date_range,
                                          color: MainColor),
                                    ),
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
                              var name = nameController.text;
                              var phone = phoneController.text;
                              var account = accountController.text;
                              var Gender = genderController.text;
                              var Age = ageController.text;
                              if (name.length > 3) {
                                if (account.length > 3) {
                                  {
                                    showMessage.show(context, 'Please wait ');
                                  }
                                  http.Response response = await http.put(
                                      Uri.parse(
                                          'https://fogcash.nextonebox.com/UpdateAccount'),
                                      body: {
                                        'Name': name.toString(),
                                        'Email': email.toString(),
                                        'PhoneNumber': phone.toString(),
                                        'Account': account.toString(),
                                        'Gender': Gender.toString(),
                                        'Age': Age.toString()
                                      });
                                  if (response.reasonPhrase == 'OK') {
                                    SendAllData();
                                         {
                                    showMessage.show(context, 'Setting updated ');
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigation()),
                                  );
                                  }

                                  
                                } else {
                                  showMessage.show(context,
                                      'Please enter Paypal ID \n or Paytm number');
                                }
                              } else {
                                showMessage.show(context, 'Please enter Full Name');
                              }
                            },
                            text: "Save",
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
