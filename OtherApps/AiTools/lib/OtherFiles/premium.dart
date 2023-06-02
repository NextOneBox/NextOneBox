// import 'package:MyChatAi/OtherFiles/pay.dart';
// import 'package:MyChatAi/OtherFiles/payyea.dart';
// import 'package:MyChatAi/OtherFiles/widgets.dart';

// import '../OtherFiles/widgets.dart' as widgets;
// import 'package:http/http.dart' as http;

// class Premium extends StatefulWidget {
//   const Premium({super.key});

//   @override
//   State<Premium> createState() => _PremiumState();
// }

// class _PremiumState extends State<Premium> {
// // how to give background image in flutter scaffold
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   leading: IconButton(
//       //     icon: Icon(Icons.arrow_back_ios_new_rounded, color: MainColor),
//       //     onPressed: () {
//       //       Navigator.push(
//       //         context,
//       //         MaterialPageRoute(builder: (context) => BottomNavigation()),
//       //       );
//       //     },
//       //   ),
//       //   title: Padding(
//       //     padding: EdgeInsets.all(8.0),
//       //     child: Text(
//       //       "Become a Premium user",
//       //       style: TextStyle(color: MainColor),
//       //       maxLines: 2,
//       //       textAlign: TextAlign.center,
//       //     ),
//       //   ),
//       //   backgroundColor: botBackgroundColor,
//       // ),

//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/a.png'),
//             opacity: 0.7,
//             colorFilter: ColorFilter.srgbToLinearGamma(),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Column(
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       '      MyChatAi  ',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Container(
//                         width: 70,
//                         height: 50,
//                         child: Card(
//                             color: Colors.amber,
//                             child: Center(
//                                 child: Text(
//                               'Pro',
//                               style: texSty,
//                             )))),
//                   ],
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.star_purple500_outlined,
//                     color: Colors.amber,
//                   ),
//                   Text(
//                     '    Higher quality response content',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.star_purple500_outlined,
//                     color: Colors.amber,
//                   ),
//                   Text(
//                     '    No ads',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.star_purple500_outlined,
//                     color: Colors.amber,
//                   ),
//                   Text(
//                     '    Unlimited message',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.star_purple500_outlined,
//                     color: Colors.amber,
//                   ),
//                   Text(
//                     '    Ai Image Creation',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.star_purple500_outlined,
//                     color: Colors.amber,
//                   ),
//                   Text(
//                     '    Fast asnwers',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BottomNavigation()),
//                 );
//               },
//               child: Container(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.all(Radius.circular(20))),
//                       child: Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Column(
//                           children: [
//                             Center(
//                                 child: Text(
//                               ' Free ',
//                               style: TextStyle(color: MainColor, fontSize: 20),
//                             )),
//                             Center(
//                                 child: Text(
//                               '  Continue with Ads ',
//                               style: TextStyle(color: MainColor, fontSize: 15),
//                             )),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Pay()),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                         child: Padding(
//                           padding: const EdgeInsets.all(20),
//                           child: Column(
//                             children: [
//                               Center(
//                                   child: Text(
//                                 'Monthly',
//                                 style:
//                                     TextStyle(color: MainColor, fontSize: 20),
//                               )),
//                               Center(
//                                   child: Text(
//                                 '30% off',
//                                 style:
//                                     TextStyle(color: MainColor, fontSize: 15),
//                               )),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   //how to cut text in flutter
//                   Container(
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Color.fromARGB(255, 124, 240, 29),
//                             Color.fromARGB(255, 244, 100, 10),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(20))),
//                     height: 80,
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PayYear()),
//                         );
//                       },
//                       child: Center(
//                           child: Text(
//                         " Yearly                 50% off",
//                         style: TextStyle(color: Colors.black, fontSize: 25),
//                       )),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // how to write dollar sign in string in flutter
