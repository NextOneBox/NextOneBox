import 'otherfiles/widgets.dart';
// import 'package:cron/cron.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:earnmoney/screens/task.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:9d932b74e857195ffd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'key1',
        channelName: 'Complete tasks',
        channelDescription: "Complete tasks and get paid",
        defaultColor: Color(0XFF9050DD),
        ledColor: Colors.white,
        playSound: true,
        enableLights: true,
        enableVibration: true)
  ]);

  Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  Directory docume = await getApplicationDocumentsDirectory();

  Hive.init(docume.path);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));

  await Hive.openBox('user');
  await Hive.openBox('pkacc');
  await Hive.openBox('notif');
  await Hive.openBox('leads');
  await Hive.openBox('tasks');
  await Hive.openBox('refer');
  await Hive.openBox('leadsteps');
  await Hive.openBox('widrawstaus');
  await Hive.openBox('globalmessage');
  await Hive.openBox('LeaderBoard');
  await Hive.openBox('MyAnalytic');
  await Hive.openBox('profitlink');
  await Hive.openBox('adsbox');
  await Hive.openBox('localballance');
  await Hive.openBox('quiz');
  await Hive.openBox('contacts');

  LocalNotificationService.initialize();
  SendAllData();

  runApp(MaterialApp(
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        MonthYearPickerLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: BackColor,
        secondaryHeaderColor: BackColor,
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
  refer() {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body: Center(
        child: Text(
          'Refer and Earn 100 \n\n\n Get instant 100 Coins on there Sign up \n\n Lucky chance to win Iphone 12.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      keyboardAware: true,
      btnOkText: "Refer",
      title: 'Refer and Earn 100 Coins',
      padding: const EdgeInsets.all(5.0),
      btnCancelOnPress: () {
       Navigator.pop(context);
      },
      btnOkOnPress: () async {
        await Share.share(
            '\n \n Hey, Do you want to earn \n \n 📲💰 10,000 per/month without any investment.\n \n ➡️ Then what are you waiting for Download now EarnMoney \n ➡️ And use my refer code '
            '"${user.get(0)['Refercode']}". \n \n  💰💥💥  '
            '\n ➡️ https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney');
      },
    )..show();
  }

  prevusad() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: Center(
          child: Text(
            'Current \n *10 Watch ads per day \n *10 Spin&Win per day \n *10 days Task tracking \n * Withdraw within 3days    \n\n Pro just in 99₹\n *  30 Watch ads per day \n  *  30 Spin&Win per day \n  *  24hours Task tracking \n  *  Withdraw within 1 hours',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        keyboardAware: true,
        btnOkText: "Pay",
        title: 'Continue to pay ₹99 rupees',
        padding: const EdgeInsets.all(5.0),
        btnCancelOnPress: () {
          Timer(Duration(seconds: 7), () {
            setState(() {
              WidgetsBinding.instance.addPostFrameCallback((_) => refer());
            });
          });
          showMessage(context, 'You missed the big earning opportunity');
        },
        btnOkOnPress: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Pay()),
          );
        }).show();
  }

  @override
  void initState() {
    super.initState();
    if (user.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => prevusad());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigation();
  }
}
