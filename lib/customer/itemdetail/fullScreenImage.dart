import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:photo_view/photo_view.dart';
class FullScreenImage extends StatefulWidget {

    FullScreenImage({
    this.backgroundDecoration,
    this.imageProvider,
    this.loadingChild,
    this.maxScale,
    this.minScale,
    this.docRef,
    this.imageUrl

  });


  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final DocumentReference docRef;
  final String imageUrl;
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool _loaderState=false;

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      backgroundColor: Colors.transparent,
      body: ModalProgressHUD(
        inAsyncCall: _loaderState,
              child: Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Stack(children: [
               
                PhotoView(
          imageProvider: widget.imageProvider,
          loadingChild: widget.loadingChild,
          backgroundDecoration: BoxDecoration(color: Colors.black),
          minScale: PhotoViewComputedScale.contained,
          maxScale: widget.maxScale,
          heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
         
        ),
     

                 Container(
           padding: EdgeInsets.only(top: 50.0,right: 10.0),
           child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.white,),
                onPressed: (){
                  setState(() {
                    _loaderState=true;
                  });
                    String storageUrl = widget.imageUrl.toString();
  Firestore.instance.runTransaction((transaction) async {
                      DocumentSnapshot snapshot =
                          await transaction.get(widget.docRef);
                      await transaction
                          .delete(snapshot.reference)
                          .whenComplete(() {
                        //  var doc=Firestore.instance.collection(Global.userEmail).document('group_member').
                        //  collection('member').where('kid_name',isEqualTo: documnent['name']);

                        FirebaseStorage.instance
                            .getReferenceFromUrl(storageUrl);
                        Future<StorageReference> _reference = FirebaseStorage
                            .instance
                            .getReferenceFromUrl(storageUrl);
                        _reference.then((onValue) {
                          onValue.delete();
                          setState(() {
                            _loaderState = false;
                          });
                          Navigator.of(context).pop();
                        });
                       
                      });
                    });
                  
                  
                },
              ),
                ),
         ),
              ]),
          ),
      ),
    );
  }
}