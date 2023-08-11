import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'HomePage.dart';
import 'Widget.dart';
import 'question_model.dart';

import 'Colors.dart';
import 'package:http/http.dart' as http;

Box? adsbox = Hive.box('adsbox');

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var allcoin = account!.get(0)['Ballance'];
  final user = FirebaseFirestore.instance;





  List<Question> questionList = getQuestions();

  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;


  @override
  void initState() {
    UnityAds.init(
        gameId: '5278607',
        );
   // unityadload();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///clicks cheack
  clickscheack() {
    dynamic lastclick = adsbox!.get(6)['lastclick'];
    DateTime presenttime = DateTime.now();
    Duration difference = presenttime.difference(lastclick);
    int clicks = adsbox!.get(5)['clicks'];
    if (clicks == 10) {
      if (difference.inHours > 10) {
        UnityAds.load(
          placementId: 'Rewarded_Android',
          onComplete: ((placementId) {
            UnityAds.showVideoAd(
              placementId: 'Rewarded_Android',
              onSkipped: (placementId) => {},
              onComplete: (placementId) {
                adsbox!.put(5, {'clicks': clicks + 1});
                adsbox!.put(6, {'lastclick': DateTime.now()});
                showDialog(context: context, builder: (_) => _showScoreDialog());
              },
              onFailed: (placementId, error, message) => {
                Fluttertoast.showToast(
                    msg: "Something went wrong try again",
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: c6,
                    textColor: c1,
                    fontSize: 16.0),
              },
            );
          }),
          onFailed: (placementId, error, message) =>
              print('Load Failed $placementId: $error $message'),
        );

        adsbox!.put(5, {'clicks': 0});
        adsbox!.put(6, {'lastclick': DateTime.now()});
      } else {
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: c6,
              content: Text(
                  'You have exceed your Quiz limits. Please try after:${10 - difference.inHours} Hours : ${60 - difference.inMinutes} Minutes',style: textstyle,)));
        }
      }
    } else {
      UnityAds.load(
        placementId: 'Rewarded_Android',
        onComplete: ((placementId) {
          UnityAds.showVideoAd(
            placementId: 'Rewarded_Android',
            // onStart: (placementId) => print('Video Ad $placementId started'),
            // onClick: (placementId) => print('Video Ad $placementId click'),
            onSkipped: (placementId) => {},
            onComplete: (placementId) {
              adsbox!.put(5, {'clicks': clicks + 1});
              adsbox!.put(6, {'lastclick': DateTime.now()});
              showDialog(context: context, builder: (_) => _showScoreDialog());
            },
            onFailed: (placementId, error, message) => {
              Fluttertoast.showToast(
                  msg: "Something went wrong try again",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: c6,
                  textColor: c3,
                  fontSize: 16.0),
            },
          );
        }),
        onFailed: (placementId, error, message) =>
            print('Load Failed $placementId: $error $message'),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      // const Color.fromARGB(255, 5, 50, 80),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "Play Quiz Earn Reward",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 25,
                ),
                _questionWidget(),
                SizedBox(
                  height: 40,
                ),
                _answerList(),
                SizedBox(
                  height: 70,
                ),
                _nextButton(),
                SizedBox(
                  height: 90,
                ),
               
              ]),
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Question ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.orangeAccent : Colors.greenAccent,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
            setState(() {
              selectedAnswer = answer;
            });
          }
        },
      ),
    );
  }
  updateearning() async {
      http.Response response = await http
          .post(Uri.parse('https://realcash.nextonebox.com/UpdateBallance'), body: {
        'email': account!.get(0)['email'].toString(),
        'amount': '5'.toString(),
      });
  }
  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 4) {
      //unityadload();
    }
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? "Watch Ad To Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: c1,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (isLastQuestion) {
            clickscheack();
          } else {
            //next question
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
      ),
    );
  }
  bool isPassed = false;
  _showScoreDialog(){
    if (score >= questionList.length * 0.7) {
      updateearning();

      Fluttertoast.showToast(
          msg: "Reward added To Your Wallet",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: c6,
          textColor: c3,
          fontSize: 16.0);
      //pass if 60 %

      isPassed = true;
    }
    String title = isPassed ? "Passed " : "Failed";

    return AlertDialog(
      title: Text(
        title + " | Score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: c6,
          onPrimary: Colors.white,
        ),
        child: const Text("Restart"),
        onPressed: () {
          //unityadload();
          Navigator.pop(context);
          setState(() {
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }
}
