import 'package:chatai/OtherFiles/pay.dart';
import 'package:chatai/OtherFiles/payyea.dart';
import 'package:chatai/OtherFiles/widgets.dart';

import '../OtherFiles/widgets.dart' as widgets;
import 'package:http/http.dart' as http;

class Premium extends StatefulWidget {
  const Premium({super.key});

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
// how to give background image in flutter scaffold
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '      MyChatAi  ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: 70,
                        height: 50,
                        child: Card(
                            color: Colors.amber,
                            child: Center(
                                child: Text(
                              'Pro',
                              style: texSty,
                            )))),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: const [
                  Icon(
                    Icons.star_purple500_outlined,
                    color: Colors.amber,
                  ),
                  Text(
                    '    Use Ad free save time.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.star_purple500_outlined,
                    color: Colors.amber,
                  ),
                  Text(
                    '    Become Ai Expert.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.star_purple500_outlined,
                    color: Colors.amber,
                  ),
                  Text(
                    '   Generate Ai Image\n   Give a power to your Imagenation',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.star_purple500_outlined,
                    color: Colors.amber,
                  ),
                  Text(
                    '     Artificial Intelligence Personalize answers',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.star_purple500_outlined,
                    color: Colors.amber,
                  ),
                  Text(
                    '    Live Ahead from EverOne',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                );
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Center(
                                child: Text(
                              ' Free ',
                              style: TextStyle(color: MainColor, fontSize: 20),
                            )),
                            Center(
                                child: Text(
                              '  Continue with Ads ',
                              style: TextStyle(color: MainColor, fontSize: 15),
                            )),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pay()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Center(
                                  child: Text(
                                'Monthly',
                                style:
                                    TextStyle(color: MainColor, fontSize: 20),
                              )),
                              Center(
                                  child: Text(
                                '30% off ₹35 only',
                                style:
                                    TextStyle(color: MainColor, fontSize: 15),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  //how to cut text in flutter
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: const [
                            Color.fromARGB(255, 124, 240, 29),
                            Color.fromARGB(255, 50, 78, 190),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 80,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PayYear()),
                        );
                      },
                      child: Center(
                          child: Text(
                        " Yearly          50% off ₹145 only",
                        style: TextStyle(color: Colors.black, fontSize: 25),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// how to write dollar sign in string in flutter
