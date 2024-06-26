import 'package:flutter/material.dart';
import 'dart:math';

class AppointmentCard extends StatelessWidget {
  final String title;
  final int completed;
  final int total;

  AppointmentCard(this.title, this.completed, this.total);

  @override
  Widget build(BuildContext context) {
    double percentage = total != 0 ? (completed / total) : 0;

    return Card(
      color: Color(0xFF7E91D4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CustomPaint(
                painter: CircularPainter(percentage),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '$completed/$total',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularPainter extends CustomPainter {
  final double percentage;
  CircularPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCircle = Paint()
      ..strokeWidth = 8
      ..color = Colors.white
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 8
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      angle,
      false,
      completeArc,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
