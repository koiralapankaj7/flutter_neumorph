import 'package:flutter/material.dart';
import 'package:flutter_neumorph/neumorph.dart';

class NeumorphShapeWidget extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final NeumorphShape shape;

  const NeumorphShapeWidget({
    Key key,
    this.color,
    this.strokeWidth,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _ConcavePainting(
        color: this.color,
        shape: this.shape,
        strokeWidth: this.strokeWidth,
      ),
    );
  }
}

class _ConcavePainting extends CustomPainter {
  //

  _ConcavePainting({
    this.color,
    this.shape,
    this.strokeWidth,
  });

  final Color color;
  final NeumorphShape shape;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = this.color ?? Colors.black
      ..strokeWidth = this.strokeWidth ?? 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    switch (this.shape) {
      case NeumorphShape.flat:
        canvas.drawPath(flat(size), paint);
        return;
      case NeumorphShape.concave:
        canvas.drawPath(concave(size), paint);
        return;
      case NeumorphShape.convex:
        canvas.drawPath(convex(size), paint);
        return;
      case NeumorphShape.pressed:
        canvas.drawPath(pressed(size), paint);
        return;
      default:
        canvas.drawPath(flat(size), paint);
        return;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  Path flat(Size size) {
    Path path = Path()
      ..moveTo(size.width * 0.20, size.height * 0.60)
      ..quadraticBezierTo(
          size.width * 0.30, size.height * 0.60, size.width * 0.30, size.height * 0.50)
      ..lineTo(size.width * 0.70, size.height * 0.50)
      ..quadraticBezierTo(
          size.width * 0.70, size.height * 0.60, size.width * 0.80, size.height * 0.60);
    return path;
  }

  Path concave(Size size) {
    Path path = Path()
      ..moveTo(size.width * 0.20, size.height * 0.60)
      ..quadraticBezierTo(
          size.width * 0.30, size.height * 0.60, size.width * 0.30, size.height * 0.50)
      ..quadraticBezierTo(
          size.width * 0.50, size.height * 0.60, size.width * 0.70, size.height * 0.50)
      ..quadraticBezierTo(
          size.width * 0.70, size.height * 0.60, size.width * 0.80, size.height * 0.60);
    return path;
  }

  Path convex(Size size) {
    Path path = Path()
      ..moveTo(size.width * 0.20, size.height * 0.60)
      ..quadraticBezierTo(
          size.width * 0.30, size.height * 0.60, size.width * 0.30, size.height * 0.50)
      ..quadraticBezierTo(
          size.width * 0.50, size.height * 0.40, size.width * 0.70, size.height * 0.50)
      ..quadraticBezierTo(
          size.width * 0.70, size.height * 0.60, size.width * 0.80, size.height * 0.60);
    return path;
  }

  Path pressed(Size size) {
    Path path = Path()
      ..moveTo(size.width * 0.20, size.height * 0.50)
      ..lineTo(size.width * 0.30, size.height * 0.50)
      ..lineTo(size.width * 0.30, size.height * 0.60)
      ..lineTo(size.width * 0.70, size.height * 0.60)
      ..lineTo(size.width * 0.70, size.height * 0.50)
      ..lineTo(size.width * 0.80, size.height * 0.50);
    return path;
  }
}
