import 'package:flutter/material.dart';

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
              child: new CircularProgressIndicator(),
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
