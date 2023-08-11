import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';
import 'Widget.dart';
import 'navbar.dart';

class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  var isLoading = false;
  var namecontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var gendercontroller = TextEditingController();
  var refferalcontroller = TextEditingController();
  var agecontroller = TextEditingController();


  final __formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: c6,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: c3,
          ),
          title: Text('Edit profile',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: c3)),
          elevation: 0,
          backgroundColor: c6,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Form(
            key: __formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    TextFormField(
                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter correct name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.user,
                          color: c1,
                        ),
                        labelText: "Name",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: phonecontroller,
                      validator: (value) {
                        String patttern = r'(^[0-9]*$)';
                        RegExp regExp = new RegExp(patttern);
                        if (value?.length == 0) {
                          return "Mobile Number is Required";
                        } else if (value?.length != 10) {
                          return "Mobile number must 10 digits";
                        } else if (!regExp.hasMatch(value!)) {
                          return "Mobile Number must be digits";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: c1,
                        ),
                        labelText: "PhoneNumber",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: gendercontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Gender ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.venusMars,
                          color: c1,
                        ),
                        labelText: "Gender",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: agecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age ';
                        } else if (value.length != 2) {
                          return "Age number must 2 digits";
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.personCane,
                          color: c1,
                        ),
                        labelText: "Age",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: refferalcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.bullhorn,
                          color: c1,
                        ),
                        labelText: "Refferal Code ( Optional )",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    // SizedBox(height: 300),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: MaterialButton(
                      onPressed: () async {
                        if (__formkey.currentState!.validate()) {
                            var email = account!.get(0)['email'];
                          http.Response response = await http.post(
                              Uri.parse(
                                  'https://realcash.nextonebox.com/UpdateAccount'),
                              body: {
                                'name': namecontroller.text.toString(),
                                'email': email.toString(),
                                'gender': gendercontroller.text.toString(),
                                'phone': phonecontroller.text.toString(),
                                'age': agecontroller.text.toString(),
                                'referby': refferalcontroller.text.toString(),
                              });
                  
                          ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                  backgroundColor: c6,
                                  content: Text('${response.body}',style: TextStyle(color: c3),)));
                          if (response.body == 'Setting updated'){
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Bottomapp()),
                                  (Route<dynamic> route) => false,
                            );
                          }
                        }
                      },
                      child: Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                      color: c1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
