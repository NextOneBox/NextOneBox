import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

var finalamm = sendamount?.get(1);
Box? account = Hive.box('account');
Box? alertdata = Hive.box('alertdata');
Box? alertdata2 = Hive.box('alertdata2');
Box? transhistory = Hive.box('transhistory');
Box? sendamount = Hive.box('sendamount');
Box? assets = Hive.box('assets');
Box? RealDemo = Hive.box('RealDemo');
Box? trade = Hive.box('trade');
Box? History = Hive.box('History');
Box? TradeHistory = Hive.box('TradeHistory');
Box? transwithdralhistory = Hive.box('transwithdralhistory');
Box? userdata = Hive.box('userdata');
Box? timework = Hive.box('timework');
// Color c6 = Color(0xff023047);
Color c6 = Color(0xff000000);
Color c3 = Colors.white;
Color c1 = Color(0xff000000);
Color c11 = Color(0xff03045e);
Color ct = Color(0xff83c5be);
Color ci = Color(0xffffd60a);
Color cb = Color(0xff000000);
Color blue = Color.fromARGB(255, 8, 209, 239);
Color buttoncolor = Color.fromARGB(255, 83, 76, 187);
Color green = Colors.green;
TextStyle textstyle = TextStyle(color: c3, fontWeight: FontWeight.bold);

var data = [
  {
    "name": "ARPA",
    "link": 'https://api.binance.com/api/v3/klines?symbol=ARPAUSDT&interval=1s',
    'percentage': '80%',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/test1-26938.appspot.com/o/CRYPTOIMAGES%2FARPA.png?alt=media&token=bb31de0b-20fa-4838-9c96-75783b4fc6c4'
  },
  {
    "name": "BTC",
    "link": "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1s",
    'percentage': '60%',
    "image":
        "https://t4.ftcdn.net/jpg/05/11/11/67/360_F_511116703_djZ9CLaCKJQIja8iRIoZ2MThVcTbT5OS.jpg",
  },
  {
    "name": "ACA",
    "link": 'https://api.binance.com/api/v3/klines?symbol=ACAUSDT&interval=1s',
    'percentage': '70%',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/test1-26938.appspot.com/o/CRYPTOIMAGES%2FACA.png?alt=media&token=d49b2359-cdad-44c0-a9ac-6e0e097f083f'
  },
  {
    "name": "DCR",
    "link": 'https://api.binance.com/api/v3/klines?symbol=DCRUSDT&interval=1s',
    'percentage': '60%',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/test1-26938.appspot.com/o/CRYPTOIMAGES%2FDCR.png?alt=media&token=2e3519b3-5e1a-4760-9c22-ff2353d2e8c2'
  },
  {
    "name": "ADA",
    "link": 'https://api.binance.com/api/v3/klines?symbol=ADAUSDT&interval=1s',
    'percentage': '40%',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/test1-26938.appspot.com/o/CRYPTOIMAGES%2FADA.png?alt=media&token=5939d1e7-ad52-4f30-8f7e-af63224fcccd'
  },
  {
    "name": "SXP",
    "link": 'https://api.binance.com/api/v3/klines?symbol=SXPUSDT&interval=1s',
    'percentage': '70%',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/test1-26938.appspot.com/o/CRYPTOIMAGES%2FSXP.png?alt=media&token=fdc2201d-2c46-41dd-a2ea-4c9995c5099a'
  },
  {
    "name": "ATOM",
    "link": 'https://api.binance.com/api/v3/klines?symbol=ATOMUSDT&interval=1s',
    'percentage': '70%',
    'image':
        'https://firebasestorage.googleapis.com/v0/b/test1-26938.appspot.com/o/CRYPTOIMAGES%2FATOM.png?alt=media&token=50bbec7f-b478-4c0f-99ce-a251c196403d'
  },
];
