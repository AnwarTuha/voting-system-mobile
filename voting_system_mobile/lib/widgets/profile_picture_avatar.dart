import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)
                    ),
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: Colors.white)
                ),
                onPressed: (){},
                child: Icon(Icons.camera_alt_outlined, size: 20.0, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}