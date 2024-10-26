import 'package:flutter/material.dart';

class CSCustomCurvedEgdes extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    final firstCurved = Offset(0, size.height-20);
    final lastCured = Offset(30, size.height-20);
    path.quadraticBezierTo(firstCurved.dx
        , firstCurved.dy, lastCured.dx, lastCured.dy);

    final secondLastCurved = Offset(size.width-30, size.height-20);
    final secondFinalCurved = Offset(0, size.height-20);
    path.quadraticBezierTo(secondFinalCurved.dx, secondFinalCurved.dy, secondLastCurved.dx, secondFinalCurved.dy);

    final thirdFirstCurved = Offset(size.width, size.height-20);
    final thirdLastCurved = Offset(size.width, size.height);
    path.quadraticBezierTo(thirdFirstCurved.dx, thirdFirstCurved.dy, thirdLastCurved.dx, thirdLastCurved.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}