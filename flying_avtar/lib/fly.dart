import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CrashGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crash Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CrashGameScreen(),
    );
  }
}

class CrashGameScreen extends StatefulWidget {
  @override
  _CrashGameScreenState createState() => _CrashGameScreenState();
}

class _CrashGameScreenState extends State<CrashGameScreen> {
  double currentMultiplier = 1.0;
  double currentCrashPoint = 1.0;
  bool isCrashed = false;
  bool isPlaying = false;

  void startGame() {
    setState(() {
      currentMultiplier = 1.0;
      currentCrashPoint = _generateRandomCrashPoint();
      isCrashed = false;
      isPlaying = true;
      _startCountdown();
    });
  }

  void _startCountdown() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (isCrashed) {
        timer.cancel();
      } else {
        setState(() {
          currentMultiplier += 0.01;
        });
      }
    });
  }

  void cashOut() {
    setState(() {
      isCrashed = true;
      isPlaying = false;
    });
  }

  double _generateRandomCrashPoint() {
    final random = Random();
    return 1.0 +
        random.nextDouble() *
            4.0; // Generate a random crash point between 1.0 and 5.0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crash Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Multiplier: ${currentMultiplier.toStringAsFixed(2)}x',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (isPlaying)
              ElevatedButton(
                onPressed: cashOut,
                child: Text('Cash Out'),
              )
            else
              ElevatedButton(
                onPressed: startGame,
                child: Text('Start Game'),
              ),
            SizedBox(height: 20),
            if (isCrashed)
              Text(
                'Crash point: ${currentCrashPoint.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
