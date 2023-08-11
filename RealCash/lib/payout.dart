import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'Widget.dart';

class payout_page extends StatefulWidget {
  const payout_page({super.key});

  @override
  State<payout_page> createState() => _payout_pageState();
}

bool upi = false;


class _payout_pageState extends State<payout_page> {
  // Initial Selected Value
  String dropdownvalue = 'BANK_TRANSFER';

// List of items in our dropdown menu
  var items = [
    'BANK_TRANSFER',
    'UPI_TRANSFER',
  ];

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
            onTap: () {
            },
            child: Container(
                child: Center(
                    child: Text(
                  'Withdraw',
                  style: TextStyle(
                      fontSize: 17, color: c3, fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                    color: c1,
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
                    ' ₹ 857',
                    style: TextStyle(color: c3, fontWeight: FontWeight.bold),
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
                  // controller: withdrwalamountcon,
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
                upi ? 'VPA' : 'IFC Code',
                style: textstyle,
              ),
              sh(5),
              Container(
                decoration: BoxDecoration(
                    color: bctff, borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  // controller: Ifccondecon,
                  cursorColor: c3,
                  autocorrect: true,
                  style: textstyle,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: upi ? 'Enter VPA Adress' : 'Enter IFC Code',
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
                  // controller: AccountNOcon,
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
                  // controller: Banknamecon,
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