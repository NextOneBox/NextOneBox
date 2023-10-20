import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youget/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'HomePage.dart';


class contactus extends StatefulWidget {
  const contactus({Key? key}) : super(key: key);

  @override
  State<contactus> createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  var isLoading = false;
  var namecontroller = TextEditingController();
  var emailcontroller = TextEditingController();

  var messagelcontroller = TextEditingController();

  final __formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: c6,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: c3,
          ),
          title: Text('Contact Us',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, color: c3)),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your message ';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      controller: messagelcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.message,
                          color: c1,
                        ),
                        labelText: "Message",
                        // hintText:"Message" ,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey)),
                      ),
                    ),
                    SizedBox(height: 10),
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
                      onPressed: () {
                        if (__formkey.currentState!.validate()) {
                          var subject = emailcontroller.text.toString();
                          var message = messagelcontroller.text.toString();
                          if (messagelcontroller.text.length > 50) {
                            var data =
                                "          \n\n\nEmail: ${account!.get(0)['email']}\nName: ${account!.get(0)['name']}\nApp:Milecash";
                            launch(
                                'mailto:zigzagwaytohome@gmail.com?subject=$subject&body=$message$data');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Pleace define clearly atleast in 35 words',
                                  style: textstyle,
                                )));
                          }
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: c1,
                              backgroundColor: Colors.white,
                            )
                          : Text(
                              'Send Message',
                              style: TextStyle(
                                  fontSize: 20,
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
