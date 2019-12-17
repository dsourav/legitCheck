import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/addMob.dart';
import 'package:legit_check/customer/submitLegitCheck.dart';
import 'package:shimmer/shimmer.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'itemdetail/pendingItem.dart';
class LegitCheckProgress extends StatefulWidget {
  final user;
  LegitCheckProgress(this.user);
  @override
  _LegitCheckProgressState createState() => _LegitCheckProgressState();
}

class _LegitCheckProgressState extends State<LegitCheckProgress> {
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

 InterstitialAd interstitialAd;
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',

  testDevices: <String>[], // Android emulators are considered test devices
);

  InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: getAdUnitId(),
        //adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.failedToLoad) {
            interstitialAd..load();
          } else if (event == MobileAdEvent.closed) {
            interstitialAd = buildInterstitial()..load();
          }
         // print(event);
        });
  }

     @override
  void initState() {
    super.initState();
    
//FirebaseAdMob.instance.initialize(appId:  FirebaseAdMob.testAppId);
    FirebaseAdMob.instance.initialize(appId: getAppId());

  buildInterstitial()..load()..show();
  }
 
  @override
  Widget build(BuildContext context) {
  
    return 
        Scaffold(

          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
            title: Text("Pending item list",style: TextStyle(color: Colors.black)),
          ),

          body: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),

                        Container(
                          child: Text("Your items",style: TextStyle(fontSize: 30.0,
                          fontFamily: 'SanBold'),),
                        ),
                        //SizedBox(height: 10.0,),
                        Icon(Icons.arrow_drop_down,color: Colors.black,size: 35.0,),

              Expanded(
                              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection('pendingCheck').where('customer_email',isEqualTo: widget.user.email).snapshots(),
                    builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();

                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data=snapshot.data.documents[index];
                        List<String> images = List.from(data['image_url']);
                        
                        return Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: InkWell(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0)
                                                ),
                                                 color: Color.fromRGBO(247, 202, 21, 1.0),
                              child: Container(
                                
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(25.0)
                                // ),
                                height: 120.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                     
                                      child:images.isNotEmpty?ClipRRect(
                                         borderRadius: new BorderRadius.circular(15.0),
                                       // child: Image.network(data['image_url']??"",fit: BoxFit.fill,)
                                       child: CachedNetworkImage(
                                          imageUrl: images[0],
                                          placeholder: (_, url) =>
                                              Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
    enabled: true,
    child: Container(
        height: double.infinity, width: double.infinity, color: Colors.white),
  ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),
                                        
                                        ):Container(),
                                    ),
                                    SizedBox(height: 10.0,),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10.0,),
                                            Text("Name: "+data['item_name']??"",style: TextStyle(fontSize: 17.0,
                                            fontFamily: 'SanRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines:2,
                                               softWrap: true,                     
                                              ),

                                            SizedBox(height: 10.0,),
                                            Text("Brand: "+data['item_brand']??"",
                                            style: TextStyle(fontSize: 16.0,
                                             fontFamily: 'SanRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines:1,
                                               softWrap: true,                     
                                              ),
                                            SizedBox(height: 10.0,),
                                            Text("Year: "+data['item_year']??"",
                                            style: TextStyle(fontSize: 16.0, fontFamily: 'SanRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines:1,
                                               softWrap: true,                     
                                              ),
                                            // SizedBox(height: 10.0,),
                                             
                                          ],
                                        ),
                                      ),
                                    ),
                                  
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0,top: 5.0),
                                      child: Align(
                                        alignment: FractionalOffset.topRight,
                                        child: Image.asset('assets/pending.png',scale:1.9,)),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            onTap: (){
                               Navigator.of(context).push(MaterialPageRoute(
                                                builder: (BuildContext context)=>PendingItemCustomer(data)
                                              ));

                            },
                          ),
                        );
                      },

                    );
                    
                    }
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0,right: 5.0),
                              child: Container(
                  height: 60.0,
                  
                  decoration: BoxDecoration(
                    color:Color.fromRGBO(247, 202, 21, 1.0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight:   Radius.circular(15.0),
                    )
                  ),
                  child: InkWell(
                    onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(
                       builder: (BuildContext context)=>SubmitLegitCheck()
                     ));
                                                      
                                                      
                    },
                                      child: Center(
                      child: Icon(Icons.add,color: Colors.black,size: 40.0,),
                    ),
                  ),
                ),
              )
            ],
          ),
          
          );
      
      
    
  }
}