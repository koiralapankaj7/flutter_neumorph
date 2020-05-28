import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_neumorph/pressed_decoration.dart';

class Neumorph extends StatelessWidget {
  const Neumorph({
    Key key,
    this.height = 200.0,
    this.width = 200.0,
    this.radius = 40.0,
    this.distance = 20.0,
    this.intensity = 1.0,
    this.blur = 40.0,
    this.shape = NeumorphShape.flat,
    this.lightSource = Alignment.topLeft,
    this.child,
    this.color = Colors.white,
  })  : assert(intensity != null ? intensity >= 0.0 && intensity <= 1.0 : true),
        super(key: key);

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

  double get lightFactor => lightnessFactor(this.color, true);
  double get darkFactor => lightnessFactor(this.color, false);
  HSLColor get hsl => HSLColor.fromColor(this.color);
  Color get lightColor =>
      hsl.withLightness((hsl.lightness * lightFactor).clamp(0.0, 1.0)).toColor();
  Color get darkColor => hsl.withLightness((hsl.lightness * darkFactor).clamp(0.0, 1.0)).toColor();

  @override
  Widget build(BuildContext context) {
    //

    // final HSLColor hsl = HSLColor.fromColor(this.color);

    print("Light factor : $lightFactor || Dark factor : $darkFactor");

    // final Color lightColor =
    // hsl.withLightness((hsl.lightness * lightFactor).clamp(0.0, 1.0)).toColor();
    // final Color darkColor =
    //     hsl.withLightness((hsl.lightness * darkFactor).clamp(0.0, 1.0)).toColor();

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
    // final HSLColor hsl = HSLColor.fromColor(this.color);
    // final Color lightColor = hsl.withLightness((hsl.lightness * 1.20).clamp(0.0, 1.0)).toColor();
    // final Color darkColor = hsl.withLightness((hsl.lightness * 0.90).clamp(0.0, 1.0)).toColor();

    switch (this.shape) {
      case NeumorphShape.flat:
        return LinearGradient(colors: [this.color, this.color]);
        break;
      case NeumorphShape.concave:
        return LinearGradient(
          transform: GradientRotation(this.lightSource.radians),
          colors: [
            darkColor.withOpacity(this.intensity),
            lightColor.withOpacity(this.intensity),
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

    if (this.lightSource == Alignment.bottomRight) {
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

enum ColorType { mostLight, mediumLight, normal, mediumDark, mostDark }

extension NumberExtension on Color {
  ColorType get colorType {
    final double luminance = this.computeLuminance();
    // 0.8 - 1.0 == Most light
    if (luminance >= 0.8 && luminance <= 1.0) {
      return ColorType.mostLight;
    }
    // 0.6 - 0.8 - Medium light
    if (luminance >= 0.6 && luminance < 0.8) {
      return ColorType.mediumLight;
    }
    // 0.2 - 0.4 - Medium dark
    if (luminance >= 0.2 && luminance <= 0.4) {
      return ColorType.mediumDark;
    }
    // 0.0 - 0.2 - Most Dark
    if (luminance >= 0.0 && luminance < 0.2) {
      return ColorType.mostDark;
    }
    // 0.4 - 0.6 - Normal
    return ColorType.normal;
  }
}

double lightnessFactor(Color color, bool light) {
  final ColorType colorType = color.colorType;
  print(colorType);
  switch (colorType) {
    case ColorType.mostLight:
      return light ? 1.25 : 0.75;
    case ColorType.mediumLight:
      return light ? 1.20 : 0.80;
    case ColorType.normal:
      return light ? 1.15 : 0.85;
    case ColorType.mediumDark:
      return light ? 1.10 : 0.90;
    case ColorType.mostDark:
      return light ? 1.05 : 0.95;
    default:
      return light ? 1.0 : 0.0;
  }
}

extension AlignmentExtension on Alignment {
  double get radians {
    if (this == Alignment.topLeft) {
      return pi / 4;
    }
    if (this == Alignment.topRight) {
      return 3 * pi / 4;
    }
    if (this == Alignment.bottomLeft) {
      return 7 * pi / 4;
    }
    if (this == Alignment.bottomRight) {
      return 5 * pi / 4;
    }
    return 10.0;
  }
}
