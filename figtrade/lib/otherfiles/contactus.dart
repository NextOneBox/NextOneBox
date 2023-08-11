import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:figtrade/widget.dart';

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
        backgroundColor: Colors.black,
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
                      style: TextStyle(color: Colors.white),
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
                          color: Colors.white,
                        ),
                        labelText: "Email",
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
                      style: TextStyle(color: Colors.white),
                      controller: emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your subject ';
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.subject,
                          color: Colors.white,
                        ),
                        labelText: "subject",
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
                      style: TextStyle(color: Colors.white),
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
                          color: Colors.white,
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
                          launch(
                              'mailto:nextoneboxcheck@gmail.com?subject=$subject&body=$message');
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: c3,
                              backgroundColor: Colors.white,
                            )
                          : Text(
                              'Send Message',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                      color: buttoncolor,
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
