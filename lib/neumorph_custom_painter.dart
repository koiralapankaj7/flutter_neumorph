// import 'dart:math';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_neumorph/neumorph.dart';

// class NeumorphNew extends StatelessWidget {
//   final Widget child;
//   final double height;
//   final double width;
//   final double radius;
//   final double distance;
//   final double intensity;
//   final double blur;
//   final NeumorphShape shape;
//   final NeumorphPoint point;
//   final Color color;

//   // static const double _DEFAULT_SIZE = 200.0;
//   // static const double _DEFAULT_RADIUS = 100.0;

//   const NeumorphNew({
//     Key key,
//     this.height = 200.0,
//     this.width = 200.0,
//     this.radius = 40.0,
//     this.distance = 20.0,
//     this.intensity = 0.5,
//     this.blur = 40.0,
//     this.shape = NeumorphShape.flat,
//     this.point = NeumorphPoint.topLeft,
//     this.child,
//     this.color = Colors.white,
//   })  : assert(intensity != null ? intensity >= 0.0 && intensity <= 1.0 : true),
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     //

//     final HSLColor hsl = HSLColor.fromColor(this.color);
//     final Color lightColor = hsl.withLightness((hsl.lightness * 1.20).clamp(0.0, 1.0)).toColor();
//     final Color darkColor = hsl.withLightness((hsl.lightness * 0.80).clamp(0.0, 1.0)).toColor();

//     return Container(
//       height: this.height,
//       width: this.width,
//       // decoration: BoxDecoration(
//       //   gradient: _getColor(this.shape),
//       //   borderRadius: BorderRadius.circular(this.radius),
//       //   boxShadow: this.shape == NeumorphShape.pressed
//       //       ? [
//       //           BoxShadow(
//       //             blurRadius: this.blur,
//       //             offset: Offset(this.distance, this.distance),
//       //             color: darkColor.withOpacity(this.intensity),
//       //           ),
//       //           BoxShadow(
//       //             blurRadius: this.blur,
//       //             offset: Offset(-this.distance, -this.distance),
//       //             color: lightColor.withOpacity(this.intensity),
//       //           ),
//       //         ]
//       //       : [
//       //           BoxShadow(
//       //             blurRadius: this.blur,
//       //             offset: _getOffset(true),
//       //             color: lightColor.withOpacity(this.intensity),
//       //           ),
//       //           BoxShadow(
//       //             blurRadius: this.blur,
//       //             offset: _getOffset(false),
//       //             color: darkColor.withOpacity(this.intensity),
//       //           ),
//       //         ],
//       // ),

//       child: CustomPaint(
//         painter: NeuMorphCustomPainter(
//           blur: this.blur,
//           color: this.color,
//           distance: this.distance,
//           intensity: this.intensity,
//           point: this.point,
//           radius: this.radius,
//           shape: this.shape,
//         ),
//         child: this.child ?? Container(),
//       ),
//     );
//   }

//   Gradient _getColor(NeumorphShape shape) {
//     final HSLColor hsl = HSLColor.fromColor(this.color);
//     final Color lightColor = hsl.withLightness((hsl.lightness * 1.10).clamp(0.0, 1.0)).toColor();
//     final Color darkColor = hsl.withLightness((hsl.lightness * 0.90).clamp(0.0, 1.0)).toColor();

//     switch (this.shape) {
//       case NeumorphShape.flat:
//         return LinearGradient(colors: [this.color, this.color]);
//         break;
//       case NeumorphShape.concave:
//         return LinearGradient(
//           transform: GradientRotation(45 * pi / 180),
//           colors: [
//             darkColor.withOpacity(this.intensity),
//             this.color,
//             lightColor.withOpacity(this.intensity),
//           ],
//         );
//         break;
//       case NeumorphShape.convex:
//         return LinearGradient(
//           transform: GradientRotation(45 * pi / 180),
//           colors: [
//             lightColor.withOpacity(this.intensity),
//             this.color,
//             darkColor.withOpacity(this.intensity),
//           ],
//         );
//         break;
//       case NeumorphShape.pressed:
//         return LinearGradient(colors: [this.color, this.color]);
//         break;
//       default:
//         return LinearGradient(colors: [this.color, this.color]);
//     }
//   }

//   Offset _getOffset(bool isLight) {
//     switch (this.point) {
//       case NeumorphPoint.topLeft:
//         return isLight
//             ? Offset(-this.distance, -this.distance)
//             : Offset(this.distance, this.distance);
//         break;
//       case NeumorphPoint.topRight:
//         return isLight
//             ? Offset(this.distance, -this.distance)
//             : Offset(-this.distance, this.distance);
//         break;
//       case NeumorphPoint.bottomLeft:
//         return isLight
//             ? Offset(-this.distance, this.distance)
//             : Offset(this.distance, -this.distance);
//         break;
//       case NeumorphPoint.bottomRight:
//         return isLight
//             ? Offset(this.distance, this.distance)
//             : Offset(-this.distance, -this.distance);
//         break;
//       default:
//         return isLight
//             ? Offset(-this.distance, -this.distance)
//             : Offset(this.distance, this.distance);
//     }
//   }

//   //
// }

// extension ColorUtils on Color {
//   Color mix(Color another, double amount) {
//     return Color.lerp(this, another, amount);
//   }
// }

// class NeuMorphCustomPainter extends CustomPainter {
//   //

//   NeuMorphCustomPainter({
//     this.radius,
//     this.distance,
//     this.intensity,
//     this.blur,
//     this.shape,
//     this.point,
//     this.color,
//   });

//   final double radius;
//   final double distance;
//   final double intensity;
//   final double blur;
//   final NeumorphShape shape;
//   final NeumorphPoint point;
//   final Color color;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint();
//     final Rect rect = Rect.fromCenter(
//       height: size.height,
//       width: size.width,
//       center: Offset(size.width / 2, size.height / 2),
//     );
//     final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(this.radius));

//     final HSLColor hsl = HSLColor.fromColor(this.color);
//     final Color lightColor = hsl.withLightness((hsl.lightness * 1.10).clamp(0.0, 1.0)).toColor();
//     final Color darkColor = hsl.withLightness((hsl.lightness * 0.90).clamp(0.0, 1.0)).toColor();

//     final LinearGradient gradient = LinearGradient(colors: [lightColor, darkColor]);

//     paint.shader = gradient.createShader(rect);
//     paint.blendMode = BlendMode.srcATop;
//     // paint.invertColors = true;
//     // paint.colorFilter = ColorFilter.mode(darkColor, BlendMode.srcIn);
//     // paint.imageFilter = ImageFilter.blur(sigmaX: this.blur, sigmaY: this.blur);
//     // paint.maskFilter = MaskFilter.blur(BlurStyle.normal, this.blur);

//     canvas.drawShadow(Path()..addRRect(rRect), darkColor, this.distance, true);
//     canvas.drawRRect(rRect, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
