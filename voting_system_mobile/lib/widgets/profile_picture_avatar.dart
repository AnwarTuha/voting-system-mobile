import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String _imageUrl;
  FormData _imageData;
  File imageFile;

  // get image from gallery
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  // Get from camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  _pickImageAndUpload(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    String _imageUrl;

    return SizedBox(
      height: 115.0,
      width: 115.0,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: _imageUrl != null ? NetworkImage("$_imageUrl") : AssetImage("assets/images/temp_profile.jpg"),
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
                onPressed: () {
                  _pickImageAndUpload(context);
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
