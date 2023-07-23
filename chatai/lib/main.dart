import 'package:chatai/OtherFiles/widgets.dart';

void main() async {
  getkey();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:834c913d3e1bcc46fd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));

  Directory docume = await getApplicationDocumentsDirectory();
  Hive.init(docume.path);

  await Hive.openBox('account');
  await Hive.openBox('history');
  await Hive.openBox('adtime');
  await Hive.openBox('contacts');
  await Hive.openBox('MyAnalytic');
  await Hive.openBox('apikey');



  runApp(MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: MainColor),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: BottomNavigation()));
}


