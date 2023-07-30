import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CourseScreen extends StatefulWidget {
  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F4EF),
          image: DecorationImage(
            image: AssetImage("assets/images/ux_big.png"),
            alignment: Alignment.topRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 50, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  
                    SizedBox(height: 30),
                    ClipPath(
                      clipper: BestSellerClipper(),
                      child: Container(
                        color: kBestSellerColor,
                        padding: EdgeInsets.only(
                            left: 10, top: 5, right: 20, bottom: 5),
                        child: Text(
                          "BestSeller".toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text("Make earning app like this \nin 1 month", style: kHeadingextStyle),
                    SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset("assets/icons/person.svg"),
                        SizedBox(width: 5),
                        Text("18K"),
                        SizedBox(width: 20),
                        SvgPicture.asset("assets/icons/star.svg"),
                        SizedBox(width: 5),
                        Text("4.8")
                      ],
                    ),
                    SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "₹999 ",
                            style: kHeadingextStyle.copyWith(fontSize: 32),
                          ),
                          TextSpan(
                            text: "₹7000",
                            style: TextStyle(
                              color: kTextColor.withOpacity(.5),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
         
            SizedBox(height: 60),    
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Complete Course with Source code", style: kTitleTextStyle),
                          SizedBox(height: 30),
                          CourseContent(
                            number: "01",
                            duration: 300,
                            title: "How to make app or website",
                            isDone: false,
                          ),
                         
                          CourseContent(
                            number: '02',
                            duration: 120,
                            title: "How to grow with now money",
                            isDone: false,
                          ),
                          CourseContent(
                            number: '03',
                            duration: 120,
                            title: "How to start from home",
                          ),
                          CourseContent(
                            number: '04',
                            duration: 120,
                            title: "How to earn first 1 Lakh.",
                          ),
                                Text(
                           "Start your own app today from home \nLimited seats available Hurry up! \nYou are lossing 1 lakh",
                         
                        ),
                        ],
                      ),
                    ),
                          
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 50,
                              color: kTextColor.withOpacity(.1),
                            ),
                            
                          ],
                          
                        ),
                        
                        child: InkWell(
                          onTap: () {
                                            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pay(link: 'https://cosmofeed.com/vp/64b17f103111630020a73905',price: 999.0,type: 'Course',)),
      );
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(14),
                                height: 56,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFEDEE),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: SvgPicture.asset(
                                    "assets/icons/shopping-bag.svg"),
                              ),
                              SizedBox(width: 20),
                                             
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: kBlueColor,
                                  ),
                                  child: Text(
                                    "Buy Now",
                                    style: kSubtitleTextSyule.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseContent extends StatelessWidget {
  final String number;
  final double duration;
  final String title;
  final bool isDone;
  const CourseContent({
    Key? key,
    required this.number,
    required this.duration,
    required this.title,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number,
            style: kHeadingextStyle.copyWith(
              color: kTextColor.withOpacity(.15),
              fontSize: 32,
            ),
          ),
          SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$duration mins\n",
                  style: TextStyle(
                    color: kTextColor.withOpacity(.5),
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: title,
                  style: kSubtitleTextSyule.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGreenColor.withOpacity(isDone ? 1 : .5),
            ),
            child: Icon(Icons.play_arrow, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class BestSellerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}


const kTextColor = Color(0xFF0D1333);
const kBlueColor = Color(0xFF6E8AFA);
const kBestSellerColor = Color(0xFFFFD073);
const kGreenColor = Color(0xFF49CC96);

// My Text Styles
const kHeadingextStyle = TextStyle(
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);
const kSubheadingextStyle = TextStyle(
  fontSize: 24,
  color: Color(0xFF61688B),
  height: 2,
);

const kTitleTextStyle = TextStyle(
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextSyule = TextStyle(
  fontSize: 18,
  color: kTextColor,
  // fontWeight: FontWeight.bold,
);