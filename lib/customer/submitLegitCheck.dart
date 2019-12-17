import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legit_check/customer/termsCondition.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
class SubmitLegitCheck extends StatefulWidget {
  @override
  _SubmitLegitCheckState createState() => _SubmitLegitCheckState();
}

class _SubmitLegitCheckState extends State<SubmitLegitCheck> {
  final TextEditingController _controllerItemName = new TextEditingController();
  final TextEditingController _controllerItemYear = new TextEditingController();
  final TextEditingController _controllerItemBrand=
      new TextEditingController();
  File _file;
  bool termsAccept = false;
  bool _loaderState=false;
  String _error = 'No Error Dectected';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
   FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
 List<Asset> images = List<Asset>();
  @override
  void initState() {
    getUser();
    super.initState();
  }

   getUser() {
    _auth.currentUser().then((onValue) {
      setState(() {
        _user = onValue;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return 
     
        Scaffold(
           backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 202, 21, 1.0),
            title: Text("Submit for Authentication",style: TextStyle(color: Colors.black)),
          ),
          body: ModalProgressHUD(
            inAsyncCall: _loaderState,
                      child: Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),

                      Center(child: Icon(Icons.add,color: Colors.black,size: 45.0,),),
                        SizedBox(
                        height: 5.0,
                      ),
                      Center(child: Text(
                        'Submit for Authentication',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'SanBold',fontSize: 30.0),),),
                      SizedBox(height: 30.0,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 40.0,
                          child: TextFormField(
                           controller: _controllerItemBrand,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 17.0),
                            decoration: new InputDecoration(
                              suffixIcon: Container(
                                  padding:
                                      EdgeInsets.only( right: 5.0),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 30.0,
                                  )),
                              hintText: "Choose Brand",
                              contentPadding: EdgeInsets.only(
                                top: 15.0,left: 10.0
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SanRegular',
                                  ),
                              fillColor: Colors.black26,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                              //fillColor: Colors.green
                            ),
                         
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Container(
                          height: 40.0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child:  SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 40.0,
                          child: TextFormField(
                            controller: _controllerItemName,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 17.0),
                            decoration: new InputDecoration(
                              
                              hintText: "Product Name",
                              contentPadding: EdgeInsets.only(
                                top: 15.0,left: 10.0
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SanRegular',
                                  ),
                              fillColor: Colors.black26,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                              //fillColor: Colors.green
                            ),
                         
                          ),
                        ),
                              ),
                              SizedBox(width: 20.0,),

                               Expanded(
                                flex: 1,
                                child:  SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 40.0,
                          child: TextFormField(
                           controller: _controllerItemYear,
                           keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'SanRegular',
                                fontSize: 17.0),
                            decoration: new InputDecoration(
                              
                              suffixIcon: Container(
                                  padding:
                                      EdgeInsets.only( right: 5.0),
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                    size: 30.0,
                                  )),
                              
                              hintText: "Year",
                              contentPadding: EdgeInsets.only(
                                top: 15.0,left: 10.0
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SanRegular',
                                  ),
                              fillColor: Colors.black26,
                              filled: true,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                              //fillColor: Colors.green
                            ),
                         
                          ),
                        ),
                              )
                            ],
                          ) ,
                        ),

                        SizedBox(height: 20.0,),

                        Container(
                          
                          width:  MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                
                                child: Container(
                          height: 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                           color: Colors.black26
                            ),
                        child: GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: _file != null && _file.path.isNotEmpty
                                ? Image.file(
                                    _file,
                                    fit: BoxFit.fill,
                                  )
                                : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    
                                    Icon(
                                    Icons.add,
                                    color: Colors.white,
                                   
                                  ),
                                  Text('Add Photos',style: TextStyle(color: Colors.white,fontSize: 12.0,
                                  fontFamily: 'SanRegular'
                                  
                                  ),),
                                  ],
                                ),
                          ),
                          // onTap: ()  {
                          //   // var image = await ImagePicker.pickImage(
                          //   //     source: ImageSource.gallery);

                          //   // setState(() {
                          //   //   _file = image;
                          //   // });
                          

                          //   loadAssets();
                          // },
                          onTap: loadAssets,



                        ),
                      ),
                              ),
                              SizedBox(width: 10.0,),
                              // Expanded(
                              //   flex: 4,
                              //   child: Text("Please remember to add a high resolution image to start the process with our LC Team, we take authentication very seriously. All photos must have a tag or id to confirm they are all from the same item.",
                              //   textAlign: TextAlign.justify,
                              //   style: TextStyle(fontFamily: 'SanRegular'),),
                              // )

                               Expanded(
                        child: Container(height: 100.0, child: buildGridView()))

                            ],
                          ),

                        ),

                        SizedBox(height: 60.0,),

                        Theme(
                        child: CheckboxListTile(
                          
                          title: RichText(
                              text: TextSpan(
                                text:"I accept the\t",
                                style: TextStyle(color: Colors.black,fontFamily: 'SanRegular'),
                                children: [
                    
                                  TextSpan(
                                    text: "Terms and Conditions",
                                    recognizer: TapGestureRecognizer()..onTap = () {Navigator.of(context).
                                    push(MaterialPageRoute(builder: (BuildContext context)=>TermsConditions()));},
                                     style: TextStyle(color: Colors.black,fontFamily: 'SanRegular',
                                     fontWeight: FontWeight.bold),
                                  )
                                ]
                              ),
                            ),
                          value: termsAccept,
                          onChanged: (newValue) {
                            setState(() {
                              termsAccept = newValue;
                            });
                          },
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                        data: ThemeData(unselectedWidgetColor: Colors.black),
                      ),

                      Container(
                         height: 56.0,  
                         width: MediaQuery.of(context).size.width*0.8,
                        child: RaisedButton(
                          color: Colors.black12,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                         child: Padding(
                                                              padding: EdgeInsets.only(left: 10.0),
                                                                                                                       
                           child: Text('Proceed and Pay',
                          style: TextStyle(color: Colors.white,fontFamily: 'SanBold',
                          fontSize: 28.0)
                          ),
                                                            ),
                          onPressed: _user==null?null:() {

                              if(_controllerItemName.text.length>0&&
                              _controllerItemBrand.text.length>0&&
                              _controllerItemYear.text.length>0&&
                              termsAccept==true&&images!=null&&_user!=null
                              ){
                                setState(() {
                                  _loaderState=true;
                                });



                                 Firestore.instance.collection('user').document(_user.email).get().then((userData){
                                  if(userData!=null){

                                    uploadImages(assets: images,email: _user.email).then((imageUrl){
                                      if(imageUrl!=null){

                                           Firestore.instance.collection('pendingCheck').add({
                                     
                                      'customer_name':userData.data['customer_name']??"",
                                      'customer_email':userData.data['customer_email']??"",
                                      'item_name':_controllerItemName.text,
                                      'item_year':_controllerItemYear.text,
                                      'item_brand':_controllerItemBrand.text,
                                      'image_url':imageUrl,
                                      'user_id':_user.uid,
                                      'status':'pending'


                                }).then((onValue){
                                 
                                  showSnackbar('Request Submitted');
                                  Navigator.of(context).pop();
                                



                                });

                                      }

                                      else{
                                        showSnackbar('image upload failed');
                                      }

                                    });
                                
                                 

                                  }else{
                                    showSnackbar('no user found try again');

                                  }

                                });
        
                              }
                              else{
                                showSnackbar('Enter correct value to input field');
                              }

                          },
                          
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
     
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "pic"),
        materialOptions: MaterialOptions(
          actionBarColor: "#f7ca15",
          allViewTitle: "All Photos",
          useDetailsView: false,
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }


    Widget buildGridView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          child: Card(
            elevation: 3.0,
            child: Stack(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    AssetThumb(
                      asset: asset,
                      width: 100,
                      height: 100,
                    ),
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey.withOpacity(0.3),
                    )
                  ],
                  
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 3.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        setState(() {
                          images.remove(asset);
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
  _launchURL() async {
  const url = 'https://www.paylor.me/authenticonly/products/bc0cbc62';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


  Future<List<String>> uploadImages(
      {@required List<Asset> assets,@required email}) async {
    List<String> uploadUrls = [];

    await Future.wait(
        assets.map((Asset asset) async {
          ByteData byteData = await asset.getByteData();
          List<int> imageData = byteData.buffer.asUint8List();

          StorageReference reference = FirebaseStorage.instance.ref().child(email).child(
              asset.name + DateTime.now().millisecondsSinceEpoch.toString());
          // .child(id.toString())
          // .child(asset.name);
          StorageUploadTask uploadTask = reference.putData(imageData);
          StorageTaskSnapshot storageTaskSnapshot;

          // Release the image data

          StorageTaskSnapshot snapshot = await uploadTask.onComplete;
          if (snapshot.error == null) {
            storageTaskSnapshot = snapshot;
            final String downloadUrl =
                await storageTaskSnapshot.ref.getDownloadURL();
            uploadUrls.add(downloadUrl);

            // print('Upload success');
          } else {
            //print('Error from image repo ${snapshot.error.toString()}');
            throw ('This file is not an image');
          }
        }),
        eagerError: true,
        cleanUp: (_) {
          print('eager cleaned up');
        });

    return uploadUrls;
  }


  //  Future<String> uploadImage() async {
  //   String fileName = p.basename(_file.path);
  //   StorageReference ref = FirebaseStorage.instance
  //       .ref().child(_user.email)
  //       .child(fileName + DateTime.now().millisecondsSinceEpoch.toString());
  //   StorageUploadTask _uploadTask = ref.putFile(_file);
  //   var downUrl = await (await _uploadTask.onComplete).ref.getDownloadURL();
  //   return downUrl.toString();
  // }

  


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
