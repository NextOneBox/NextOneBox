import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class WidthrawHistory extends StatefulWidget {
  const WidthrawHistory({super.key});

  @override
  State<WidthrawHistory> createState() => _WidthrawHistoryState();
}

class _WidthrawHistoryState extends State<WidthrawHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        backgroundColor: SecondaryColor,
        elevation: 0,
        title: const Text(
          'Payout History',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );

  }
}