import 'package:flutter/material.dart';

class StaticShapes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom paint Demo'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              CustomPaint(
                size: Size(100, 100),
                painter: LinePainter(),
              ),
              CustomPaint(
                size: Size(100, 100),
                painter: CirclePainter(),
              ),
              CustomPaint(
                size: Size(100, 100),
                painter: RectanglePainter(),
              ),
              // CustomPaint(
              //   size: Size(200, 100),
              //   painter: OvalPainter(),
              // ),
              CustomPaint(
                size: Size(100, 100),
                painter: ArcPainter(),
              ),
              CustomPaint(
                size: Size(100, 100),
                painter: TrianglePainter(),
              ),
              CustomPaint(
                size: Size(100, 100),
                painter: RoundedRectanglePainter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    Offset start = Offset(0, size.height / 2);
    Offset end = Offset(size.width, size.height / 2);

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
    // if canva changes, we should return true
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 6);

    canvas.drawCircle(center, size.width * 1/2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RectanglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;

    final start = Offset(size.width * 1/4, size.height * 1/4);
    final end = Offset(size.width * 3/4, size.height * 3/4);
    final rect = Rect.fromPoints(start, end);

    canvas.drawRect(rect, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RoundedRectanglePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    // fill - заповнений, stroke - пустий

    final start = Offset(size.width * 1/4, size.height * 1/4);
    final end = Offset(size.width * 3/4, size.height * 3/4);
    final rect = Rect.fromPoints(start, end);
    final radius = Radius.circular(18);

    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final arc1 = Path();
    arc1.moveTo(size.width * 0.2, size.height * 0.6);
    arc1.arcToPoint(
      Offset(size.width * 0.8, size.height * 0.3),
      radius: Radius.circular(10),
      clockwise: false, //if we write true, it will draw on another side
    );

    canvas.drawPath(arc1, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width * 1/2, size.height * 1/4);
    path.lineTo(size.width * 1/6, size.height * 3/4);
    path.lineTo(size.width * 5/6, size.height * 3/4);
    path.close();

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
