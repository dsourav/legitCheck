import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CustomerSignUp extends StatefulWidget {
  @override
  _CustomerSignUpState createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  TextEditingController _signupEmailController;
  TextEditingController _signupUserNameController;
  TextEditingController _signupPasswordController;
  TextEditingController _signupConfirmPasswordController;
  bool _loaderState = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _signupEmailController = new TextEditingController();
    _signupUserNameController = new TextEditingController();
    _signupPasswordController = new TextEditingController();
    _signupConfirmPasswordController = new TextEditingController();

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
                          padding: EdgeInsets.only(top: 40.0),
                          child: Container(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontFamily: 'SanBold',
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            controller: _signupEmailController,
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
                          height: 15.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            controller: _signupUserNameController,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 20.0),
                            decoration: new InputDecoration(
                              prefixIcon: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 35.0,
                                  )),
                              hintText: "Enter User Name",
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
                          height: 15.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: _signupPasswordController,
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
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: _signupConfirmPasswordController,
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
                              hintText: "Confirm Password",
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
                        Container(
                            margin: EdgeInsets.only(top: 30.0),
                            height: 40.0,
                            width: 40.0,
                            child: InkWell(
                              child: Image.asset('assets/tick.png'),
                              onTap: () async {
                                if (_signupEmailController.text.length > 0 &&
                                    _signupUserNameController.text.length > 0 &&
                                    _signupPasswordController.text.length > 0 &&
                                    _signupConfirmPasswordController
                                            .text.length >
                                        0 &&
                                    _signupPasswordController.text.toString() ==
                                        _signupConfirmPasswordController.text
                                            .toString()) {
                                  setState(() {
                                    _loaderState = true;
                                  });

                                  try {
                                    await createUser(
                                            email: _signupEmailController.text,
                                            password:
                                                _signupConfirmPasswordController
                                                    .text)
                                        .then((user) {
                                      if (user != null) {
                                        Firestore.instance
                                            .collection('user')
                                            .document(user.email)
                                            .setData({
                                          'customer_name':
                                              _signupUserNameController.text,
                                          'customer_email':
                                              _signupEmailController.text,
                                          'customer_password':
                                              _signupPasswordController.text,
                                              'user_id':user.uid,
                                          'role': "customer"
                                        }).then((_) {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/landingPage');
                                        });

                                        print(user.email);
                                      } else {
                                        showSnackbar('something wrong');
                                      }
                                    });
                                  } on AuthException catch (error) {
                                    return _buildErrorDialog(
                                        context, error.message);
                                  } on Exception catch (error) {
                                    return _buildErrorDialog(
                                        context, error.toString());
                                  }
                                } else {
                                  showSnackbar('please fill up the field');
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

  // _buildSignUp(context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(
  //           height: 60.0,
  //         ),
  //         Container(
  //           height: 60.0,
  //           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           child: CupertinoTextField(
  //             controller: _signupEmailController,
  //             prefix: Padding(
  //               padding: EdgeInsets.only(left: 5.0),
  //               child: Icon(
  //                 Icons.email,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             keyboardType: TextInputType.emailAddress,
  //             placeholder: 'Enter Email',
  //             placeholderStyle: TextStyle(color: Colors.white),
  //             style: TextStyle(color: CupertinoColors.white),
  //             clearButtonMode: OverlayVisibilityMode.editing,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 40.0,
  //         ),
  //         Container(
  //           height: 60.0,
  //           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           child: CupertinoTextField(
  //             controller: _signupUserNameController,
  //             prefix: Padding(
  //               padding: EdgeInsets.only(left: 5.0),
  //               child: Icon(
  //                 Icons.person,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             keyboardType: TextInputType.emailAddress,
  //             placeholder: 'Enter User Name',
  //             placeholderStyle: TextStyle(color: Colors.white),
  //             style: TextStyle(color: CupertinoColors.white),
  //             clearButtonMode: OverlayVisibilityMode.editing,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 40.0,
  //         ),
  //         Container(
  //           height: 60.0,
  //           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           child: CupertinoTextField(
  //             obscureText: true,
  //             controller: _signupPasswordController,
  //             prefix: Padding(
  //               padding: EdgeInsets.only(left: 5.0),
  //               child: Icon(
  //                 Icons.lock,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             keyboardType: TextInputType.visiblePassword,
  //             placeholder: 'Enter Password',
  //             placeholderStyle: TextStyle(color: Colors.white),
  //             style: TextStyle(color: CupertinoColors.white),
  //             clearButtonMode: OverlayVisibilityMode.editing,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 40.0,
  //         ),
  //         Container(
  //           height: 60.0,
  //           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           child: CupertinoTextField(
  //             obscureText: true,
  //             controller: _signupConfirmPasswordController,
  //             prefix: Padding(
  //               padding: EdgeInsets.only(left: 5.0),
  //               child: Icon(
  //                 Icons.lock,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             keyboardType: TextInputType.visiblePassword,
  //             placeholder: 'Confirm Password',
  //             placeholderStyle: TextStyle(color: Colors.white),
  //             style: TextStyle(color: CupertinoColors.white),
  //             clearButtonMode: OverlayVisibilityMode.editing,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.white),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 70.0,
  //         ),
  //         SizedBox(
  //             height: 40.0,
  //             width: MediaQuery.of(context).size.width * 0.5,
  //             child: RaisedButton(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(15.0)),
  //               color: Colors.red,
  //               child: Text(
  //                 "Log In",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               onPressed: () {
  //                 if (_signupEmailController.text != null &&
  //                     _signupUserNameController.text != null &&
  //                     _signupPasswordController.text != null &&
  //                     _signupConfirmPasswordController.text != null &&
  //                     _signupPasswordController.text.toString() ==
  //                         _signupConfirmPasswordController.text.toString()) {

  //                           setState(() {
  //                             _loaderState=true;
  //                           });
  //                           createUser(email: _signupEmailController.text,
  //                           password: _signupConfirmPasswordController.text).then((user){
  //                             if(user!=null){
  //                               Firestore.instance.collection('user').document(user.email).setData({
  //                                 'customer_name':_signupUserNameController.text,
  //                                 'customer_email':_signupEmailController.text,
  //                                 'customer_password':_signupPasswordController.text,
  //                                 'role':"customer"

  //                               }).then((_){
  //                                 Navigator.of(context).pushReplacementNamed('/customerhome');

  //                               });

  //                               print(user.email);

  //                             }
  //                             else{
  //                               showSnackbar('something wrong');
  //                             }

  //                           });

  //                         }

  //                     else{
  //                        showSnackbar('please fill up the field');

  //                     }
  //               },
  //             ))
  //       ],
  //     ),
  //   );
  // }
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

  Future<FirebaseUser> createUser(
      {String firstName,
      String lastName,
      String email,
      String password}) async {
    try {
      var u = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return u;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }
}
