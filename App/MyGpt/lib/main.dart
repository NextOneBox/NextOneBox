import 'package:MyChatAi/OtherFiles/widgets.dart';
import 'package:MyChatAi/App/home.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:9638b2078748798efd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));
  MobileAds.instance.initialize();
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
  Directory docume = await getApplicationDocumentsDirectory();
  Hive.init(docume.path);

  await Hive.openBox('account');
  await Hive.openBox('history');
  await Hive.openBox('adtime');
  await Hive.openBox('contacts');
  await Hive.openBox('MyAnalytic');
  await Hive.openBox('apikey');
// what is gpt
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
          autoDismissible: false,
          body: 'Let Ai answer you  '));
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: MainColor),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavigation()));
}
