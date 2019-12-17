import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DeleteDialouge extends StatefulWidget {
  final data;
  DeleteDialouge(this.data);

  @override
  _DeleteDialougeState createState() => _DeleteDialougeState();
}

class _DeleteDialougeState extends State<DeleteDialouge> {
  bool _loaderState = false;
 var images;

  @override
  void initState() {
    images = List.from(widget.data['image_url']);

    print(widget.data.documentID);
   

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ModalProgressHUD(
        inAsyncCall: _loaderState,
        child: SimpleDialog(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: Text(
                "Are you sure you want delete this item",
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'SanRegular',
                ),
              )),
            ),
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

                    // Firestore.instance
                    //     .collection('pendingCheck')
                    //     .document(widget.data.documentID)
                    //     .collection('messages')
                    //     .getDocuments()
                    //     .then((docs) {
                    //       if(docs.documents.isNotEmpty){
                    //         for (DocumentSnapshot ds in docs.documents) {
                    //     ds.reference.delete();
                    //   }
                    //       }
                    //   // for (DocumentSnapshot ds in docs.documents) {
                    //   //   ds.reference.delete();
                    //   // }
                    // });
                    
                    
                      Firestore.instance.runTransaction((transaction) async {
                        DocumentSnapshot snapshot =
                            await transaction.get(widget.data.reference);
                        await transaction
                            .delete(snapshot.reference)
                            .whenComplete(() {
                              deletePendingItem(images);
                        
                            });
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

  deletePendingItem(imagesUrl) {
    Future.forEach(imagesUrl, (image)async{
       Future<StorageReference> _reference =
          FirebaseStorage.instance.getReferenceFromUrl(image);
      _reference.then((image) {
        image.delete();
      });

    }).then((_) {
      setState(() {
        _loaderState = false;
      });
      DefaultCacheManager manager = new DefaultCacheManager();
      manager.emptyCache();
      Navigator.of(context).pop();
       Navigator.of(context).pop();
    });
    
    
    //  Future.wait(imagesUrl.map((url)async {
    //   Future<StorageReference> _reference =
    //       FirebaseStorage.instance.getReferenceFromUrl(url);
    //   _reference.then((image) {
    //     image.delete();
    //   });
    // })).then((_) {
    //   setState(() {
    //     _loaderState = false;
    //   });
    //   Navigator.of(context).pop();
    // });

   
  }

  
}
