import 'dart:math' as math;

import 'package:flutter/material.dart';

class SemiCircleMaker extends StatelessWidget {
  final double diameter;

  var color;

  SemiCircleMaker({super.key, this.diameter = 200,required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SemiCircleMakerComponent(color: color),
      size: Size(diameter, diameter),
    );
  }
}


// This is the Painter class
class SemiCircleMakerComponent extends CustomPainter {
  Color color;



  SemiCircleMakerComponent({required this.color});


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}