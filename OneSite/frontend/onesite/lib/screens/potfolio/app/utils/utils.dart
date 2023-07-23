import 'package:flutter/material.dart';
import 'package:onesite/screens/potfolio//app/sections/contact/contact.dart';
import 'package:onesite/screens/potfolio//app/sections/home/home.dart';
import 'package:onesite/screens/potfolio//app/sections/portfolio/portfolio.dart';
import 'package:onesite/screens/potfolio//app/sections/services/services.dart';
import 'package:onesite/screens/potfolio//app/widgets/footer.dart';

class BodyUtils {
  static const List<Widget> views = [
    HomePage(),
    // About(),
    Services(),
    Portfolio(),
    Contact(),
    Footer(),
  ];
}
