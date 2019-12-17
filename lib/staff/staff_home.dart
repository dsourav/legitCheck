import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/pushNotification/notificationFucntion.dart';
import 'package:legit_check/staff/pendingItem.dart';
import 'package:legit_check/staff/verifiedItem.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StaffHome extends StatefulWidget {
  @override
  _StaffHomeState createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  bool _loaderState = false;

  FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getUser();
  
               
    super.initState();
  }

  getUser() {
    _auth.currentUser().then((onValue) {
      if(onValue!=null){
          registerNotification(onValue.email);
            configLocalNotification();
      }
      setState(() {
        _user = onValue;
      });
    });
  }

  final menu = new Menu(
    items: [
      new MenuItem(
        icon: Icons.remove_red_eye,
        id: 'pending_items',
        title: 'Pending item',
      ),
      new MenuItem(
        icon: Icons.remove_red_eye,
        id: 'verified_items',
        title: 'Verified item',
      ),
    ],
  );

  var selectedMenuItemId = 'pending_items';

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
        percentage: 0.8,
        cornerRadius: 25.0,
        appBar: AppBarProps(
            backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
            title: Text(
              "",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black87)),
        menuView: new MenuView(
          selectorColor: Colors.black,
          textStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontFamily: 'SanBold',
          ),
          menu: menu,
          animation: true,
          color: Colors.white,
          onMenuItemSelected: (String itemId) {
            selectedMenuItemId = itemId;
            if (itemId == 'pending_items') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => PendingItem(_user)));
            }

            if (itemId == 'verified_items') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VerifiedItem(_user)));
            }
          },
          footerView: Container(
            padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Row(
              children: <Widget>[
             
                SizedBox(
                  width: 10.0,
                ),
                InkWell(
                    onTap: () {
                      if (_user != null) {
                        FirebaseAuth.instance.signOut().then((onValue) {
                          Navigator.of(context)
                              .pushReplacementNamed('/loginuser');
                        });
                      }
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    )),
              ],
            ),
          ),
        ),
        contentView: Screen(
            color: Color.fromRGBO(247, 202, 21, 1.0),
            contentBuilder: (context) {
              return ModalProgressHUD(
                  inAsyncCall: _loaderState,
                  progressIndicator: CircularProgressIndicator(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                ),
                                Center(
                                  child: Text(
                                    "View Legit Checks",
                                    style: TextStyle(
                                        fontFamily: 'SanBold', fontSize: 25.0),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                ),
                                SizedBox(
                                  height: 50.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.black),
                                    child: InkWell(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                'In Review',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 25.0,
                                                    fontFamily: 'SanBold',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        if (_user != null) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PendingItem(_user)));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                SizedBox(
                                  height: 50.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        color: Colors.black),
                                    child: InkWell(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              'Verified Items',
                                              style: TextStyle(
                                                  fontSize: 25.0,
                                                  fontFamily: 'SanBold',
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                      onTap: () {
                                        if (_user != null) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          VerifiedItem(_user)));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }));
  }
}
