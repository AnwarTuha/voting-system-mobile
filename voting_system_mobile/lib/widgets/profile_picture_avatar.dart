import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatelessWidget {

  ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    File _imageFile;
    final picker = ImagePicker();

    Future pickImageAndUpload() async{
      //final pickedFile = await picker.getImage(source: ImageSource.camera)
      _showPicker();
    }

    File _showPicker(context){
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return SafeArea(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                      leading: new Icon(Icons.photo_library),
                      tit
                    ),
                  ],
                ),
              ),
          );
        },
      );
    }

    return SizedBox(
      height: 115.0,
      width: 115.0,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/temp_profile.jpg"),
          ),
          Positioned(
            bottom: 0.0,
            right: -10.0,
            child: SizedBox(
              height: 46.0,
              width: 46.0,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF5F6F9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: Colors.white)),
                onPressed: (){
                  pickImageAndUpload();
                },
                child: Icon(Icons.camera_alt_outlined, size: 20.0, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
