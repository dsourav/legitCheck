import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:legit_check/staff/itemdetail/chattingStaff.dart';
import 'package:legit_check/staff/itemdetail/deleteDialouge.dart';
import 'package:shimmer/shimmer.dart';

class PendingItemDetail extends StatefulWidget {
  final data;
  final user;
  PendingItemDetail(this.data, this.user);
  @override
  _PendingItemDetailState createState() => _PendingItemDetailState();
}

class _PendingItemDetailState extends State<PendingItemDetail> {
  var images;

  @override
  void initState() {
    images = List.from(widget.data['image_url']);
   

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
        title:
            Text("Pending item detail", style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.black),
            onPressed: () {
              showDialog(
                                            context: context,
                                            builder: (_) => DeleteDialouge(widget.data),
                                            barrierDismissible: false);
            },
          )
        ],
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
                        "Email: " + widget.data['customer_email'] ?? "",
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
                            fontFamily: 'SanBold'),
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
                            fontSize: 20.0,
                            color: Colors.black,
                            fontFamily: 'SanBold'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                      ),
                      SizedBox(
                        height: 25.0,
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CahttingStaff(widget.data, widget.user,
                                          'pendingCheck')));
                            },
                            child: Text(
                              "View Chat",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'SanBold'),
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
}
