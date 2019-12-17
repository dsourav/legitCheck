import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminLogIn extends StatefulWidget {
  @override
  _AdminLogInState createState() => _AdminLogInState();
}

class _AdminLogInState extends State<AdminLogIn> {
  TextEditingController _adminEmailController;
  TextEditingController _adminPasswordController;

  bool _loaderState = false;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _adminEmailController = new TextEditingController();
    _adminPasswordController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loaderState,
      progressIndicator: CircularProgressIndicator(),
      child: Container(
        child: Stack(children: [
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration: new BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/app_background.png'))),
          ),
          Scaffold(
             key: _scaffoldKey,
             backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 120.0,
                  ),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CupertinoTextField(
                      controller: _adminEmailController,
                      placeholderStyle: TextStyle(color: Colors.white),
                      style: TextStyle(color: CupertinoColors.white),
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      placeholder: 'Enter Admin Email',
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CupertinoTextField(
                      obscureText: true,
                      controller: _adminPasswordController,
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      placeholder: 'Enter Admin Password',
                      placeholderStyle: TextStyle(color: Colors.white),
                      style: TextStyle(color: CupertinoColors.white),
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  SizedBox(
                      height: 40.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.red,
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_adminEmailController.text != null &&
                              _adminPasswordController.text != null) {
                            setState(() {
                              _loaderState = true;
                            });

                            _checkAdminORNot().then((onValue) {
                              if (onValue.toString() ==
                                  _adminEmailController.text.toString()) {

                                    //you are admin
                               loginUser(email: _adminEmailController.text.toString(),
                               password: _adminPasswordController.text.toString()).then((v){
                                
                                   Navigator.of(context).pushReplacementNamed('/adminhome');

                                 
                                

                               });
                              } else {
                                showSnackbar('you are not admin');
                              }
                            });
                          }
                          else{
                            showSnackbar('please fill up the field');
                          }
                        },
                      ))
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void showSnackbar(String message) {
    setState(() {
      _loaderState = false;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }

  Future<FirebaseUser> loginUser({String email, String password}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return result;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }

  Future _checkAdminORNot() async {
    var data = Firestore.instance.collection('user').where('role',isEqualTo: 'admin');
    var querySnapshot = await data.getDocuments();
    String email = querySnapshot.documents[0]['email'];
    return email;
  }

}
