import 'package:mugcash/AppScreens/tasksdetaile.dart';
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Task extends StatefulWidget {
  final val;
  const Task({super.key, this.val});

  @override
  State<Task> createState() => _TaskState();
}

var newb = task?.values.toList();

class _TaskState extends State<Task> {
unityloadad() async {
    UnityAds.load(
        placementId: 'Interstitial_Android',
        onFailed: (placementId, error, message) =>
            showMessage.show(context, 'Failed to load ad.'));



    UnityAds.showVideoAd(
      placementId: 'Interstitial_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {
 
      },
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }
  bool isLoaded = false;

  @override
  initState() {
    super.initState();
   UnityAds.init(
      gameId: '5278155',
    );
    UnityAds.load(
        placementId: 'Interstitial_Android',
        onFailed: (placementId, error, message) =>
            showMessage.show(context, 'Failed to load ad.'));
  
    if (widget.val == '') {
      newb = task?.values.toList();
    } else {
      newb =
          task?.values.where((tet) => tet['catagories'] == widget.val).toList();
    }
  }

  void fintercountries(value) {
    setState(() {
      if (value == '') {
        newb = task?.values.toList();
      } else {
        newb = task?.values.where((tet) => tet['catagories'] == value).toList();
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  BottomNavigation()),
        );
        return false;
      },
      child: Scaffold(
        body: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                    height: 30,
                    width: 500,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('');
                              },
                              text: "All",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('Other');
                              },
                              text: "Trending",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('Demart');
                              },
                              text: "Demart Account",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('Credit');
                              },
                              text: "Credit Card",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('Saving');
                              },
                              text: "Saving Account",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('Coin');
                              },
                              text: "Crypto",
                            ),
                          ),
                          Card(
                            child: GFButton(
                              color: Colors.black,
                              textColor: Colors.white,
                              onPressed: () {
                                fintercountries('Loan');
                              },
                              text: "Loan",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                
                  Flexible(
                    child: Container(
                      color: SecondaryColor,
                      child: ListView.builder(
                          itemCount: newb?.length,
                          itemBuilder: (context, index) {
                            var image = newb?[index]['image'];
                            return InkWell(
                              onTap: () {
                                var taskName = newb?[index];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TasksDetails(task_name: taskName)),
                                );
                                unityloadad();
                              },
                              child: Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://nextonebox.com/media/$image'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 150,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newb?[index]['name'],
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 16, 16, 16),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                newb?[index]['description'],
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 110, 114, 116),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 50),
                                        width: 100,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: MainColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Center(
                                            child: Text(
                                          ' Earn ₹ ${newb?[index]['price']} ',
                                          style: const TextStyle(color: Colors.white),
                                        )),
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
              ),
            );
          }, future: null,
        ),
      ),
    );
  }
}
