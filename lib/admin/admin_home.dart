import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drawerbehavior/drawer_scaffold.dart';
import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/admin/admin_create_stuff.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  bool _loaderState = false;
   final menu = new Menu(
    items: [
      new MenuItem(
        
        id: 'pending_items',
       
        title: '',
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
          backgroundColor:Color.fromRGBO(247, 202, 21, 1.0),
            title: Text("",style: TextStyle(color: Colors.black),),
            iconTheme: IconThemeData(color: Colors.black87)
           
            ),

      
      menuView: MenuView(
         menu: menu,
        color:   Color.fromRGBO(247, 202, 21, 1.0),
        footerView: Container(
            padding: EdgeInsets.only(left: 20.0,bottom: 20.0),
            child: Row(
              children: <Widget>[
                // Icon(Icons.settings,color: Colors.black,),
                // SizedBox(width: 10.0,),
                // Text('Settings',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                // SizedBox(width: 10.0,),
                // Container(height: 18.0,
                // width: 2.0,
                // color: Colors.black,),
                 SizedBox(width: 10.0,),
                 InkWell(
                   onTap: (){
                     FirebaseAuth.instance.signOut().then((onValue) {
                            Navigator.of(context)
                                .pushReplacementNamed('/loginuser');
                          });
                   },
                   child: Text('Log out',style: TextStyle(color: Colors.black,fontSize: 20.0),)),
              ],
            ),          ),
      ),

       contentView:Screen(
         contentBuilder: (context){
           return ModalProgressHUD(
      inAsyncCall: _loaderState,
      progressIndicator: CircularProgressIndicator(),
      child: 
       
        Scaffold(
         
         
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AdminStuffCreate()));
            },
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('user')
                  .where('role', isEqualTo: 'staff')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data.documents[index];

                    return Card(
                     shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              color: Color.fromRGBO(247, 202, 21, 1.0),

                      child: ListTile(
                        title: Text(data['user_name'] ?? "",style: TextStyle(fontFamily: 'SanBold'),),
                        subtitle: Text(data['user_email'] ?? "",style: TextStyle(fontFamily: 'SanRegular'),),
                        onTap: () {},
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
     
    );
         }
       )
      

    );
  }



}









