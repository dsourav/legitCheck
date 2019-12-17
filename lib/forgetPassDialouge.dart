import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class ForgetPassDialouge extends StatefulWidget {
  @override
  _ForgetPassDialougeState createState() => _ForgetPassDialougeState();
}

class _ForgetPassDialougeState extends State<ForgetPassDialouge> {
  bool _loaderState = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ModalProgressHUD(
            inAsyncCall: _loaderState,
            child: SimpleDialog(children: <Widget>[
              Center(
                  child: Text(
                "Enter email for password reset",
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'SanRegular',
                ),
              )),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(hintText: 'Enter email'),
                    validator: (value) {
                      if (isEmail(value)) return null;
                      return 'Enter valid email';
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: RaisedButton(
                  color: Color.fromRGBO(247, 202, 21, 1.0),
                  child: Text(
                    "Send email",
                    style:
                        TextStyle(color: Colors.black, fontFamily: 'SanBold'),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _loaderState = true;
                      });
                      

                      try {
                 

                    await resetCode();
                    Navigator.of(context).pop();


                     

                      } on AuthException catch (error) {
                        return _buildErrorDialog(context, error.message);
                      } on Exception catch (error) {
                        return _buildErrorDialog(context, error.toString());
                      }
                    }
                  },
                ),
              )
            ])));
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

  resetCode() async {
    try {
      var result = await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controllerEmail.text);
      return result;
    } catch (e) {
      throw new AuthException(e.code, e.message);
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
