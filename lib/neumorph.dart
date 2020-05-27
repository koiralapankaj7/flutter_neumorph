import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_neumorph/pressed_decoration.dart';

class Neumorph extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double radius;
  final double distance;
  final double intensity;
  final double blur;
  final NeumorphShape shape;
  final Alignment lightSource;
  final Color color;

  const Neumorph({
    Key key,
    this.height = 200.0,
    this.width = 200.0,
    this.radius = 40.0,
    this.distance = 20.0,
    this.intensity = 0.5,
    this.blur = 40.0,
    this.shape = NeumorphShape.flat,
    this.lightSource = Alignment.topLeft,
    this.child,
    this.color = Colors.white,
  })  : assert(intensity != null ? intensity >= 0.0 && intensity <= 1.0 : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //

    print("Light sourse from inside.... $lightSource");

    final HSLColor hsl = HSLColor.fromColor(this.color);

    final Color lightColor = hsl.withLightness((hsl.lightness * 1.20).clamp(0.0, 1.0)).toColor();
    final Color darkColor = hsl.withLightness((hsl.lightness * 0.90).clamp(0.0, 1.0)).toColor();

    var pressedDecoration = CustomisedDecoration(
      colors: [
        hsl.withLightness((hsl.lightness * 1.20).clamp(0.0, 1.0)).toColor(),
        hsl.withLightness((hsl.lightness * 0.80).clamp(0.0, 1.0)).toColor(),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(this.radius),
      ),
      depth: this.distance,
      opacity: this.intensity,
      lightSource: this.lightSource,
    );

    var defaultDecoration = BoxDecoration(
      gradient: _getColor(this.shape),
      borderRadius: BorderRadius.circular(this.radius),
      boxShadow: this.shape == NeumorphShape.pressed
          ? [
              BoxShadow(
                blurRadius: this.blur,
                offset: Offset(this.distance, this.distance),
                color: darkColor.withOpacity(this.intensity),
              ),
              BoxShadow(
                blurRadius: this.blur,
                offset: Offset(-this.distance, -this.distance),
                color: lightColor.withOpacity(this.intensity),
              ),
            ]
          : this.shape == NeumorphShape.convex
              ? [
                  BoxShadow(
                    blurRadius: this.blur,
                    offset: _getOffset(true),
                    color: hsl.withLightness((hsl.lightness * 1.10).clamp(0.0, 1.0)).toColor(),
                  ),
                  BoxShadow(
                    blurRadius: this.blur,
                    offset: _getOffset(false),
                    color: hsl.withLightness((hsl.lightness * 0.90).clamp(0.0, 1.0)).toColor(),
                  ),
                ]
              : [
                  BoxShadow(
                    blurRadius: this.blur,
                    offset: _getOffset(true),
                    color: lightColor.withOpacity(this.intensity),
                  ),
                  BoxShadow(
                    blurRadius: this.blur,
                    offset: _getOffset(false),
                    color: darkColor.withOpacity(this.intensity),
                  ),
                ],
    );

    return Container(
      height: this.height,
      width: this.width,
      decoration: this.shape == NeumorphShape.pressed ? pressedDecoration : defaultDecoration,
      child: this.child ?? Container(),
    );
  }

  Gradient _getColor(NeumorphShape shape) {
    final HSLColor hsl = HSLColor.fromColor(this.color);
    final Color lightColor = hsl.withLightness((hsl.lightness * 1.20).clamp(0.0, 1.0)).toColor();
    final Color darkColor = hsl.withLightness((hsl.lightness * 0.90).clamp(0.0, 1.0)).toColor();

    switch (this.shape) {
      case NeumorphShape.flat:
        return LinearGradient(colors: [this.color, this.color]);
        break;
      case NeumorphShape.concave:
        return LinearGradient(
          transform: GradientRotation(45 * pi / 180),
          colors: [
            hsl.withLightness((hsl.lightness * 0.95).clamp(0.0, 1.0)).toColor(),
            hsl.withLightness((hsl.lightness * 1.05).clamp(0.0, 1.0)).toColor(),
          ],
        );
        break;
      case NeumorphShape.convex:
        return LinearGradient(
          transform: GradientRotation(45 * pi / 180),
          colors: [
            hsl.withLightness((hsl.lightness * 1.05).clamp(0.0, 1.0)).toColor(),
            hsl.withLightness((hsl.lightness * 0.95).clamp(0.0, 1.0)).toColor(),
          ],
        );
        break;
      case NeumorphShape.pressed:
        return SweepGradient(
          colors: [
            lightColor,
            this.color,
          ],
          center: AlignmentDirectional(0.1, 0.1),
          stops: [0.3, 1.0],
          endAngle: pi,
          startAngle: 0.0,
          tileMode: TileMode.mirror,
        );
        break;
      default:
        return LinearGradient(colors: [Colors.green, Colors.yellow]);
    }
  }

  Offset _getOffset(bool isLight) {
    if (this.lightSource == Alignment.topLeft) {
      return isLight
          ? Offset(-this.distance, -this.distance)
          : Offset(this.distance, this.distance);
    }

    if (this.lightSource == Alignment.topRight) {
      return isLight
          ? Offset(this.distance, -this.distance)
          : Offset(-this.distance, this.distance);
    }

    if (this.lightSource == Alignment.bottomLeft) {
      return isLight
          ? Offset(-this.distance, this.distance)
          : Offset(this.distance, -this.distance);
    }

    if (this.lightSource == Alignment.bottomLeft) {
      return isLight
          ? Offset(this.distance, this.distance)
          : Offset(-this.distance, -this.distance);
    }

    return isLight ? Offset(-this.distance, -this.distance) : Offset(this.distance, this.distance);
  }

  //
}

enum NeumorphShape { flat, concave, convex, pressed }

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
