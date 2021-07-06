import 'dart:io';

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
  @override
  Widget build(BuildContext context) {
    File _imageFile;
    final _picker = ImagePicker();

    _imgFromCamera() async {
      PickedFile image = await _picker.getImage(
        source: ImageSource.camera,
      );
      return File(image.path);
    }

    _imgFromGallery() async {
      PickedFile image = await _picker.getImage(
        source: ImageSource.camera,
      );
      return File(image.path);
    }

    void _showPicker(context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: Text("Gallery"),
                    onTap: () {
                      var img = _imgFromGallery();
                      Navigator.of(context).pop(img);
                    },
                  ),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: Text("Camera"),
                    onTap: () {
                      var img = _imgFromCamera();
                      Navigator.of(context).pop(img);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ).then((value) => _imageFile = value);
    }

    Future _uploadImageToFirebase(){
      String fileName = _imageFile.path;
      StorageReference
    }
  }

    Future pickImageAndUpload() async {
      // show image picker
      _showPicker(context);

      // upload image to firebase
      await _uploadImageToFirebase(context);
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
                onPressed: () {
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
