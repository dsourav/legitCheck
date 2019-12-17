import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StaffLogIn extends StatefulWidget {
  @override
  _StaffLogInState createState() => _StaffLogInState();
}

class _StaffLogInState extends State<StaffLogIn> {
  TextEditingController _staffEmailController;
  TextEditingController _staffPasswordController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loaderState = false;
  @override
  void initState() {
    _staffEmailController = new TextEditingController();
    _staffPasswordController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loaderState,
      progressIndicator: CircularProgressIndicator(),
      child: Stack(
              children: [
           new Container(
          height: double.infinity,
          width: double.infinity,
          decoration: new BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/app_background.png'))),
        ),       
                Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 120.0,
                  ),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CupertinoTextField(
                      controller: _staffEmailController,
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      placeholder: 'Enter Staff Email',
                      clearButtonMode: OverlayVisibilityMode.editing,
                       placeholderStyle: TextStyle(color: Colors.white),
              style: TextStyle(color: CupertinoColors.white),
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
                      controller: _staffPasswordController,
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      placeholder: 'Enter Staff Password',
                      clearButtonMode: OverlayVisibilityMode.editing,
                       placeholderStyle: TextStyle(color: Colors.white),
              style: TextStyle(color: CupertinoColors.white),
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
                          if (_staffEmailController.text != null &&
                              _staffPasswordController.text != null) {
                            setState(() {
                              _loaderState = true;
                            });

                            loginUser(
                                    email: _staffEmailController.text,
                                    password: _staffPasswordController.text)
                                .then((onValue) {
                              if (onValue != null) {
                                Navigator.of(context)
                                    .pushReplacementNamed('/staffhome');
                              } else {
                                showSnackbar('something wrong');
                              }
                            });
                          }
                          else{
                            showSnackbar('please enter all field');
                          }
                        },
                      ))
                ],
              ),
            ),
          ),
        ),]
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
}
