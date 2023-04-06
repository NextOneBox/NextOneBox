import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

var MainColor = Colors.white;
// Box account = Hive.box('pages');

class _PagesState extends State<Pages> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Toady  ",
            style: TextStyle(color: Colors.black),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body:ListView(
      // Card(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Container(
      //         margin:
      //             const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
      //         child: TextField(
      //           keyboardType: TextInputType.name,
      //           controller: nameController,
      //           decoration: InputDecoration(
      //             floatingLabelStyle: TextStyle(color: MainColor),
      //             focusedBorder: OutlineInputBorder(
      //                 borderSide: BorderSide(
      //               color: MainColor,
      //             )),
      //             border: const OutlineInputBorder(),
      //             labelText: '*      Namaz    5:00 - 6:00   0%',
      //           ),
      //         )),
      //   ),
      // ),
      )
      
      
       
    );
  }
}

const List<String> genderlist = <String>[
  "0",
  "50",
  '60',
  '70',
  '80',
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
    return Card(
      elevation: 10,
      child: DropdownButton<String>(
        value: genderlistdropdownValue,
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            genderlistdropdownValue = value!;
          });
        },
        items: genderlist.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value + '%'),
          );
        }).toList(),
      ),
    );
  }
}
