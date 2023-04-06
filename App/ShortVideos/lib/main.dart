import 'widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  // Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //   apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
  //   appId: '1:644783585713:android:c8fd50f2556a310afd6590',
  //   messagingSenderId: '644783585713',
  //   projectId: 'nextonebox-d7c0a',
  // ));
  Directory docume = await getApplicationDocumentsDirectory();
  Hive.init(docume.path);
  await Hive.openBox('localballance');
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Colors.black),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage()));
}
