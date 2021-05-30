import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:voting_system_mobile/utils/color_palette_util.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsynchCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD(
      {Key key,
      @required this.child,
      @required this.inAsynchCall,
      this.opacity = 0.3,
      this.color = Colors.grey,
      this.valueColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);

    // check to see if there is an async call then load modal
    if (inAsynchCall) {
      final modal = new Stack(
          children: <Widget>[
            new Opacity(
              opacity: opacity,
              child: ModalBarrier(
                dismissible: false,
                color: color,
              ),
            ),
            new Center(
              child: SpinKitWave(size: 25.0, color: tealLightColor),
            )
          ],
        );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
