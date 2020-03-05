import 'package:flutter/material.dart';

const kBtnColor = Color(0xFFF29BBB);

class CustomIconButton extends StatelessWidget {
  final Color colour;
  final IconData icon;
  final Function onPress;

  CustomIconButton(this.colour, this.icon, this.onPress);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPress,
      constraints: BoxConstraints.tightFor(width: 36.0, height: 36.0),
      shape: CircleBorder(),
      fillColor: kBtnColor,
    );
  }
}
