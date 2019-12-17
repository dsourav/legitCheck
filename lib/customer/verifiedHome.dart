import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/customer/submitLegitCheck.dart';
import 'package:shimmer/shimmer.dart';

import 'itemdetail/verifiedItem.dart';

class VerifiedHome extends StatefulWidget {
  final data;
  VerifiedHome(this.data);
  @override
  _VerifiedHomeState createState() => _VerifiedHomeState();
}

class _VerifiedHomeState extends State<VerifiedHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
         backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
        title: Text("Verified item list",style: TextStyle(color: Colors.black)),
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
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('verifiedCheck')
                      .where('customer_email', isEqualTo: widget.data.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return LinearProgressIndicator();

                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data.documents[index];
                         List<String> images = List.from(data['image_url']);

                       return Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: InkWell(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              color: Color.fromRGBO(247, 202, 21, 1.0),
                              child: Container(
                                height: 120.0,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: images.isNotEmpty?ClipRRect(
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
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "Name: " + data['item_name'] ?? "",
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontFamily: 'SanRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              softWrap: true,
                                            ),

                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "Brand: " + data['item_brand'] ?? "",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'SanRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              "Year: " + data['item_year'] ?? "",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'SanRegular'),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: true,
                                            ),
                                            // SizedBox(height: 10.0,),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10.0, top: 5.0),
                                      child: Align(
                                          alignment: FractionalOffset.topRight,
                                         

                                          child: _getIconWithstatus(data['tag']),
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    VerifiedItemCustomer(data)));
                          },
                          ),
                        );
                      },
                    );
                  }),
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

  _getIconWithstatus(tag) {
    if (tag == null) {
      return InkWell(
        child: Image.asset(
          'assets/pending.png',
          scale: 1.9,
        ),
        onTap: () {},
      );
    }
   else if (tag == 'Fake') {
      return InkWell(
        child: Image.asset(
          'assets/fake.png',
          scale: 1.9,
        ),
        onTap: () {},
      );
    }
  else  if (tag == 'Legit') {
      return InkWell(
        child: Image.asset(
          'assets/verified.png',
          scale: 1.9,
        ),
        onTap: () {},
      );
    }
    else return Container();
    
  }
}



