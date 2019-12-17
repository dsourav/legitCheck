import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {
    getUser().then((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed('/loginuser');
      } else {
       var userData= Firestore.instance
            .collection('user')
            .document(user.email);
           
            userData.get().then((onValue){
              var role = onValue['role'];
              if(role=='customer'){
                 Navigator.of(context).pushReplacementNamed('/customerhome');
              }
              if(role=='staff'){
                 Navigator.of(context).pushReplacementNamed('/staffhome');
              }
               if(role=='admin'){
                 Navigator.of(context).pushReplacementNamed('/adminhome');
              }

            });
      }
    });

    super.initState();
  }


 Future<FirebaseUser> getUser() {
    return _auth.currentUser();
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