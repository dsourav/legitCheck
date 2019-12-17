import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legit_check/customer/itemdetail/fullScreenImage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CahttingStaff extends StatefulWidget {
  final data;
  final user;
  final chatType;

  CahttingStaff(this.data, this.user,this.chatType);
  @override
  _CahttingStaffState createState() => _CahttingStaffState();
}

class _CahttingStaffState extends State<CahttingStaff> {
  final TextEditingController _contrillerMessage = new TextEditingController();
  final Firestore _firestore = Firestore.instance;
  final ScrollController _controller = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loaderState =false;
  String staffName;
  File imageFile;
  String imageUrl='';

  @override
  void initState() {
    getStaffname();

    super.initState();
  }

  getStaffname() {
    Firestore.instance
        .collection('user')
        .document(widget.user.email)
        .get()
        .then((data) {
       
         setState(() {
           staffName= data['user_email'];
         });
      
     
    });
   // print(staffName);
  }

  @override
  Widget build(BuildContext context) {
   
    return 
     
      Scaffold(
        key: _scaffoldKey,
       
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
          title: Text("Chat ",style: TextStyle(color: Colors.black),),
        ),
        body: staffName!=null?SafeArea(
          child: ModalProgressHUD(
             inAsyncCall: _loaderState,
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection(widget.chatType)
                          .document(widget.data.documentID)
                          .collection('messages').orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return LinearProgressIndicator();

                        List<DocumentSnapshot> docs = snapshot.data.documents;
                        List<Widget> messages = docs
                            .map((doc) => Message(
                                  from: doc.data['from'],
                                  text: doc.data['text'],
                                  me: staffName ==
                                      doc.data['from'],
                                         docType: doc.data['doctype'],
                                  documentReference: doc.reference,
                                ))
                            .toList();
                        return ListView(
                          reverse: true,
                          controller: _controller,
                          children: messages,
                        );
                      }),
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _contrillerMessage,
                          style: TextStyle(color: Colors.black,fontFamily: 'SanRegular'),
                          decoration: InputDecoration(
                            hintText: 'Enter message here',
                            hintStyle: TextStyle(color: Colors.black,fontFamily: 'SanRegular'),
                          ),
                        ),
                      ),

                       IconButton(
                      icon: Icon(Icons.image),
                      onPressed: (){
                        getImage();

                      },
                    ),
                    IconButton(
                      
                   
                      icon: Icon(Icons.send),
                      onPressed: () {
                       
                        _sendMessage(_contrillerMessage.text, 2);//text doctype 2
                      },
                    )
                      // RaisedButton(
                      //   color: Color.fromRGBO(247, 202, 21, 1.0),
                      //   child: Text(
                      //     "Send",
                      //     style: TextStyle(color: Colors.black,fontFamily: 'SanRegular'),
                      //   ),
                      //   onPressed: () {
                      //     if (_contrillerMessage.text.length > 0) {
                      //       _firestore
                      //           .collection(widget.chatType)
                      //           .document(widget.data.documentID)
                      //           .collection('messages')
                      //           .add({
                      //         'text': _contrillerMessage.text,
                      //         'from': staffName,
                      //         'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
                      //       });
                      //       _contrillerMessage.clear();
                      //       _controller.animateTo(
                      //           _controller.position.maxScrollExtent,
                      //           curve: Curves.easeOut,
                      //           duration: const Duration(milliseconds: 300));
                      //     }
                      //   },
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ):Center(
          child: CircularProgressIndicator(),
        )
      );
  
  }


      Future getImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        _loaderState = true;
      });
      uploadFile();
    }
  }
  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        _loaderState = false;
        _sendMessage(imageUrl, 1);//image doctype 1
      });
    }, onError: (err) {
      showSnackbar('this file is not an image');
    });
  }


  _sendMessage(String content,docType){
    if(content.trim()!=''){

      _firestore
                            .collection(widget.chatType)
                            .document(widget.data.documentID)
                            .collection('messages')
                            .add({
                          'doctype':docType,
                          'text': content,
                          'from': staffName,
                          'customer_email':widget.data['customer_email'],
                          'timestamp':
                              DateTime.now().millisecondsSinceEpoch.toString(),
                        });
      _contrillerMessage.clear();
      _controller.animateTo(
                            _controller.position.maxScrollExtent,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300));

     

       
    }
    else{
      showSnackbar('nothing to send');
    }


  }


   void showSnackbar(String message) {
    setState(() {
      _loaderState = false;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }
}


class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;
    final int docType;
  final DocumentReference documentReference;
  Message({this.from, this.text, this.me,this.docType,this.documentReference});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
         Container(
            padding: EdgeInsets.all(5.0),
           child: docType==2 ?Material(
                color: me ? Colors.teal : Color.fromRGBO(247, 202, 21, 1.0),
                borderRadius: BorderRadius.circular(10.0),
                elevation: 6.0,
                child: Column(
                  children: <Widget>[
                    //  Text(from,style: TextStyle(color: Colors.white),),
                    // SizedBox(height: 5.0,),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )
                ):
                
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: FlatButton(
                    child: Material(
                      child: CachedNetworkImage(
                         placeholder: (context, url) => Container(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                                ),
                            width: 200.0,
                                height: 200.0,
                                padding: EdgeInsets.all(70.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                    
                                  ),
                                  
                                 
                                ),
                            
                          
                        
                      ),
                      errorWidget: (context, url, error) => Material(
                                child: Icon(Icons.broken_image),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                clipBehavior: Clip.hardEdge,
                              ),
                                imageUrl: text,
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,

                    ),
                  ), onPressed: () {
                
                   if(text!=null&&text.length>0){
                     Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  FullScreenImage(
                        imageProvider: NetworkImage(text),
                        docRef: documentReference,
                        imageUrl:text,
                      ),
                    ));
                   }
                 
                

                  },
                )
                ),
         )
        ],
    
    )
    );
  }
}
