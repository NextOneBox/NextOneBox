import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TasksDetails extends StatefulWidget {
  const TasksDetails({super.key, required this.task_name});
  final task_name;
  @override
  State<TasksDetails> createState() => _TasksDetailsState();
}

// Box? user = Hive.box('user');
// Box? task = Hive.box('tasks');
String code = user?.get(0)['Refercode'];

class _TasksDetailsState extends State<TasksDetails> {
  var shortLink = 'No Data Yet';




  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 10,),
          GFButton(
            onPressed: () async {
              http.Response response = await http.post(
                  Uri.parse(
                      'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTaskSharePage'),
                  body: {
                    'full_name': user?.get(0)['name'].toString(),
                    'mobile_no': user?.get(0)['phonenumber'].toString(),
                    'email': user?.get(0)['email'].toString(),
                    'image': widget.task_name['image'].toString(),
                    'product': widget.task_name['name'].toString(),
                    'refercode': user?.get(0)['Refercode'].toString(),
                    'city': 'non'
                  });

              String url = widget.task_name['referlink'];
              var urllaunchable =
                  await canLaunch(url); //canLaunch is from url_launcher package
              if (urllaunchable) {
                await launch(
                    url); //launch is from url_launcher package to launch URL
              } else {
                print("URL can't be launched.");
              }

            }, 
            text: '        Redeem now          ',
            color: Colors.black,
            size: 50,
            shape: GFButtonShape.pills,
          ),
          GFButton(
            onPressed: () async {
              await Share.share(
                  '  ${widget.task_name['name'].toString().toUpperCase()} '
                  '\n \n'
                  '${widget.task_name['benifits'].toString().replaceAll(',', '\n \n')} '
                  ' \n \n✅Complete your account opening process with in 30 days to earn lucky win .📲💰 \n \n'
                  '✅For any help contact our verified earnmoney adviser '
                  ' \n✅Name :'
                  ' ${user?.get(0)['name'].toString().toUpperCase()} '
                  '\n'
                  '✅Email id :  ${user?.get(0)['email']}  '
                  '\n \n ➡️ Use Promo code/refer code $code. or  \n '
                  '✅ Use this link to Open account \n \n'
                  '➡️https://www.nextonebox.com/earnmoney/t?id=${widget.task_name['name']}+$code');
            },
            text: "         Share&Earn          ",
                color: Colors.black,
            size: 50,
            shape: GFButtonShape.pills,
          ),
        ],
      ),
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: SecondaryColor,
          elevation: 0,
          title: const Text(
            'Task details',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image(
                                image: NetworkImage(
                                    'https://nextonebox.com/media/${widget.task_name['image']}'),
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Text(
                                '${widget.task_name['name']}',
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GFListTile(
                          shadow: const BoxShadow(offset: Offset.infinite),
                          avatar: GFAvatar(
                            backgroundColor: MainColor,
                            child: Icon(
                              FontAwesomeIcons.indianRupeeSign,
                              color: Colors.yellow[900],
                            ),
                          ),
                          titleText: '₹${widget.task_name['price']} ',
                          subTitleText: '${widget.task_name['description']}',
                        ),
                        const Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Tracking : 7days'),
                              Text('Confirm  : 60days'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 250,
                  height: 80,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 80,
                      child: Center(
                          child: Text(
                        'Steps to Earn',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: 500,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GFListTile(
                          shadow: const BoxShadow(offset: Offset.infinite),
                          titleText: '\n \n How to Earn \n',
                          subTitleText:
                              widget.task_name['howtoearn'].toString().replaceAll(',', '\n \n'),
                        ),
                        GFListTile(
                          shadow: const BoxShadow(offset: Offset.infinite),
                          titleText: '\n Benefits \n',
                          subTitleText:
                              widget.task_name['benifits'].toString().replaceAll(',', '\n \n'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
