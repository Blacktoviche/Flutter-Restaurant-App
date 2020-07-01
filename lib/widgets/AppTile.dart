import 'package:ecommerce/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTile extends StatelessWidget {
  const AppTile({
    this.child,
    this.color,
    this.splashColor,
    this.onTap,
  });
  final Widget child;
  final Color color;
  final Color splashColor;
  final Function() onTap;

  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 60,
      margin: EdgeInsets.all(15.0),
      child: Material(
        color: color,
        elevation: 10.0,
        borderRadius: BorderRadius.circular(15.0),
        shadowColor: shadowColor(context),
        child: InkWell(
          child: child,
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(15.0),
          onTap: onTap == null ? doNothing : () => onTap(),
        ),
      ),
    );
  }
}
