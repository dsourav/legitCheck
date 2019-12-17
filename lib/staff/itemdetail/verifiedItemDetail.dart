import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/staff/itemdetail/chattingStaff.dart';
import 'package:legit_check/staff/itemdetail/putTagDialouge.dart';
import 'package:shimmer/shimmer.dart';

class VerifiedItemDetail extends StatefulWidget {
  final data;
  final user;
  VerifiedItemDetail(this.data,this.user);
  @override
  _VerifiedItemDetailState createState() => _VerifiedItemDetailState();
}

class _VerifiedItemDetailState extends State<VerifiedItemDetail> {

     var images;

  @override
  void initState() {
    images = List.from(widget.data['image_url']);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return 
        
        Scaffold(
          
          appBar: AppBar(
             backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
            title: Text("Verified item detail",style: TextStyle(color: Colors.black)),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 15.0),
            child: SingleChildScrollView(
                child: widget.data != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 15.0,
                          ),
                           Center(
                        child: images != null
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45.0),
                                  //                           child: Image.network(
                                  //   widget.data['image_url'] ?? "",
                                  //   fit: BoxFit.fill,
                                  // ),

                                  // child: Image.network(data['image_url']??"",fit: BoxFit.fill,)
                                  child: Carousel(
                                    images: images
                                        .map((img) => CachedNetworkImage(
                                              imageUrl: img,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                                highlightColor:
                                                    Colors.grey[100],
                                                enabled: true,
                                                child: Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    color: Colors.white),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ))
                                        .toList(),
                                    dotColor: Colors.pink,
                                    dotSize: 8.0,
                                    dotBgColor: Colors.transparent,
                                  ),
                                ))
                            : Container(),
                      ),
                          SizedBox(
                            height: 15.0,
                          ),
                          _tagWork(),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                        "Customer Name: " + widget.data['customer_name'] ?? "",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'SanBold'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                          SizedBox(
                            height: 10.0,
                          ),
                         Text(
                        "Email: " + widget.data['customer_email'] ??
                            "",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'SanBold'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                          SizedBox(
                            height: 10.0,
                          ),
                         Text(
                        "Item Name: " + widget.data['item_name'] ?? "",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'SanBold'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                        "Brand: " + widget.data['item_brand'] ?? "",
                        style: TextStyle(
                         fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'SanBold'
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Year: " + widget.data['item_year'] ?? "",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            softWrap: true,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Center(
                            child: SizedBox(
                              height: 40.0,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: RaisedButton(
                                color: Color.fromRGBO(247, 202, 21, 1.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                onPressed: () {



                                Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    CahttingStaff(widget.data, widget.user, 'verifiedCheck')));
                                },
                                child: Text(
                                  "View Chat",
                                  style: TextStyle(
                                    fontFamily: 'SanBold',
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )),
          ),
        );
      
  }

  _tagWork() {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('verifiedCheck')
          .document(widget.data.documentID)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        var tag = snapshot.data.data['tag'];
        return tag == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Review Legit Check: ",
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                        fontFamily: 'SanBold'),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color:  Color.fromRGBO(247, 202, 21, 1.0),
                    ),
                    onPressed: () {
                      showDialog(context: context,
                      builder: (_)=>PutTagDialouge(widget.data),
                      barrierDismissible: false

                      );
                    },
                  )
                ],
              )
            : Text(
                "Tag: " + tag ?? "",
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontFamily: 'SanBold'),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: true,
              );
      },
    );
  }
}
