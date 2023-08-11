import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:figtrade/widget.dart';

List<FlSpot>? Datachart;
List<HorizontalLine> horizontalLines = [];
void addHorizontalLinesput() {
  List<int> numbers = [70, 110, 100, 90, 80];
  Random random = new Random();
  int randomIndex = random.nextInt(numbers.length);
  int randomNumber = numbers[randomIndex];
  horizontalLines.add(
    HorizontalLine(
      y: RealDemo?.get('y'),
      color: Colors.red,
      strokeWidth: 2,
      dashArray: [4],
      label: HorizontalLineLabel(
          labelResolver: (p0) {
            return '↓';
          },
          show: true,
          padding: EdgeInsets.only(right: randomNumber.toDouble()),
          alignment: Alignment.bottomRight,
          style: TextStyle(
              fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold)),
    ),
  );
  Future.delayed(Duration(seconds: 60), () {
    horizontalLines.removeAt(0);
  });
}

void addHorizontalLinescall() {
  List<int> numbers = [90, 50, 70, 60, 80];
  Random random = new Random();
  int randomIndex = random.nextInt(numbers.length);
  int randomNumber = numbers[randomIndex];
  horizontalLines.add(
    HorizontalLine(
      y: RealDemo?.get('y'),
      color: Colors.green,
      strokeWidth: 2,
      dashArray: [3],
      label: HorizontalLineLabel(
        labelResolver: (p0) {
          return '↑';
        },
        show: true,
        padding: EdgeInsets.only(right: randomNumber.toDouble()),
        alignment: Alignment.topRight,
        style: TextStyle(
            fontSize: 25, color: Colors.green, fontWeight: FontWeight.bold),
      ),
    ),
  );
  Future.delayed(Duration(seconds: 60), () {
    horizontalLines.removeAt(0);
  });
}

class fl_charts extends StatefulWidget {
  const fl_charts({super.key});

  @override
  State<fl_charts> createState() => _fl_chartsState();
}

class _fl_chartsState extends State<fl_charts> {
  bool assetslected = assets?.get('assetslected');
  bool _isLoading = false;
  Timer? _timer;
  Future<List<FlSpot>> _fetchChartData() async {
    final response = await http.get(Uri.parse(
      assetslected
          ? account?.get(0)['link']
          :
      "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1s",
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final chartData = data
          .map((item) => FlSpot(
                (item[0] as int).toDouble(),
                double.parse(item[1]),
              ))
          .toList();
      setState(() {
        Datachart = chartData;
      });

      return chartData;
    } else {
      throw Exception('Failed to fetch chart data');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _fetchChartData();
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _fetchChartData().then((_) {
      setState(() {
        _isLoading = false;
      });
      _startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(seconds: 3), (timer) async {
      if (Datachart!.isNotEmpty) {
        RealDemo?.put('y', Datachart?.last.y);
      }
    });

    return _isLoading
        ? Container(
            width: 500,
            height: 500,
            child: Center(child: CircularProgressIndicator()))
        : Container(
            // width: 2000,
            child: LineChart(
              swapAnimationDuration: Duration.zero,
              LineChartData(
                minX: Datachart!.first.x , //left
                maxX: Datachart!.last.x + 40000, //right
                // maxX: Datachart!.last.x + 40000, //right
                minY: Datachart!.map((spot) => spot.y).reduce(min), //bottom
                maxY: Datachart!.map((spot) => spot.y).reduce(max), //top
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    VerticalLine(
                      x: Datachart!.last.x,
                      color: Colors.white,
                      strokeWidth: 1,
                      dashArray: [1],
                    )
                  ],
                  horizontalLines: horizontalLines,
                ),
                lineTouchData: LineTouchData(
                  getTouchLineStart: (Datachart, spotIndex) {
                    return Datachart.spots[spotIndex].y;
                  },
                  handleBuiltInTouches: true,
                  enabled: false,
                  // touchSpotThreshold: Datachart?.last.y,
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y}',
                          TextStyle(color: c6, fontWeight: FontWeight.bold),
                        );
                      }).toList();
                    },
                    fitInsideHorizontally: true,
                    showOnTopOfTheChartBoxArea: true,
                    tooltipHorizontalAlignment: FLHorizontalAlignment.right,
                    fitInsideVertically: true,
                    tooltipHorizontalOffset: 500,
                    tooltipBgColor: c3,
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isStrokeCapRound: true,
                    spots: Datachart!, //+ [FlSpot(Datachart!.last.y, 0)],
                    isCurved: true,
                    color: blue,
                    barWidth: 1.30,
                    dotData: FlDotData(
                      show: true,
                      checkToShowDot: (spot, _) =>
                          spot.x == Datachart!.map((e) => e.x).reduce(max),
                      getDotPainter: (p0, p1, p2, p3) {
                        return FlDotCirclePainter(
                          strokeColor: Colors.white,
                          color: Colors.red,
                          radius: 2,
                          strokeWidth: 2,
                        );
                      },
                    ),
                    isStrokeJoinRound: false,
                    show: true,
                    belowBarData: BarAreaData(
                      ///....this is showing a vertical line with dot
                      spotsLine: BarAreaSpotsLine(
                        show: false,
                        flLineStyle: FlLine(
                          color: Colors.red,
                          strokeWidth: 2,
                          dashArray: [5],
                        ),
                        checkToShowSpotLine: (spot) =>
                            spot.x == Datachart!.map((e) => e.x).reduce(max),
                      ),
                      show: true,
                      // color: Color(0xff15616d),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 12, 44, 77),
                          // Color(0xff15616d),
                          Color.fromARGB(255, 10, 51, 59),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true,
                  // horizontalInterval: 100,
                  // verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      dashArray: [2],
                      color: const Color(0xff37434d),
                      strokeWidth: 0.50,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      dashArray: [2],
                      color: const Color(0xff37434d),
                      strokeWidth: 0.50,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                      interval: 5,
                      reservedSize: 20,
                      showTitles: false,
                    )),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                      showTitles: false,
                    )),
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                      getTitlesWidget: (value, meta) {
                        return Text(
                          meta.formattedValue.toString(),
                          style: textstyle,
                        );
                      },
                      reservedSize: 40,
                      // interval: 50,
                      interval: (Datachart!.map((spot) => spot.y).reduce(max) -
                              Datachart!.map((spot) => spot.y).reduce(min)) /
                          5,
                      showTitles: true,
                    ))),

                backgroundColor: c6,
                borderData: FlBorderData(
                  show: true,
                  border: Border.symmetric(
                      vertical: BorderSide(
                    color: c6,
                  )),
                ),
              ),
            ),
          );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fl_chart/fl_chart.dart';
// import 'package:figtrade/widget.dart';



  
  


// List<FlSpot>? Datachart;
// List<HorizontalLine> horizontalLines = [];
// void addHorizontalLinesput() {
//   List<int> numbers = [70, 110, 100, 90, 80];
//   Random random = new Random();
//   int randomIndex = random.nextInt(numbers.length);
//   int randomNumber = numbers[randomIndex];
//   horizontalLines.add(
//     HorizontalLine(
//       y: RealDemo?.get('y'),
//       color: Colors.red,
//       strokeWidth: 2,
//       dashArray: [4],
//       label: HorizontalLineLabel(
//           labelResolver: (p0) {
//             return '↓';
//           },
//           show: true,
//           padding: EdgeInsets.only(right: randomNumber.toDouble()),
//           alignment: Alignment.bottomRight,
//           style: TextStyle(fontSize: 25,color: Colors.red,fontWeight: FontWeight.bold)),
//     ),
//   );
//   Future.delayed(Duration(seconds: 60), () {
//     horizontalLines.removeAt(0);
//   });
// }

// void addHorizontalLinescall() {
//   List<int> numbers = [90, 50, 70, 60, 80];
//   Random random = new Random();
//   int randomIndex = random.nextInt(numbers.length);
//   int randomNumber = numbers[randomIndex];
//   horizontalLines.add(
//     HorizontalLine(
//       y: RealDemo?.get('y'),
//       color: Colors.green,
//       strokeWidth: 2,
//       dashArray: [3],
//       label: HorizontalLineLabel(
//           labelResolver: (p0) {
//             return '↑';
//           },
//           show: true,
//           padding: EdgeInsets.only(right: randomNumber.toDouble()),
//           alignment: Alignment.topRight,
//          style: TextStyle(fontSize: 25,color: Colors.green,fontWeight: FontWeight.bold),),
//     ),
//   );
//   Future.delayed(Duration(seconds: 60), () {
//     horizontalLines.removeAt(0);
//   });
// }

// class fl_charts extends StatefulWidget {
//   const fl_charts({super.key});

//   @override
//   State<fl_charts> createState() => _fl_chartsState();
// }

// class _fl_chartsState extends State<fl_charts> {
//   bool assetslected = assets?.get('assetslected');
//   bool _isLoading = false;
//   Timer? _timer;
//   Future<List<FlSpot>> _fetchChartData() async {
//     final response = await http.get(Uri.parse(
//       assetslected
//           ? account?.get(0)['link']
//           : "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1s",
//     ));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List<dynamic>;
//       final chartData = data
//           .map((item) => FlSpot(
//                 (item[0] as int).toDouble(),
//                 double.parse(item[1]),
//               ))
//           .toList();
//       setState(() {
//         Datachart = chartData;
//       });

//       return chartData;
//     } else {
//       throw Exception('Failed to fetch chart data');
//     }
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       _fetchChartData();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _isLoading = true;
//     _fetchChartData().then((_) {
//       setState(() {
//         _isLoading = false;
//       });
//       _startTimer();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Timer.periodic(Duration(seconds: 3), (timer) async {
//       if (Datachart!.isNotEmpty) {
//         RealDemo?.put('y', Datachart?.last.y);
//       }
//     });

//     return _isLoading
//         ? Container(
//             width: 500,
//             height: 500,
//             child: Center(child: CircularProgressIndicator()))
//         : Container(
//             // width: 2000,
//             child: LineChart(
//               swapAnimationDuration: Duration.zero,
//               LineChartData(
//                 minX: Datachart!.first.x, //left
//                 maxX: Datachart!.last.x + 40000, //right
//                 minY: Datachart!.map((spot) => spot.y).reduce(min), //bottom
//                 maxY: Datachart!.map((spot) => spot.y).reduce(max), //top
//                 extraLinesData: ExtraLinesData(
//                   verticalLines: [
//                     VerticalLine(
//                       x: Datachart!.last.x,
//                       color: Colors.white,
//                       strokeWidth: 1,
//                       dashArray: [1],
//                     )
//                   ],
//                   horizontalLines: horizontalLines,
//                 ),
//                 lineTouchData: LineTouchData(
//                   getTouchLineStart: (Datachart, spotIndex) {
//                     return Datachart.spots[spotIndex].y;
//                   },
//                   handleBuiltInTouches: true,
//                   enabled: false,
//                   // touchSpotThreshold: Datachart?.last.y,
//                   touchTooltipData: LineTouchTooltipData(
//                     getTooltipItems: (touchedSpots) {
//                       return touchedSpots.map((spot) {
//                         return LineTooltipItem(
//                           '${spot.y}',
//                           TextStyle(color: c6, fontWeight: FontWeight.bold),
//                         );
//                       }).toList();
//                     },
//                     fitInsideHorizontally: true,
//                     showOnTopOfTheChartBoxArea: true,
//                     tooltipHorizontalAlignment: FLHorizontalAlignment.right,
//                     fitInsideVertically: true,
//                     tooltipHorizontalOffset: 500,
//                     tooltipBgColor: c3,
//                   ),
//                 ),
//                 lineBarsData: [
//                   LineChartBarData(
//                     isStrokeCapRound: true,
//                     spots: Datachart!, //+ [FlSpot(Datachart!.last.y, 0)],
//                     isCurved: true,
//                     color: blue,
//                     barWidth: 1.30,
//                     dotData: FlDotData(
//                       show: true,
//                       checkToShowDot: (spot, _) =>
//                           spot.x == Datachart!.map((e) => e.x).reduce(max),
//                       getDotPainter: (p0, p1, p2, p3) {
//                         return FlDotCirclePainter(
//                           strokeColor: Colors.white,
//                           color: Colors.red,
//                           radius: 2,
//                           strokeWidth: 2,
//                         );
//                       },
//                     ),
//                     isStrokeJoinRound: false,
//                     show: true,
//                     belowBarData: BarAreaData(
//                       ///....this is showing a vertical line with dot
//                       spotsLine: BarAreaSpotsLine(
//                         show: false,
//                         flLineStyle: FlLine(
//                           color: Colors.red,
//                           strokeWidth: 2,
//                           dashArray: [5],
//                         ),
//                         checkToShowSpotLine: (spot) =>
//                             spot.x == Datachart!.map((e) => e.x).reduce(max),
//                       ),
//                       show: true,
//                       // color: Color(0xff15616d),
//                       gradient: LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 12, 44, 77),
//                           // Color(0xff15616d),
//                           Color.fromARGB(255, 10, 51, 59),
//                           Colors.transparent
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                   ),
//                 ],
//                 gridData: FlGridData(
//                   show: true,
//                   drawVerticalLine: true,
//                   drawHorizontalLine: true,
//                   // horizontalInterval: 100,
//                   // verticalInterval: 1,
//                   getDrawingHorizontalLine: (value) {
//                     return FlLine(
//                       dashArray: [2],
//                       color: const Color(0xff37434d),
//                       strokeWidth: 0.50,
//                     );
//                   },
//                   getDrawingVerticalLine: (value) {
//                     return FlLine(
//                       dashArray: [2],
//                       color: const Color(0xff37434d),
//                       strokeWidth: 0.50,
//                     );
//                   },
//                 ),
//                 titlesData: FlTitlesData(
//                     show: true,
//                     bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                       interval: 5,
//                       reservedSize: 20,
//                       showTitles: false,
//                     )),
//                     topTitles:
//                         AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     leftTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                       showTitles: false,
//                     )),
//                     rightTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                       getTitlesWidget: (value, meta) {
//                         return Text(
//                           meta.formattedValue.toString(),
//                           style: textstyle,
//                         );
//                       },
//                       reservedSize: 40,
//                       // interval: 50,
//                       interval: (Datachart!.map((spot) => spot.y).reduce(max) -
//                               Datachart!.map((spot) => spot.y).reduce(min)) /
//                           5,
//                       showTitles: true,
//                     ))),

//                 backgroundColor: c6,
//                 borderData: FlBorderData(
//                   show: true,
//                   border: Border.symmetric(
//                       vertical: BorderSide(
//                     color: c6,
//                   )),
//                 ),
//               ),
//             ),
//           );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
