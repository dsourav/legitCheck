import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class VerfyDialouge extends StatefulWidget {
  final data;
  VerfyDialouge(this.data);
  @override
  _VerfyDialougeState createState() => _VerfyDialougeState();
}

class _VerfyDialougeState extends State<VerfyDialouge> {
  bool _loaderState = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ModalProgressHUD(
        inAsyncCall: _loaderState,
        child: SimpleDialog(
          children: <Widget>[
            Center(
                child: Text(
              "Add this item as verified",
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'SanRegular',
              ),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontFamily: 'SanRegular',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  width: 15.0,
                ),
                FlatButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontFamily: 'SanRegular',
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _loaderState = true;
                    });

                    Firestore.instance.collection('verifiedCheck').add({
                      'customer_name': widget.data['customer_name'] ?? "",
                      'customer_email': widget.data['customer_email'] ?? "",
                      'item_name': widget.data['item_name'] ?? "",
                      'item_year': widget.data['item_year'] ?? "",
                      'item_brand': widget.data['item_brand'] ?? "",
                      'image_url': widget.data['image_url'] ?? "",
                      'tag': null,
                      'status': 'verified' ?? ""
                    }).then((result) {
                      if (result != null) {
                        //        Firestore.instance.runTransaction((transaction) async {
                        //   DocumentSnapshot snapshot = await transaction.get(widget.data.reference);
                        //   await transaction
                        //       .delete(snapshot.reference)
                        //       .whenComplete(() {
                        //          setState(() {
                        //         _loaderState=false;
                        //       });
                        //     Navigator.of(context).pop();
                        //   });
                        // });

                        Firestore.instance
                            .collection('pendingCheck')
                            .document(widget.data.documentID)
                            .collection('messages')
                            .getDocuments()
                            .then((docs) {
                          for (DocumentSnapshot ds in docs.documents) {
                            ds.reference.delete();
                          }
                        }).then((_) {
                          Firestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot snapshot =
                                await transaction.get(widget.data.reference);
                            await transaction
                                .delete(snapshot.reference)
                                .whenComplete(() {
                              setState(() {
                                _loaderState = false;
                              });
                              Navigator.of(context).pop();
                            });
                          });
                        });
                      } else {
                        setState(() {
                          _loaderState = false;
                        });
                      }
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
