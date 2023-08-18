import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(CrashGameApp());
}

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
  List<FlSpot> lineChartSpots = [];
  double crashPoint = 20.0; // Set the crash point for the game
  bool isCrashed = false;
  bool isPlaying = false;
  double userMoney = 500.0; // Initial user money

  void startGame() {
    setState(() {
      lineChartSpots.clear();
      userMoney = 500.0; // Reset user money
      isPlaying = true;
      isCrashed = false;
      _startGrowingLine();
    });
  }

  void _startGrowingLine() {
    const double increment = 0.1;
    double xValue = 0.0;
    double yValue = 0.0;
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (xValue <= 10) {
        setState(() {
          xValue += increment;
          yValue = 0.5 * xValue * xValue;
          lineChartSpots.add(FlSpot(xValue, yValue));
          userMoney += 5.0; // Increment user money
        });

        if (yValue >= crashPoint) {
          setState(() {
            isCrashed = true;
            isPlaying = false;
          });
          timer.cancel();
        }
      } else {
        timer.cancel();
      }
    });
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
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black, width: 2.0),
                  left: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              child: Stack(
                children: [
                  LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 10,
                      minY: 0,
                      maxY: 60,
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: lineChartSpots,
                          isCurved: true,
                          color: Colors.blue,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                  if (lineChartSpots.isNotEmpty && !isCrashed)
                    Positioned(
                      bottom: lineChartSpots.last.y * 5,
                      left: lineChartSpots.last.x * 30,
                      child: Icon(
                        Icons.star,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20),
            if (!isPlaying)
              ElevatedButton(
                onPressed: startGame,
                child: Text('Start Crash Game'),
              ),
            if (isCrashed)
              Text(
                'Game Crashed at ${lineChartSpots.last.x.toStringAsFixed(2)}x!\n'
                'You had \$${userMoney.toStringAsFixed(2)}!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
