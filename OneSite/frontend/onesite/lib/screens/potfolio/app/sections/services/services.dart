import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onesite/screens/potfolio//app/utils/services_utils.dart';
import 'package:onesite/screens/potfolio//app/widgets/custom_text_heading.dart';
import 'package:onesite/screens/potfolio//changes/strings.dart';
import 'package:onesite/screens/potfolio//core/color/colors.dart';
import 'package:onesite/screens/potfolio//core/res/responsive.dart';
import 'package:onesite/screens/potfolio//core/configs/configs.dart';
import 'package:sizer/sizer.dart';

part 'services_desktop.dart';
part 'services_mobile.dart';
part 'widgets/_services_card.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: ServiceMobile(),
      tablet: ServiceMobile(),
      desktop: ServiceDesktop(),
    );
  }
}
