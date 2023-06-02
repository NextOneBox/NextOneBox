// // ignore_for_file: use_build_context_synchronously, avoid_single_cascade_in_expression_statements

// import 'widgets.dart';

// class Pay extends StatefulWidget {
//   const Pay({super.key});

//   @override
//   State<Pay> createState() => _PayState();
// }

// class _PayState extends State<Pay> {
//   CheckPayment() {
//     AwesomeDialog(
//       context: context,
//       animType: AnimType.scale,
//       dialogType: DialogType.question,
//       body: Center(
//         child: Column(children: [
//           Text(
//             'Do you have completed your payment.',
//             style: TextStyle(fontStyle: FontStyle.italic),
//           ),
//           TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => BottomNavigation()),
//                 );
//               },
//               child: Text('Close Payment'))
//         ]),
//       ),
//       keyboardAware: true,
//       btnOkText: "Yes",
//       btnCancelText: 'Cancel',
//       title: '',
//       padding: const EdgeInsets.all(5.0),
//       onDismissCallback: (type) {
//         Navigator.of(context).pop();
//       },
//       btnCancelOnPress: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BottomNavigation()),
//         );
//         showMessage(context, 'You missed the big earning opportunity');
//       },
//       btnOkOnPress: () async {
//         var curl = await controller.currentUrl();
//         String baseUrl = curl.toString().split('#')[1];
//         if (baseUrl == 'true') {
//           showMessage(context, 'Payment Success');
//         } else {
//           showMessage(context, 'Payment Failed ');
//         }
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => BottomNavigation()),
//         );


//         Timer(Duration(seconds: 10), () {
//           SystemNavigator.pop();
//         });
//         setState(() {});
//       },
//     )..show();
//   }

//   late WebViewController controller;
//   @override
//   Widget build(BuildContext context) {
//     DateTime now = DateTime.now();

//     String formattedDate = "${now.year + 1}${now.month + 1}${now.day}";
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(
//                 Icons.cancel_sharp,
//                 color: Colors.blue,
//               ),
//               onPressed: () {
//                 CheckPayment();
//               })
//         ],
//         backgroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           Flexible(
//             child: Container(
//               child: WillPopScope(
//                 onWillPop: () async {
//                   if (await controller.canGoBack()) {
//                     controller.goBack();
//                     var curl = await controller.currentUrl();
//                     String baseUrl = curl.toString().split('#')[1];
//                     if (baseUrl == 'true') {
//                       CheckPayment();
//                       return true;
//                     }
//                     if (baseUrl == 'false') {
//                       CheckPayment();
//                       return true;
//                     } else {
//                       return false;
//                     }
//                   } else {
//                     CheckPayment();
//                     return true;
//                   }
//                 },
//                 child: WebView(
//                   initialUrl:
//                       'https://nextonebox.com/ccavRequestHandler?ChatAiPrem=160.0+${email}-${formattedDate.toString()}',
//                   javascriptMode: JavascriptMode.unrestricted,
//                   onWebViewCreated: (controller) async {
//                     this.controller = controller;
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





//         // 'https://nextonebox.com/ccavRequestHandler?ChatAiPrem=1.0+${email}-${formattedDate.toString()}',