import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/forgetPassDialouge.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CustomerLogIn extends StatefulWidget {
  @override
  _CustomerLogInState createState() => _CustomerLogInState();
}

class _CustomerLogInState extends State<CustomerLogIn> {
  TextEditingController _loginEmailController;
  TextEditingController _loginPasswordController;
  bool _loaderState = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loginEmailController = new TextEditingController();
    _loginPasswordController = new TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
      body: ModalProgressHUD(
          inAsyncCall: _loaderState,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.43,
                                child: Image.asset('assets/logo_black.png')),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: Container(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontFamily: 'SanBold',
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            controller: _loginEmailController,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 20.0),
                            decoration: new InputDecoration(
                              prefixIcon: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 35.0,
                                  )),
                              hintText: "Enter Email",
                              contentPadding: EdgeInsets.only(
                                top: 15.0,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SanRegular',
                                  fontSize: 25.0),
                              fillColor: Colors.black,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                              //fillColor: Colors.green
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: _loginPasswordController,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 25.0),
                            decoration: new InputDecoration(
                              prefixIcon: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 35.0,
                                  )),
                              hintText: "Enter Password",
                              contentPadding: EdgeInsets.only(
                                top: 15.0,
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SanRegular',
                                  fontSize: 25.0),
                              fillColor: Colors.black,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                              //fillColor: Colors.green
                            ),
                          ),
                        ),

                      //  SizedBox(height: 15.0,),
                        FlatButton(
                          child: Text('forgot password?',
                          style:TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'SanRegular',
                                  fontSize: 15.0)),
                          onPressed: (){
                             showDialog(context: context,
                      builder: (_)=>ForgetPassDialouge(),
                      barrierDismissible: false

                      );

                          },
                        ),
                        Container(
                           // margin: EdgeInsets.only(top: 20.0),
                            height: 40.0,
                            width: 40.0,
                            child: InkWell(
                              child: Image.asset('assets/tick.png'),
                              onTap: ()async{
                            


                                if (_loginEmailController.text.length>0 &&
                      _loginPasswordController.text.length>5) {
                    setState(() {
                      _loaderState = true;
                    });

                    try{

                      await loginUser(
                            email: _loginEmailController.text,
                            password: _loginPasswordController.text)
                        .then((user) {
                      if (user != null) {
                        Navigator.of(context)
                            .pushReplacementNamed('/landingPage');
                      } else {
                        showSnackbar('something wrong');
                      }
                    });

                    }on AuthException catch (error) {
                                return _buildErrorDialog(
                                    context, error.message);
                              } on Exception catch (error) {
                                return _buildErrorDialog(
                                    context, error.toString());
                              }
                    
                  } else {
                    showSnackbar('please fill up the field correctly');
                  }

                              },
                              ))
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: InkWell(
                        child: Image.asset(
                          'assets/back_arrow.png',
                          height: 35.0,
                          width: 40.0,
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/loginuser');
                        },
                      ),
                    )),
              ],
            ),
          )),
    );
  }


     Future _buildErrorDialog(BuildContext context, _message) {
    setState(() {
      _loaderState = false;
    });
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
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
