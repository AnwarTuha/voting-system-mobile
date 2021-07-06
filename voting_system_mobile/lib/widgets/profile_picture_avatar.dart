import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:voting_system_mobile/providers/user_provider.dart';
import 'package:voting_system_mobile/utils/app_url.dart';

class ProfilePic extends StatefulWidget {
  ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  pickImageAndUpload(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context).user;
    final FirebaseStorage _storage = FirebaseStorage.instance;
    final ImagePicker _imagePicker = ImagePicker();
    PickedFile _image;

    // await permission from user to get photo from gallery
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // select image
      _image = await _imagePicker.getImage(
        source: ImageSource.gallery,
      );
      File _imageFile = File(_image.path);

      if (_image != null) {
        var snapShot = await _storage
            .ref("${AppUrl.firebaseReferenceUrl}")
            .child("Voter${userProvider.userId}")
            .putFile(_imageFile);
      }
    }
  }

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
                onPressed: () {
                  pickImageAndUpload(context);
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
