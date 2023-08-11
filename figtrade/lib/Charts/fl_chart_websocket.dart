// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;

// import '../widget.dart';

// final List<FlSpot> dataPoints = [];
// List<HorizontalLine> _horizontalLines = [];
// void addHorizontalLinesput() {
//   _horizontalLines.add(
//     HorizontalLine(
//       y: RealDemo?.get('y'),
//       color: Colors.red,
//       strokeWidth: 2,
//       dashArray: [4],
//       label: HorizontalLineLabel(
//           labelResolver: (p0) {
//             return '↓₹${RealDemo?.get('tradeamount')}';
//           },
//           show: true,
//           padding: EdgeInsets.only(right: 40),
//           alignment: Alignment.bottomRight,
//           style: textstyle),
//     ),
//   );
//   Future.delayed(Duration(seconds: 60), () {
//     _horizontalLines.removeAt(0);
//   });
// }

// void addHorizontalLinescall() {
//   _horizontalLines.add(
//     HorizontalLine(
//       y: RealDemo?.get('y'),
//       color: Colors.green,
//       strokeWidth: 2,
//       dashArray: [3],
//       label: HorizontalLineLabel(
//           labelResolver: (p0) {
//             return '↑₹${RealDemo?.get('tradeamount')}';
//           },
//           show: true,
//           padding: EdgeInsets.only(right: 50),
//           alignment: Alignment.topRight,
//           style: textstyle),
//     ),
//   );
//   Future.delayed(Duration(seconds: 60), () {
//     _horizontalLines.removeAt(0);
//   });
// }

// class LiveBitcoinPrice extends StatefulWidget {
//   @override
//   _LiveBitcoinPriceState createState() => _LiveBitcoinPriceState();
// }

// class _LiveBitcoinPriceState extends State<LiveBitcoinPrice> {
//   final List<FlSpot> dataPoints = [];
//   IOWebSocketChannel? channel;
//   late List<Map<String, dynamic>> historicalData;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     _isLoading = true;
//     super.initState();
//     fetchHistoricalData().then((data) {
//       setState(() {
//         historicalData = data;
//         dataPoints.addAll(data.map(
//             (item) => FlSpot(item['timestamp'].toDouble(), item['price'])));
//         _isLoading = false;
//       });
//     });
//     connectToWebSocket();
//     Timer.periodic(Duration(seconds: 1), (Timer t) => setState(() {}));
//   }

//   void connectToWebSocket() {
//     channel = IOWebSocketChannel.connect(
//         'wss://stream.binance.com:9443/ws/btcusdt@ticker');
//     channel!.stream.listen((message) {
//       final Map<String, dynamic> data = jsonDecode(message);
//       // print(data);
//       final double price = double.parse(data['c']);
//       final int timestamp = DateTime.now().millisecondsSinceEpoch;
//       setState(() {
//         dataPoints.add(FlSpot(timestamp.toDouble(), price));
//       });
//     });
//   }

//   Future<List<Map<String, dynamic>>> fetchHistoricalData() async {
//     final response = await http.get(Uri.parse(
//         "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1s"));
//     if (response.statusCode == 200) {
//       final List<dynamic> data = jsonDecode(response.body);
//       return data
//           .map((item) => {
//                 'timestamp': item[0],
//                 'price': double.parse(item[4]),
//               })
//           .toList();
//     } else {
//       throw Exception('Failed to fetch historical data');
//     }
//   }

//   @override
//   void dispose() {
//     channel?.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Timer.periodic(Duration(seconds: 3), (timer) async {
//       if (dataPoints.isNotEmpty) {
//         RealDemo?.put('y', dataPoints.last.y);
//       }
//     });

//     return Container(
//       child: _isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SafeArea(
//               child: LineChart(
//                 LineChartData(
//                     minX: dataPoints.first.x, //left
//                     maxX: dataPoints.last.x + 40000, //right
//                     minY: dataPoints.map((spot) => spot.y).reduce(min), //bottom
//                     maxY: dataPoints.map((spot) => spot.y).reduce(max), //top
//                     extraLinesData: ExtraLinesData(
//                       verticalLines: [
//                         VerticalLine(
//                           x: dataPoints.last.x,
//                           color: Colors.white,
//                           strokeWidth: 1,
//                           dashArray: [1],
//                         )
//                       ],
//                       horizontalLines: _horizontalLines,
//                     ),
//                     lineTouchData: LineTouchData(
//                       getTouchLineStart: (Datachart, spotIndex) {
//                         return Datachart.spots[spotIndex].y;
//                       },
//                       handleBuiltInTouches: true,
//                       enabled: false,
//                       // touchSpotThreshold: Datachart?.last.y,
//                       touchTooltipData: LineTouchTooltipData(
//                         getTooltipItems: (touchedSpots) {
//                           return touchedSpots.map((spot) {
//                             return LineTooltipItem(
//                               '${spot.y}',
//                               TextStyle(color: c6, fontWeight: FontWeight.bold),
//                             );
//                           }).toList();
//                         },
//                         fitInsideHorizontally: true,
//                         showOnTopOfTheChartBoxArea: true,
//                         tooltipHorizontalAlignment: FLHorizontalAlignment.right,
//                         fitInsideVertically: true,
//                         tooltipHorizontalOffset: 500,
//                         tooltipBgColor: c3,
//                       ),
//                     ),
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: dataPoints,
//                         isCurved: true,
//                         color: blue,
//                         barWidth: 1.30,
//                         dotData: FlDotData(
//                           show: true,
//                           checkToShowDot: (spot, _) =>
//                               spot.x == dataPoints.map((e) => e.x).reduce(max),
//                           getDotPainter: (p0, p1, p2, p3) {
//                             return FlDotCirclePainter(
//                               strokeColor: Colors.white,
//                               color: Colors.red,
//                               radius: 2,
//                               strokeWidth: 2,
//                             );
//                           },
//                         ),
//                         belowBarData: BarAreaData(
//                           ///....this is showing a vertical line with dot
//                           spotsLine: BarAreaSpotsLine(
//                             show: false,
//                             flLineStyle: FlLine(
//                               color: Colors.red,
//                               strokeWidth: 2,
//                               dashArray: [5],
//                             ),
//                             checkToShowSpotLine: (spot) =>
//                                 spot.x ==
//                                 dataPoints.map((e) => e.x).reduce(max),
//                           ),
//                           show: true,
//                           // color: Color(0xff15616d),
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 12, 44, 77),
//                               // Color(0xff15616d),
//                               Color.fromARGB(255, 10, 51, 59),
//                               Colors.transparent
//                             ],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                       ),
//                     ],
//                     titlesData: FlTitlesData(
//                         show: true,
//                         bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                           interval: 5,
//                           reservedSize: 20,
//                           showTitles: false,
//                         )),
//                         topTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                           showTitles: false,
//                         )),
//                         rightTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                           getTitlesWidget: (value, meta) {
//                             return Text(
//                               meta.formattedValue.toString(),
//                               style: textstyle,
//                             );
//                           },
//                           reservedSize: 40,
//                           // interval: 50,
//                           interval:
//                               (dataPoints.map((spot) => spot.y).reduce(max) -
//                                       dataPoints
//                                           .map((spot) => spot.y)
//                                           .reduce(min)) /
//                                   5,
//                           showTitles: true,
//                         ))),
//                     gridData: FlGridData(
//                       show: true,
//                       drawVerticalLine: true,
//                       drawHorizontalLine: true,
//                       // horizontalInterval: 100,
//                       // verticalInterval: 1,
//                       getDrawingHorizontalLine: (value) {
//                         return FlLine(
//                           dashArray: [2],
//                           color: const Color(0xff37434d),
//                           strokeWidth: 0.50,
//                         );
//                       },
//                       getDrawingVerticalLine: (value) {
//                         return FlLine(
//                           dashArray: [2],
//                           color: const Color(0xff37434d),
//                           strokeWidth: 0.50,
//                         );
//                       },
//                     ),
//                     backgroundColor: c6),
//               ),
//             ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class BTCChart extends StatefulWidget {
  @override
  _BTCChartState createState() => _BTCChartState();
}

class _BTCChartState extends State<BTCChart> {
  List<List<num>> _data = [];
 io.Socket? socket;

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    socket = io.io('wss://stream.binance.com:9443', {
      'transports': ['websocket'],
      'query': 'symbol=BTCUSDT@kline_1s',
    });

    socket!.on('kline', (data) {
      final decodedData = jsonDecode(data);
      final klineData = decodedData['k'];
      setState(() {
        _data.add([klineData['t'], double.parse(klineData['c'])]);
      });
    });
  }

  @override
  void dispose() {
    // Close the WebSocket connection when the widget is disposed
    socket?.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BTC Live Chart')),
      body: Center(
        child: (_data.isNotEmpty)
            ? LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _data
                          .asMap()
                          .map((index, data) =>
                              MapEntry(index, FlSpot(data[0].toDouble(), data[1].toDouble())))
                          .values
                          .toList(),
                      isCurved: true,
                      color: Colors.blue,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey),
                  ),
                  minX: _data.first.first.toDouble(),
                  maxX: _data.last.first.toDouble(),
                  minY: _data.map((data) => data[1]).reduce((a, b) => a < b ? a : b).toDouble(),
                  maxY: _data.map((data) => data[1]).reduce((a, b) => a > b ? a : b).toDouble(),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }


}
