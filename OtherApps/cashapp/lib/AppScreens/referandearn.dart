import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class Referandearn extends StatefulWidget {
  Referandearn({super.key});

  @override
  State<Referandearn> createState() => _ReferandearnState();
}

class _ReferandearnState extends State<Referandearn> {
  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          actions: [
            Row(
              children: [
                Card(
                    color: SecondaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                            child: Text(
                          '   ${user.get(0)['Refercode']}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                        IconButton(
                            onPressed: () {
                              FlutterClipboard.copy(
                                      '${user.get(0)['Refercode']}')
                                  .then((value) =>
                                      {showMessage(context, 'Copied')});
                            },
                            icon: Icon(
                              Icons.copy,
                              color: MainColor,
                            ))
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    child: GFButton(
                      fullWidthButton: true,
                      shape: GFButtonShape.pills,
                      size: GFSize.LARGE,
                      color: MainColor,
                      onPressed: () async {
                        await Share.share(
                            '\n \n Hey, Do you want to earn \n \n 📲💰 10,000 per/month without any investment.\n \n ➡️ Then what are you waiting for Download now WinCash \n ➡️ And use my refer code '
                            '"${user.get(0)['Refercode']}". \n \n  💰💥💥  '
                            '\n ➡️ https://play.google.com/store/apps/details?id=com.nextonebox.cashapp');
                      },
                      text: "Refer Now ",
                    ),
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            labelColor: Color.fromARGB(255, 2, 1, 1),
            labelStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'Invite',
              ),
              Tab(
                text: 'Status',
              ),
            ],
          ),
          title: Text(
            'Invite & Earn',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TabBarView(
              children: [
                Invite(),
                Status(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Status extends StatefulWidget {
  Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

var list = refer?.values.toList().reversed;

class _StatusState extends State<Status> {
  var arrNames = list?.toList();

  @override
  Widget build(BuildContext context) {
    if (arrNames!.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No refer yet! \n if have wait for changes to happen.'),
        ),
      );
    } else {
      return Scaffold(
          body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(15),
            elevation: 1,
            child: GFListTile(
                shadow: BoxShadow(offset: Offset.infinite),
                titleText:
                    'Your friend ${arrNames?[index]['email'].toString().substring(0, 6)}... ',
                subTitleText: 'You have earned 50 Coins ',
                icon: Icon(FontAwesomeIcons.circleCheck)),
          );
        },
        itemCount: arrNames?.length,
      ));
    }
  }
}

class Invite extends StatefulWidget {
  Invite({super.key});

  @override
  State<Invite> createState() => _InviteState();
}

List listitem = [];
List<Contact> contact = [];

class _InviteState extends State<Invite> {

  bool isLoaded = false;
  void getper() async {


      if (await Permission.contacts.isGranted) {
       
        List<Contact> contact = await ContactsService.getContacts();

        for (var i = 0; i < contact.length; i++) {
          dynamic val = contact[i].phones![0].value;
          listitem.add(val);
        }
      } else {
        await Permission.contacts.request();
 
      }
   
  }
  
  // void getper() async {
  //   // if (contacts!.isEmpty) {
  //   // Timer(Duration(seconds: 20), () async {
  //   //   http.Response response = await http.post(
  //   //       Uri.parse(
  //   //           'https://www.nextonebox.com/earnmoney/NotGetUrls/SendContacts'),
  //   //       body: {
  //   //         'contactItems': listitem.toString(),
  //   //         'email': email,
  //   //       });
  //   //   if (response.body == 'don') {
  //   //     contacts!.add(response.body);
  //   //   }
  //   // });

  //   if (await Permission.contacts.isGranted) {
  //     print('my hsel shahid and my phone is 707457234095092143027340');
  //     // Permission granted, proceed to fetch contacts\
  //     List<Contact> contacts =
  //         await ContactsService.getContacts(withThumbnails: false);
  //     setState(() {
  //       contact = contacts;
  //     });

  //     print(
  //         '979273549723495792374592734587239459879723459237495273457239459347592374592734985');

  //     for (var i = 0; i < contact.length; i++) {
  //       dynamic val = contact[i].phones![0].value;
  //       listitem.add(val);
  //     }
  //   } else {
  //     await Permission.contacts.request();
  //     // Permission denied, handle accordingly
  //   }

  //   // }
  // }

  @override
  void initState() {
    super.initState();
    // getper();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            getper();
          },
          child: Container(
            width: 500,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/referpage.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        '50 Coins on Sign up. ',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        'Luckey refer will get iPhone 14',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            color: Colors.white,
            child: ListView.builder(
                itemCount: contact.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      var url =
                          'https://wa.me/919682524922?text=%0A%0AHey%2C%20Do%20you%20want%20to%20earn%0A%0A%F0%9F%93%B2%F0%9F%92%B0%2010%2C000%20per%2Fmonth%20without%20any%20investment.%0A%0A%E2%9E%A1%EF%B8%8F%20Then%20what%20are%20you%20waiting%20for%20Download%20now%20CashApp%0A%E2%9E%A1%EF%B8%8F%20And%20use%20my%20refer%20code%20%0A%20%20%20%20%20%20%20%20%0A%20%20%20%F0%9F%92%B0%F0%9F%92%A5%F0%9F%92%A5%20%0A%20%20%20%20%20%20%20%20%0A%E2%9E%A1%EF%B8%8F%20https%3A%2F%2Fplay.google.com%2Fstore%2Fapps%2Fdetails%3Fid%3Dcom.nextonebox.cashapp';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: Icon(
                                FontAwesomeIcons.whatsapp,
                                size: 50,
                                color: Colors.green,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact[index].displayName![0].toString(),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 16, 16, 16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      contact[index]
                                          .phones![0]
                                          .value
                                          .toString(),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 110, 114, 116),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  ' Earn ₹5',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
