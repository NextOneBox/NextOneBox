// import 'package:http/http.dart' as http;
// import '../otherfiles/widgets.dart';

// class SettingOtp extends StatefulWidget {
//   SettingOtp({super.key, required this.data});

//   final data;

//   @override
//   State<SettingOtp> createState() => _SettingOtpState();
// }

// var maincolor = Color.fromARGB(255, 0, 0, 0);

// class _SettingOtpState extends State<SettingOtp> {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
//     try {
//       final authCred = await _auth.signInWithCredential(phoneAuthCredential);

//       if (authCred.user != null) {
//         http.Response response = await http.post(
//             Uri.parse(
//                 'https://www.nextonebox.com/earnmoney/NotGetUrls/AppAccountUpdate'),
//             body: {
//               'name': widget.data['name'].toString(),
//               'gender': widget.data['gender'].toString().split('.').last,
//               'email': email.toString(),
//               'phone': widget.data['phone'].toString(),
//               'account': widget.data['account'].toString(),
//               'age': widget.data['age'].toString(),
//               'referby': widget.data['referby'].toString(),
//             });

//         if (response.body == 'Setting updated with refer code') {
//           {
//             showMessage(context, 'You have earn 25 ₹ rupees');
//           }

//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BottomNavigation()),
//           );
//         } else {
//           {
//             showMessage(context, response.body);
//           }

//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BottomNavigation()),
//           );
//         }
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {});
//       print(e.message);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content:
//               Text('Some Error Occured. Check you Otp or Try Again Later')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController otpCont = TextEditingController();
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 150,
//             ),
//             Container(
//               margin: EdgeInsets.only(bottom: 40, left: 30),
//               child: Center(
//                 child: Row(
//                   children: [
//                     Text(
//                       '        Enter the otp send to \n           ' +
//                           widget.data['phone'],
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//                     ),
//                     IconButton(
//                         onPressed: () => Navigator.of(context).pop(),
//                         icon: Icon(
//                           Icons.edit_note_outlined,
//                           color: Colors.blue,
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               child: Container(
//                 width: 300,
//                 padding: EdgeInsets.only(left: 20),
//                 child: TextField(
//                   controller: otpCont,
//                   decoration: InputDecoration(
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                         color: maincolor,
//                       )),
//                       border: OutlineInputBorder(),
//                       floatingLabelStyle: TextStyle(color: maincolor),
//                       labelText: 'Otp',
//                       prefixIcon: Padding(
//                         padding: EdgeInsets.all(8),
//                         child: Icon(
//                           Icons.insert_comment_sharp,
//                           color: maincolor,
//                         ),
//                       )),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             Container(
//               width: 200,
//               child: GFButton(
//                 onPressed: () async {
//                   AuthCredential phoneAuthCredential =
//                       PhoneAuthProvider.credential(
//                           verificationId: widget.data['verificationID'],
//                           smsCode: otpCont.text);
//                   signInWithPhoneAuthCred(phoneAuthCredential);
//                 },
//                 fullWidthButton: true,
//                 color: maincolor,
//                 shape: GFButtonShape.pills,
//                 size: GFSize.LARGE,
//                 text: 'n e x t',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
