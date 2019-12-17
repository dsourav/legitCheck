import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminStuffCreate extends StatefulWidget {
  @override
  _AdminStuffCreateState createState() => _AdminStuffCreateState();
}

class _AdminStuffCreateState extends State<AdminStuffCreate> {
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
    return ModalProgressHUD(
      inAsyncCall: _loaderState,
      progressIndicator: CircularProgressIndicator(),
      child: 
        
          Scaffold(
       backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
            key: _scaffoldKey,
          
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
              title: Text("Create Staff",style: TextStyle(color: Colors.black)),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                 Center(
                                    child: _textWidget(controller: _signupUserNameController,
                   hintText: 'Enter Name',iconValue: Icons.person,
                   keyBoardType:TextInputType.text,obsecureText: false),
                 ),
                  SizedBox(
                    height: 10.0,
                  ),
                  _textWidget(controller:_signupEmailController,
                 hintText: 'Enter Email',iconValue: Icons.email,
                 keyBoardType:TextInputType.emailAddress,obsecureText: false),
                  SizedBox(
                    height: 10.0,
                  ),
                   _textWidget(controller: _signupPasswordController,
                 hintText: 'Enter Password',iconValue: Icons.lock,
                 keyBoardType:TextInputType.visiblePassword,obsecureText: true),
                  SizedBox(
                    height: 10.0,
                  ),
                 _textWidget(controller: _signupConfirmPasswordController,
                 hintText: 'Confirm Password',iconValue: Icons.lock,
                 keyBoardType:TextInputType.visiblePassword,obsecureText: true),
                  SizedBox(
                    height: 50.0,
                  ),
                  SizedBox(
                      height: 45.0,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.black,
                        child: Text(
                          "Create Staff",
                          style: TextStyle(color: Colors.white,
                          fontFamily: 'SanBold'
                          ),
                        ),
                        onPressed: () {
                          if (_signupEmailController.text.length>5 &&
                              _signupUserNameController.text.length>3 &&
                              _signupPasswordController.text.length>5&&
                              _signupConfirmPasswordController.text.length>5&&
                              _signupPasswordController.text.toString() ==
                                  _signupConfirmPasswordController.text
                                      .toString()) {
                            setState(() {
                              _loaderState = true;
                            });

                            registerUser(_signupEmailController.text,
                                    _signupConfirmPasswordController.text)
                                .then((user) {
                              if (user != null) {
                                Firestore.instance
                                    .collection('user')
                                    .document(user.email)
                                    .setData({
                                  'user_name': _signupUserNameController.text,
                                  'user_email': _signupEmailController.text,
                                  'user_pass': _signupPasswordController.text,
                                  'role': "staff"
                                }).then((_) {
                                 
                                  // setState(() {
                                  //   _loaderState=false;
                                  // });
                                  // Navigator.of(context).pop();

                                  _send(
                                          _signupEmailController.text,
                                          '''Authentic app Login Credentials  ''',
                                          ''' <em>Here is the user email and password for Authentic app login</em><br>
  <strong>email: ${_signupEmailController.text}</strong><br>
   <strong>password:${_signupConfirmPasswordController.text}</strong><br>
  ''')
                                      .then((onValue) {
                                       if(onValue){
                                         setState(() {
                                      _loaderState = false;
                                    });
                                    Navigator.of(context).pop();

                                       }
                                       else{
                                         print("wrong");
                                       }

                                    
                                  });
                                });
                              }
                            });
                          } else {
                            showSnackbar('please fill up the field');
                          }
                        },
                      ))
                ],
              ),
            ),
          )
       
    );
  }


  Widget _textWidget({hintText,iconValue,controller,keyBoardType,obsecureText}){
   return  SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 45.0,
                          child: TextFormField(
                            obscureText: obsecureText,
                            controller: controller,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 20.0),
                            decoration: new InputDecoration(
                              prefixIcon: Container(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 20.0),
                                  child: Icon(
                                    iconValue,
                                    color: Colors.white,
                                    size: 35.0,
                                  )),
                              hintText: hintText,
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
                            keyboardType: keyBoardType
                          ),
                        );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future _send(String email, String subject, String body) async {
    bool _sendStatus;
    final MailOptions mailOptions = MailOptions(
      body: body,
      subject: subject,
      recipients: <String>[email],
      isHTML: true,
    );

    try {
      await FlutterMailer.send(mailOptions);
      _sendStatus = true;
    } catch (error) {
      _sendStatus = false;
    }
    return _sendStatus;
  }

  static Future<FirebaseUser> registerUser(
      String email, String password) async {
    FirebaseApp app = await FirebaseApp.configure(
        name: 'secondary', options: await FirebaseApp.instance.options);
    return FirebaseAuth.fromApp(app)
        .createUserWithEmailAndPassword(email: email, password: password);
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


    
}
