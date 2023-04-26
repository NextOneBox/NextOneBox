import '../otherfiles/widgets.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

var UserMessage = notif?.values.toList().reversed;
var GlobalMessage = globalmessage?.values.toList().reversed;
//get notifications
@override
Future getdatamessage() async {}

class _NotificationScreenState extends State<NotificationScreen> {
  var MessageList = List.from(UserMessage!)..addAll(GlobalMessage!);
  @override
  Widget build(BuildContext context) {
    if (MessageList.isEmpty) {
      return FutureBuilder(
          future: getdatamessage(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  centerTitle: true,
                  elevation: 0,
                  title: Text(
                    'Notification',
                    style: TextStyle(
                        color: PrColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  backgroundColor: Color.fromARGB(255, 247, 247, 250),
                ),
                body: Center(
                    child: Text(
                  'Have a good day!',
                  style: TextStyle(
                      color: Color.fromARGB(255, 116, 110, 110),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )));
          });
    } else {
      return FutureBuilder(
        future: getdatamessage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              title: Text(
                'Notification',
                style: TextStyle(
                    color: PrColor, fontWeight: FontWeight.bold, fontSize: 25),
              ),
              backgroundColor: Color.fromARGB(255, 247, 247, 250),
            ),
            body: ListView.builder(
                itemCount: MessageList.length,
                itemBuilder: (context, index) {
                  String listgetname;
                  String listgetdescription;
                  String listgetdate;
                  if (MessageList[index]['name'] == null) {
                    listgetdescription =
                        'you have successfully shared to ${MessageList[index]['email'].toString().substring(0, 6)}';
                    listgetname = '';
                    listgetdate = '';
                  } else {
                    listgetname = MessageList[index]['name'].toString();
                    listgetdescription =
                        MessageList[index]['description'].toString();
                    listgetdate =
                        MessageList[index]['date'].substring(0, 10).toString();
                  }
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        decoration: UseBorder,
                        child: GFListTile(
                            shadow: BoxShadow(offset: Offset.infinite),
                          titleText: listgetname,
                          subTitle: Text(listgetdescription),
                          description: Text(listgetdate),
                        ),
                      ),
                    ],
                  );
                }),
          );
        },
      );
    }
  }
}
