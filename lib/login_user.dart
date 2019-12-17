import 'package:flutter/material.dart';


class LogInUser extends StatefulWidget {
  @override
  _LogInUserState createState() => _LogInUserState();
}

class _LogInUserState extends State<LogInUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
        body: Container(
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
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.43,
                              child: Image.asset('assets/logo_black.png')),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: Container(
                          child: Text(
                            "Hello!",
                            style: TextStyle(
                                fontSize: 50.0,
                                fontFamily: 'SanBold',
                                color: Colors.black),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 120.0),
                        child: SizedBox(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: RaisedButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/customerlogin');
                            },
                            child: Text(
                              "Login with Email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SanRegular',
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "New here?",
                                style: TextStyle(
                                    fontFamily: 'SanRegular', fontSize: 17.0),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/customersignup');
                                },
                                child: Text(
                                  "\tSign up",
                                  style: TextStyle(
                                      fontFamily: 'SanBold', fontSize: 17.0),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[

              //      Container(
              //             padding: EdgeInsets.only(bottom: 20.0),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: <Widget>[
              //                 InkWell(
              //                   onTap: (){
              //                          Navigator.of(context)
              //                         .pushReplacementNamed('/customerlogin');
              //                   },
              //                                                 child: Text(
              //                     "Staff",
              //                     style: TextStyle(
              //                         fontFamily: 'SanBold', fontSize: 17.0),
              //                   ),
              //                 ),
              //                 SizedBox(width: 20.0,),
              //                 InkWell(
              //                   onTap: () {
              //                     Navigator.of(context)
              //                         .pushReplacementNamed('/customerlogin');
              //                   },
              //                   child: Text(
              //                     "Admin",
              //                     style: TextStyle(
              //                         fontFamily: 'SanBold', fontSize: 17.0),
              //                   ),
              //                 )
              //               ],
              //             )),
                 
              //   ],
              // )
            ],
          ),
        )
        );
  }
}
