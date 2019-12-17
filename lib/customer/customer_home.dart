import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/menu_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/customer/legitCheckProgress.dart';
import 'package:legit_check/customer/submitLegitCheck.dart';
import 'package:legit_check/customer/verifiedHome.dart';
import 'package:legit_check/pushNotification/notificationFucntion.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
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
        
        id: 'pending_items',
        icon: Icons.remove_red_eye,
        title: 'Pending items',
      ),
     
      new MenuItem(
        id: 'verified_items',
        icon: Icons.remove_red_eye,
        title: 'Verified items',
      ),
     
    ],
  );

  var selectedMenuItemId = 'pending_items';
 

  Widget headerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
             
              Container(
                  margin: EdgeInsets.only(left: 16,top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Text(
                      //   _user.displayName??"N/A",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontFamily: 'SanBold',
                      //     fontSize: 20.0

                      //   )
                      // ),

                      _getUSerName(_user.email),
                      Text(
                        _user.email??"N/A",
                        style:  TextStyle(
                          color: Colors.black,
                          fontFamily: 'SanRegular',
                          fontSize: 17.0

                        )
                      )
                    ],
                  ))
            ],
          ),
        ),
       
      ],
    );
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      child: _user!=null?DrawerScaffold(
        
        percentage: 0.8,
        cornerRadius: 25.0,
        appBar: AppBarProps(
          backgroundColor:Color.fromRGBO(247, 202, 21, 1.0),
            title: Text("",style: TextStyle(color: Colors.black),),
            iconTheme: IconThemeData(color: Colors.black87)
           
            ),

        
        menuView: new MenuView(
           textStyle: TextStyle(fontSize: 20.0,color: Colors.black,
          fontFamily: 'SanBold',),
          menu: menu,
          headerView: headerView(context),
          animation: true,
         
         color: Colors.white,
         
          onMenuItemSelected: (String itemId) {
            selectedMenuItemId = itemId;
            if (itemId == 'pending_items') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context)=>LegitCheckProgress(_user)

              ));
            } 

            if (itemId == 'verified_items') {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context)=>VerifiedHome(_user)

              ));
            } 
          },
          footerView: Container(
            padding: EdgeInsets.only(left: 20.0,bottom: 20.0),
            child: Row(
              children: <Widget>[
                // Icon(Icons.settings,color: Colors.black,),
                // SizedBox(width: 10.0,),
                // // Text('Settings',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                // // SizedBox(width: 10.0,),
                // Container(height: 18.0,
                // width: 2.0,
                // color: Colors.black,),
                 SizedBox(width: 10.0,),
                 InkWell(
                   onTap: (){
                     if (_user != null) {
                                       FirebaseAuth.instance.signOut().then((onValue) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/loginuser');
                                });
//                              
                                      }
                   },
                   child: Text('Log out',style: TextStyle(color: Colors.black,fontSize: 20.0),)),
              ],
            ),          ),
        ),
        contentView: Screen(
          contentBuilder: (context) {
               return ModalProgressHUD(
          inAsyncCall: _loaderState,
          progressIndicator: CircularProgressIndicator(),
          child: 
                 Container(
                    child: Column(
                        children: <Widget>[
                          Expanded(
                            child: SingleChildScrollView(
                                                          child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height:
                  MediaQuery.of(context).size.height * 0.07,
                                  ),
                                  Text(
                                    "Your Legit Checks",
                                    style: TextStyle(
                  fontFamily: 'SanBold', fontSize: 25.0),
                                  ),
                                  SizedBox(
                                    height:
                  MediaQuery.of(context).size.height * 0.2,
                                  ),
                                  SizedBox(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Container(
                                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.black),
                                      child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      Expanded(
                                                                  child: Container(
                          padding: EdgeInsets.only(left: 15.0),
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
                                                  builder: (BuildContext
                                                          context) =>
                                                      LegitCheckProgress(_user)));
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
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Container(
                                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.black),
                                      child: InkWell(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
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
                                                  builder: (BuildContext
                                                          context) =>
                                                    VerifiedHome(_user)
                                                      
                                                      ));
                                        }
                   
                  },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Container(
                  height: 70.0,
                  
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight:   Radius.circular(15.0),
                    )
                  ),
                  child: InkWell(
                    onTap: (){
                       Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                    SubmitLegitCheck()
                                                      
                                                      ));

                    },
                                      child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.add,color: Colors.black,size: 35.0,),
                        ),
                        Expanded(
                                                child: Container(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text('New Legit Check',
                            style: TextStyle(color: Colors.black,fontFamily: 'SanBold',
                            fontSize: 23.0),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
                        ],
                      ),
                  )
                  
           
          
          );

          },
          color: Color.fromRGBO(247, 202, 21, 1.0),
        ),

      
      ):
      Center(
        child: CircularProgressIndicator(),
      ),
    );
  }


  _getUSerName(userEmail){
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance.collection('user').document(userEmail).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData)return Text('N/A');
        return Text(snapshot.data['customer_name']??"N/A",
        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SanBold',
                          fontSize: 20.0

                        ));

      },
    );
  }
}




  