import 'package:game/web.dart';
import 'widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

dynamic sizeboxsize = 20.0;
dynamic boxsize = 100.0;
dynamic texstyle = TextStyle(fontSize: 15, color: Colors.black87);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Games platform',
          style: TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200.0,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://poki.com/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/poki.png',
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebPage(data: 'https://yandex.com/games/')),
                          );
                        },
                        child: Container(
                          width: boxsize,
                          height: boxsize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/yandax.png',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
