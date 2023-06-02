import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import '../OtherFiles/widgets.dart';

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
    TextEditingController nameController = TextEditingController();
    TextEditingController accountController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

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
                                    vertical: 1, horizontal: 10),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    floatingLabelStyle:
                                        TextStyle(color: MainColor),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: MainColor,
                                    )),
                                    border: const OutlineInputBorder(),
                                    labelText: '$phonenumber',
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
                            color: Colors.green,
                            fullWidthButton: true,
                            textStyle: const TextStyle(
                              fontSize: 25,
                            ),
                            onPressed: () async {
                              var name = nameController.text;
                              var phone = phoneController.text;

                              if (name.length > 3) {
                                if (phone.length > 15) {
                                  {
                                    {
                                      showMessage(context, 'Please wait');
                                    }
                                    http.Response response = await http.post(
                                        Uri.parse(
                                            'https://www.nextonebox.com/earnmoney/NotGetUrls/AppAccountUpdateSetting'),
                                        body: {
                                          'name': name.toString(),
                                          'email': email.toString(),
                                          'phone': phone.toString(),
                                          'account': '..',
                                        });

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
                                      'Please enter correct Phone number');
                                }
                              } else {
                                _loadingWidget(
                                    context, 'Please enter Full Name');
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
