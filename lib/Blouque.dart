import 'package:flutter/material.dart';

class Blouque extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset(
        'lib/charchabil.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
