import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/admin/admin_home.dart';
import 'package:legit_check/admin/admin_login.dart';
import 'package:legit_check/customer/customer_home.dart';
import 'package:legit_check/customer/customer_login.dart';
import 'package:legit_check/customer/customer_signup.dart';
import 'package:legit_check/landingpage.dart';
import 'package:legit_check/login_user.dart';
import 'package:legit_check/staff/staff_home.dart';
import 'package:legit_check/staff/staff_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'inroslider.dart';

void main() =>
   runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: LandingPage(),
  
      routes: <String, WidgetBuilder>{
    '/landingPage':(BuildContext context)=>LandingPage(),
    '/adminlogin': (BuildContext context) => AdminLogIn(),
    '/customerlogin': (BuildContext context) => CustomerLogIn(),
    '/stafflogin': (BuildContext context) => StaffLogIn(),
    '/loginuser': (BuildContext context) => LogInUser(),
    '/customerlogin': (BuildContext context) => CustomerLogIn(),
    '/customersignup': (BuildContext context) => CustomerSignUp(),
    '/customerhome': (BuildContext context) => CustomerHome(),
    '/adminhome': (BuildContext context) => AdminHome(),
    '/staffhome': (BuildContext context) => StaffHome(),
      },
    );
  }
}





class Splash extends StatefulWidget {
@override
SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => LandingPage()));
    } else {
    prefs.setBool('seen', true);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) =>  IntroSlider()));
    }
}

@override
void initState() {
    super.initState();
    checkFirstSeen();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}