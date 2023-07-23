// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../ComonScreens/widgets.dart';
// class dailyreward extends StatefulWidget {
//   const dailyreward({super.key});

//   @override
//   State<dailyreward> createState() => _dailyrewardState();
// }


// class _dailyrewardState extends State<dailyreward> {
//   dailclickscheack() async {
//     dynamic lastclick = adsbox!.get(20)['lastclick'];
//     DateTime presenttime = DateTime.now();
//     Duration difference = presenttime.difference(lastclick);
//     int clicks = adsbox!.get(21)['clicks'];

//     if (clicks == 1) {
//       if (difference.inHours > 24) {
//         adsbox!.put(21, {'clicks': 0});
//         adsbox!.put(20, {'lastclick': DateTime.now()});
//       } else {
//         {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               backgroundColor: Colors.white,
//               content:
//                   Text('Your Reward is Not ready ')));
//         }
//       }
//     } else {
//       if (adsbox?.get(
//             'reward',
//           )['d1'] ==
//           true) {
//         adsbox?.put('re', {
//           'day1': true,
//           'day2': false,
//           'day3': false,
//           'day4': false,
//           'day5': false,
//           'day6': false,
//           'day7': false,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': true,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 100.toString(),
//                   });
       
//         adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//       }
//       else if (adsbox?.get('reward',)['d2'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': false,
//           'day4': false,
//           'day5': false,
//           'day6': false,
//           'day7': false,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': true,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 200.toString(),
//                   });
//        adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d3'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': false,
//           'day5': false,
//           'day6': false,
//           'day7': false,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': true,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 300.toString(),
//                   });
//         adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d4'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': false,
//           'day6': false,
//           'day7': false,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': true,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 400.toString(),
//                   });
//        adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d5'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': true,
//           'day6': false,
//           'day7': false,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': true,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 500.toString(),
//                   });
//         adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d6'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': true,
//           'day6': true,
//           'day7': false,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': true,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 600.toString(),
//                   });
//         adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d7'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': true,
//           'day6': true,
//           'day7': true,
//           'day8': false,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': true,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 700.toString(),
//                   });
//        adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d8'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': true,
//           'day6': true,
//           'day7': true,
//           'day8': true,
//           'day9': false,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': true,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 800.toString(),
//                   });
//        adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d9'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': true,
//           'day6': true,
//           'day7': true,
//           'day8': true,
//           'day9': true,
//           'day10': false,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': true,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 900.toString(),
//                   });
//        adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
//       else if (adsbox?.get('reward',)['d10'] == true){
//             adsbox?.put('re', {
//           'day1': true,
//           'day2': true,
//           'day3': true,
//           'day4': true,
//           'day5': true,
//           'day6': true,
//           'day7': true,
//           'day8': true,
//           'day9': true,
//           'day10': true,
//         });
//         adsbox?.put('reward', {
//           'd1': false,
//           'd2': false,
//           'd3': false,
//           'd4': false,
//           'd5': false,
//           'd6': false,
//           'd7': false,
//           'd8': false,
//           'd9': false,
//           'd10': false,
//         });
//           http.Response response = await http.post(
//                   Uri.parse('https://zaheermir.com/UpdateBallance'),
//                   body: {
//                     'email': email,
//                     'amount': 1000.toString(),
//                   });
//        adsbox!.put(21, {'clicks': clicks + 1});
//          adsbox?.put(20, {'lastclick': DateTime.now()});
//         setState(() {});
//             }
      
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day1'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 1'),
//                     adsbox?.get(
//                       're',
//                     )['day1']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('10.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day2'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 2'),
//                     adsbox?.get(
//                       're',
//                     )['day2']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('20.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day3'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 3'),
//                     adsbox?.get(
//                       're',
//                     )['day3']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('30.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day4'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 4'),
//                     adsbox?.get(
//                       're',
//                     )['day4']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('40.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day5'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 5'),
//                     adsbox?.get(
//                       're',
//                     )['day5']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('50.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day6'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 6'),
//                     adsbox?.get(
//                       're',
//                     )['day6']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('60.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day7'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 7'),
//                     adsbox?.get(
//                       're',
//                     )['day7']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('70.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day8'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 8'),
//                     adsbox?.get(
//                       're',
//                     )['day8']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('80.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day9'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 9'),
//                     adsbox?.get(
//                       're',
//                     )['day9']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('90.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (adsbox?.get(
//                     're',
//                   )['day10'] ==
//                   false) {
//                 dailclickscheack();
//               }
//             },
//             child: Card(
//               elevation: 50,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 width: 60,
//                 height: 70,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Day 10'),
//                     adsbox?.get(
//                       're',
//                     )['day10']
//                         ? Icon(
//                             Icons.check_box,
//                             color: Colors.white,
//                           )
//                         : Text(
//                             '₹',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 20),
//                           ),
//                     Text('100.00'),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }