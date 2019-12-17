import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PutTagDialouge extends StatefulWidget {
  final data;
  PutTagDialouge(this.data);
  @override
  _PutTagDialougeState createState() => _PutTagDialougeState();
}

class _PutTagDialougeState extends State<PutTagDialouge> {
  bool _loaderState = false;
  String _tag;
  @override
  Widget build(BuildContext context) {
    return Container(
     
        child: ModalProgressHUD(
            inAsyncCall: _loaderState,
            child: SimpleDialog(
             
              children: <Widget>[
              
              Center(
                  child: Text(
                "LC Options",
                style: TextStyle(fontSize: 25.0, 
                fontFamily: 'SanRegular',
                ),
              )),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: RadioButtonGroup(
                  labelStyle: TextStyle(fontFamily: 'SanRegular',
                  fontSize: 20.0),
                    labels: <String>[
                      "Fake",
                      "Legit",
                    ],
                    onSelected: (String selected) {
                      setState(() {
                        _tag=selected;
                      });
                    }),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: RaisedButton(
                  color:Color.fromRGBO(247, 202, 21, 1.0),
                  child: Text(
                    "Sumbit",
                    style: TextStyle(color: Colors.black,fontFamily: 'SanBold'),
                  ),
                  onPressed: () {
                    if (_tag != null) {
                      setState(() {
                        _loaderState=true;
                      });

                      Firestore.instance.collection('verifiedCheck').
                      document(widget.data.documentID).updateData({
                        'tag':_tag
                      }).then((result){
                       setState(() {
                         _loaderState=false;
                       });
                       Navigator.of(context).pop();

                      });

                    }
                  },
                ),
              )
            ])));
  }

}
