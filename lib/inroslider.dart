import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  static final page = new PageViewModel(
    pageColor: Color.fromRGBO(37, 168, 250, 1.0),

     bubbleBackgroundColor: Colors.amberAccent,
    
    title: Image.asset(
      'assets/hand_shaking.png',
      height: 185.0,
      width: 185.0,
      alignment: Alignment.center,
    ),
    mainImage: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              "Welcome TO XYZ",
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                  'Easy  cab  booking  at  your  with  cashless  payment  system here you find all you need',
                  style: TextStyle(color: Colors.white70, fontSize: 18.0)),
            )
          ],
        )), body: Text(""),
  );

   static final page2 = new PageViewModel(
    pageColor:  Color.fromRGBO(71, 121, 210, 1.0),

     bubbleBackgroundColor: Colors.blueGrey,
    
    title: Image.asset(
      'assets/hand_shaking.png',
      height: 185.0,
      width: 185.0,
      alignment: Alignment.center,
    ),
    mainImage: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              "Create new Item",
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                  'Easy  cab  booking  at  your item can be added with  cashless  payment  system here you find all you need',
                  style: TextStyle(color: Colors.white70, fontSize: 18.0)),
            )
          ],
        )), body: Text(""),
  );
  

     static final page3 = new PageViewModel(
        pageColor:  Color.fromRGBO(92, 84, 183, 1.0),


     bubbleBackgroundColor: Colors.blueGrey,
    
    title: Image.asset(
      'assets/hand_shaking.png',
      height: 185.0,
      width: 185.0,
      alignment: Alignment.center,
    ),
    mainImage: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              "Stay Connected",
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                  'Easy  cab  booking  at stay connnected your item can be added with  cashless  payment  system here you find all you need',
                  style: TextStyle(color: Colors.white70, fontSize: 18.0)),
            )
          ],
        )), body: Text(""),
  );
 



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroViewsFlutter(
    
    [page,page2,page3],
   onTapDoneButton: () {
            Navigator.of(context).pushReplacementNamed('/loginuser');
          },
    //showNextButton: true,
    nextText: Text("Next",style: TextStyle(color: Colors.pink),),
    showSkipButton: true,
    pageButtonTextStyles: new TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontFamily: "Regular",
      
    ),
  ),
    );
  }
}