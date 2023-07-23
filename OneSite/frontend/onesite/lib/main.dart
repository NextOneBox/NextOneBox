
import 'package:onesite/helper.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCFDIAxlFate1T62SCYQQGHONPrvJ1--20',
    appId: '1:644783585713:android:d2b7ca7e650fb791fd6590',
    messagingSenderId: '644783585713',
    projectId: 'nextonebox-d7c0a',
  ));



  runApp(MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: MainColor),
        fontFamily: 'Proxima Nova',
      ),
      debugShowCheckedModeBanner: false,
      home: Navigation()));
}
