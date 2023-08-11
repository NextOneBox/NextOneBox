import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:figtrade/Profile_Page.dart';
import 'package:figtrade/widget.dart';
import 'package:http/http.dart' as http;
import 'Trans_history.dart';
import 'package:intl/intl.dart';

class payout_page extends StatefulWidget {
  const payout_page({super.key});

  @override
  State<payout_page> createState() => _payout_pageState();
}

bool upi = false;
var withdrwalamountcon = TextEditingController();
var Ifccondecon = TextEditingController();
var AccountNOcon = TextEditingController();
var Banknamecon = TextEditingController();

class _payout_pageState extends State<payout_page> {
  // Initial Selected Value
  String dropdownvalue = 'BANK_TRANSFER';

// List of items in our dropdown menu
  var items = [
    'BANK_TRANSFER',
    'UPI_TRANSFER',
  ];
  var loading = false;
  @override
  Widget build(BuildContext context) {
    var bctff = Color.fromARGB(255, 32, 32, 42);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: c6,
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => trans_history()));
              },
              child: Icon(
                Icons.history,
              ))
        ],
        automaticallyImplyLeading: false,
        leading: BackButton(color: c3),
        title: Text(
          'Withdraw',
          style: textstyle,
        ),
        centerTitle: true,
        backgroundColor: c6,
      ),
      bottomNavigationBar: Container(
        color: bctff,
        height: 60,
        child: GestureDetector(
            onTap: () async {
              if (RealDemo?.get("real") < 400) {
                Fluttertoast.showToast(
                    msg: "Minimium payout is ₹400",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: c6,
                    textColor: c3,
                    fontSize: 16.0);
              } else if (AccountNOcon.text.isEmpty ||
                  Ifccondecon.text.isEmpty ||
                  Banknamecon.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: "please fill all details",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: c6,
                    textColor: c3,
                    fontSize: 16.0);
              } else if (int.parse(withdrwalamountcon.text) < 399) {
                Fluttertoast.showToast(
                    msg: "Minimium payout is ₹400",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: c6,
                    textColor: c3,
                    fontSize: 16.0);
              } else {
                setState(() {
                    loading = true;
                });
              
                http.Response response1 = await http.post(
                    Uri.parse('https://realcash.nextonebox.com/UpdateBallance'),
                    body: {
                      'email': userdata!.get(0)['email'].toString(),
                      'amount': withdrwalamountcon.text.toString(),
                    });
                if (response1.body == 'don') {
                  http.Response response = await http.post(
                      Uri.parse('https://realcash.nextonebox.com/AddWidrawRequest'),
                      body: {
                        'email': userdata!.get(0)['email'].toString(),
                        'amount': withdrwalamountcon.text.toString(),
                        'accountnumber':
                            "${AccountNOcon.text.toString()} ,${Ifccondecon.text.toString()}",
                      });
                  print(response.body);
                  if (response.body == 'Request accepted') {
                    setState(() {
                       loading =false;
                      var minusamount = RealDemo?.get("real") -
                          int.parse(withdrwalamountcon.text);
                      RealDemo?.put('real', minusamount);
                      DateTime now = DateTime.now();
                      String monthName =
                          DateFormat.MMMM().format(now); // Get month name
                      String date = DateFormat.d().format(now); // Get date
                      String hour = DateFormat.H()
                          .format(now); // Get hour in 24-hour format
                      String minute = DateFormat.m().format(now); // Get minute
                      transwithdralhistory?.add({
                        "amount": withdrwalamountcon.text,
                        "date": "$monthName $date",
                        "time": "$hour:$minute",
                        "status": 'Sucess',
                        'sucess': true
                      });
                    });
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.leftSlide,
                      headerAnimationLoop: false,
                      transitionAnimationDuration: Duration(seconds: 0),
                      dialogType: DialogType.success,
                      showCloseIcon: true,
                      title: 'Succes',
                      desc:
                          'Transfer fund will be cridet in your account within 24hour',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                      onDismissCallback: (type) {},
                    ).show();
                  }
                }
              }
            },
            child: Container(
                child: Center(
                    child: loading
                        ? CircularProgressIndicator()
                        : Text(
                            'Withdraw',
                            style: TextStyle(
                                fontSize: 17,
                                color: c3,
                                fontWeight: FontWeight.bold),
                          )),
                decoration: BoxDecoration(
                    color: buttoncolor,
                    borderRadius: BorderRadius.circular(8)))),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sh(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Balance',
                    style: textstyle,
                  ),
                  Text(
                    ' ₹ ${RealDemo?.get("real")}',
                    style: TextStyle(color: green, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              sh(25),
              Text(
                'Withdrawal Amount',
                style: textstyle,
              ),
              sh(5),
              Container(
                // height: 50,
                decoration: BoxDecoration(
                    color: bctff, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: withdrwalamountcon,
                  keyboardType: TextInputType.number,
                  cursorColor: c3,
                  autocorrect: true,
                  style: textstyle,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.currency_rupee,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Enter Withdrawal Amount',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 128, 123, 123),
                    ),
                  ),
                ),
              ),
              Text(
                'Minimium withdrwal is ₹400',
                style: TextStyle(color: Colors.red),
              ),
              sh(10),
              Text(
                'Transfer Type',
                style: textstyle,
              ),
              sh(5),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    color: bctff, borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  underline: Text(''),
                  dropdownColor: c6,
                  value: dropdownvalue,
                  style: textstyle,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: c3,
                  ),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text("    ${items}"),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      if (upi == false) {
                        upi = true;
                      } else {
                        upi = false;
                      }
                    });
                  },
                ),
              ),
              sh(10),
              Text(
                upi ? 'UPI' : 'IFC Code',
                style: textstyle,
              ),
              sh(5),
              Container(
                decoration: BoxDecoration(
                    color: bctff, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: Ifccondecon,
                  cursorColor: c3,
                  autocorrect: true,
                  style: textstyle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: upi ? 'Enter UPI Adress' : 'Enter IFC Code',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 128, 123, 123),
                    ),
                  ),
                ),
              ),
              sh(10),
              Text(
                upi ? 'Phone' : 'Bank Account No',
                style: textstyle,
              ),
              sh(5),
              Container(
                decoration: BoxDecoration(
                    color: bctff, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: AccountNOcon,
                  cursorColor: c3,
                  autocorrect: true,
                  style: textstyle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: upi ? 'Enter Phone No' : 'Enter Bank Account No',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 128, 123, 123),
                    ),
                  ),
                ),
              ),
              sh(10),
              Text(
                'Name',
                style: textstyle,
              ),
              sh(5),
              Container(
                decoration: BoxDecoration(
                    color: bctff, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: Banknamecon,
                  cursorColor: c3,
                  autocorrect: true,
                  style: textstyle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: upi ? 'Enter Your Name' : 'Enter Bank Name',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 128, 123, 123),
                    ),
                  ),
                ),
              ),
              sh(30),
              Text(
                '* Please fill all the detail correctly and carefully',
                style: textstyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
