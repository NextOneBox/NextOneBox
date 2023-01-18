import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../otherfiles/widgets.dart';

class AccountSetting extends StatefulWidget {
  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

var check;
DateTime? selected;

class _AccountSettingState extends State<AccountSetting> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationID;
  var checkcodeenterbox = false;
  @override
  Widget build(BuildContext context) {
    Gender? gender;
    TextEditingController nameController = TextEditingController();
    TextEditingController accountController = TextEditingController();
    TextEditingController refercodeController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
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
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(
              color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: PrColor,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20, bottom: 3),
                              child: Row(
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
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$name',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
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
                              margin:
                                  EdgeInsets.only(left: 20, bottom: 3, top: 10),
                              child: Row(
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
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$phonenumber',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '+91',
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
                                margin: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 20),
                                child: TextField(
                                  controller: accountController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$AccountNumber',
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
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
                                  EdgeInsets.only(left: 20, bottom: 3, top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Age:-  Year of birth (eg : - 2003) ',
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
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: age,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(Icons.assignment_ind,
                                          color: MainColor),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        Visibility(
                          visible: check,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20, bottom: 3),
                                child: Row(
                                  children: [],
                                ),
                              ),
                              Visibility(
                                visible: checkcodeenterbox,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 20),
                                    child: TextField(
                                      controller: refercodeController,
                                      decoration: InputDecoration(
                                        floatingLabelStyle:
                                            TextStyle(color: MainColor),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          color: MainColor,
                                        )),
                                        border: const OutlineInputBorder(),
                                        labelText: ' Refer code if any ',
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Icon(Icons.gif_outlined,
                                              color: MainColor),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: checkcodeenterbox,
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          checkcodeenterbox = true;
                                        });
                                      },
                                      child: Text(
                                        '                              Refer code(if any)',
                                        style: TextStyle(
                                            fontSize: 10, color: PrColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                              var name = nameController.text;
                              var phone = phoneController.text;
                              var account = accountController.text;
                              var age = ageController.text;
                              var gender = genderController.text;
                              var refercode = refercodeController.text;

                              if (refercode == '$Refercode') {
                                {
                                  showMessage(context,
                                      'Pleace enter Correct refer code');
                                }
                              } else {
                                if (name.length > 3) {
                                  if (phone.length == 10) {
                                    if (account.length > 3) {
                                      if (age.length > 1) {
                                        {
                                          showMessage(context, 'Please wait');
                                        }
                                        http.Response response = await http.post(
                                            Uri.parse(
                                                'https://www.nextonebox.com/earnmoney/NotGetUrls/AppAccountUpdate'),
                                            body: {
                                              'name': name.toString(),
                                              'gender': gender.toString(),
                                              'email': email.toString(),
                                              'phone': phone.toString(),
                                              'account': account.toString(),
                                              'age': age.toString(),
                                              'referby': refercode.toString(),
                                            });

                                        if (response.body ==
                                            'Setting updated with refer code') {
                                          {
                                            showMessage(context,
                                                'You have earn 25 ₹ rupees');
                                          }

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavigation()),
                                          );
                                        } else {
                                          {
                                            showMessage(context, response.body);
                                          }

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavigation()),
                                          );
                                        }
                                      } else {
                                        _loadingWidget(context,
                                            'Please enter year of birth eg:- 2003 ');
                                      }
                                    } else {
                                      _loadingWidget(context,
                                          'Please enter your UPI id or Paytm number');
                                    }
                                  } else {
                                    _loadingWidget(context,
                                        'Please enter 10 digit Phone number');
                                  }
                                } else {
                                  _loadingWidget(
                                      context, 'Please enter Full Name');
                                }
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

Widget _loadingWidget(BuildContext context, message) {
  return Flushbar(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    backgroundColor: Colors.black,
    margin: EdgeInsets.all(20),
    duration: Duration(seconds: 3),
  )..show(context);
}
