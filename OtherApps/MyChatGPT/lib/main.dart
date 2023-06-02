import 'package:MyChatAi/OtherFiles/premium.dart';
import 'package:MyChatAi/OtherFiles/widgets.dart';
import 'package:MyChatAi/App/home.dart';


Future<void> backgroundHandler(RemoteMessage message) async {

}

void main() async {
  getkey();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:d2b7ca7e650fb791fd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Complete tasks',
        channelDescription: "Complete tasks and get paid",
        defaultColor: Color(0XFF9050DD),
        ledColor: Colors.white,
        playSound: false,
        enableLights: true,
        enableVibration: true)
  ]);
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'key1',
          title: 'Have a question ?',
          locked: true,
          displayOnForeground: true,
          displayOnBackground: true,
          autoDismissible: true,
          body: 'Let ChatGPT answer you  '));
  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  Directory docume = await getApplicationDocumentsDirectory();
  Hive.init(docume.path);

  await Hive.openBox('account');
  await Hive.openBox('history');
  await Hive.openBox('adtime');
  await Hive.openBox('contacts');
  await Hive.openBox('MyAnalytic');
  await Hive.openBox('apikey');
// what is gpt

  runApp(MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: MainColor),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: Open()));
}

class Open extends StatefulWidget {
  const Open({super.key});

  @override
  State<Open> createState() => _OpenState();
}

class _OpenState extends State<Open> {
  prevusad() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Use the power of Ai ad free with MyChatAi Pro account',
            ),
          ),
        ),
        keyboardAware: true,
        btnOkText: "Try now",
        padding: const EdgeInsets.all(5.0),
        btnCancelOnPress: () {
          Navigator.of(context);
        },
        btnOkOnPress: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Premium()),
          );
        }).show();
  }

  @override
  void initState() {
    super.initState();
    if (account.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => prevusad());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigation();
  }
}
