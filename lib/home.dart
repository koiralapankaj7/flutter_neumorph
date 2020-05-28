import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_neumorph/neumorph.dart';
import 'package:flutter_neumorph/neumorph_shape_widget.dart';

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //

  Color _color = Color(int.parse("0xFF" + "55b9f3"));
  Alignment lightSource = Alignment.topLeft;
  Size size = Size(200.0, 200.0);
  double radius = 40.0;
  double intensity = 1.0;
  double distance = 20.0;
  double blur = 40.0;
  NeumorphShape activeShape = NeumorphShape.flat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //

              // Main Neumorph with activ point settings
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                // color: Colors.white,
                child: Column(
                  children: <Widget>[
                    //

                    // Top
                    Container(
                      child: Row(
                        children: <Widget>[
                          _LightSource(
                            lightSource: Alignment.topLeft,
                            isActive: lightSource == Alignment.topLeft,
                            onPressed: () {
                              setState(() {
                                lightSource = Alignment.topLeft;
                              });
                            },
                          ),
                          Expanded(child: Container()),
                          _LightSource(
                            lightSource: Alignment.topRight,
                            isActive: lightSource == Alignment.topRight,
                            onPressed: () {
                              setState(() {
                                lightSource = Alignment.topRight;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Center
                    Container(
                      height: 350.0,
                      width: 350.0,
                      alignment: Alignment.center,
                      child: Neumorph(
                        color: _color,
                        lightSource: lightSource,
                        blur: this.blur,
                        height: this.size.height,
                        width: this.size.width,
                        radius: this.radius,
                        distance: this.distance,
                        intensity: this.intensity,
                        shape: this.activeShape,
                      ),
                    ),

                    // bottom
                    Container(
                      child: Row(
                        children: <Widget>[
                          _LightSource(
                            lightSource: Alignment.bottomLeft,
                            isActive: lightSource == Alignment.bottomLeft,
                            onPressed: () {
                              setState(() {
                                lightSource = Alignment.bottomLeft;
                              });
                            },
                          ),
                          Expanded(child: Container()),
                          _LightSource(
                            lightSource: Alignment.bottomRight,
                            isActive: lightSource == Alignment.bottomRight,
                            onPressed: () {
                              setState(() {
                                lightSource = Alignment.bottomRight;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    //
                  ],
                ),
              ),

              // Margin
              // Container(height: 100.0),

              // Size changer
              CustomSLider(
                title: 'Size',
                onChanged: (double value) {
                  if (mounted) {
                    setState(() {
                      size = Size(value.truncateToDouble(), value.truncateToDouble());
                      this.distance = (value.truncateToDouble() * 0.10).roundToDouble();
                      this.blur = this.distance * 2;
                    });
                  }
                },
                min: 40.0,
                max: 200.0,
                color: this._color,
                value: this.size.width,
              ),

              // Radius changer
              CustomSLider(
                title: 'Radius',
                onChanged: (double value) {
                  if (mounted) {
                    setState(() {
                      this.radius = value.truncateToDouble();
                    });
                  }
                },
                min: 20.0,
                max: 100.0,
                color: this._color,
                value: this.radius,
              ),

              // Distance changer
              CustomSLider(
                title: 'Distance',
                onChanged: (double value) {
                  if (mounted) {
                    setState(() {
                      this.distance = value.truncateToDouble();
                      this.blur = this.distance * 2;
                    });
                  }
                },
                min: 1.0,
                max: 30.0,
                color: this._color,
                value: this.distance,
              ),

              // Blur changer
              CustomSLider(
                title: 'Blur',
                onChanged: (double value) {
                  if (mounted) {
                    setState(() {
                      this.blur = value.truncateToDouble();
                    });
                  }
                },
                min: 0.0,
                max: 60.0,
                color: this._color,
                value: this.blur,
              ),

              // Intensity changer
              CustomSLider(
                title: 'Intensity',
                onChanged: (double value) {
                  if (mounted) {
                    setState(() {
                      this.intensity = double.parse(value.toStringAsFixed(1));
                    });
                  }
                },
                min: 0.0,
                max: 1.0,
                color: this._color,
                value: this.intensity,
              ),

              // Shape changer
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Shape :", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4.0),
                    Container(
                      color: Colors.black.withOpacity(0.7),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: SizedBox()),
                          _Shape(
                            color: _color,
                            name: 'Flat',
                            shape: NeumorphShape.flat,
                            activeShape: this.activeShape,
                            onPressed: _onShapeChanged,
                          ),
                          _Shape(
                            color: _color,
                            name: 'Concave',
                            shape: NeumorphShape.concave,
                            activeShape: this.activeShape,
                            onPressed: _onShapeChanged,
                          ),
                          _Shape(
                            color: _color,
                            name: 'Convex',
                            shape: NeumorphShape.convex,
                            activeShape: this.activeShape,
                            onPressed: _onShapeChanged,
                          ),
                          _Shape(
                            color: _color,
                            name: 'Pressed',
                            shape: NeumorphShape.pressed,
                            activeShape: this.activeShape,
                            onPressed: _onShapeChanged,
                          ),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Code
              Container(
                height: 200.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                color: Colors.black,
              ),

              // Margin
              SizedBox(height: 100.0),

              //
            ],
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: _onPressed,
        child: Neumorph(
          height: 60.0,
          width: 60.0,
          radius: 40.0,
          blur: 10.0,
          distance: 5.0,
          child: Icon(
            Icons.color_lens,
            color: Colors.black,
          ),
          color: _color,
        ),
      ),
    );
  }

  void _onPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Colors.limeAccent,
              onColorChanged: _colorChange,
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
        );
      },
    );
  }

  void _colorChange(Color color) {
    if (mounted) {
      setState(() {
        _color = color;
      });
    }
  }

  void _onShapeChanged(NeumorphShape shape) {
    if (mounted) {
      setState(() {
        this.activeShape = shape;
      });
    }
  }

  //
}

class _Shape extends StatelessWidget {
  const _Shape({
    Key key,
    @required Color color,
    this.name,
    this.shape,
    this.activeShape,
    this.onPressed,
  })  : _color = color,
        super(key: key);

  final Color _color;
  final String name;
  final NeumorphShape shape;
  final NeumorphShape activeShape;
  final Function(NeumorphShape) onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onPressed(this.shape);
      },
      child: Container(
        color: this.shape == this.activeShape ? Colors.black : Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 40.0,
              width: 50.0,
              child: NeumorphShapeWidget(
                color: this._color,
                strokeWidth: 2.0,
                shape: this.shape,
              ),
            ),
            Text(this.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: this._color,
                )),
          ],
        ),
      ),
    );
  }
}

class _LightSource extends StatelessWidget {
  final Alignment lightSource;
  final bool isActive;
  final Function onPressed;

  const _LightSource({
    Key key,
    this.lightSource,
    this.isActive = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      focusColor: Colors.green,
      child: Container(
        height: 25.0,
        width: 25.0,
        decoration: BoxDecoration(
          color: this.isActive ? Colors.yellow : Colors.transparent,
          border: Border.all(color: this.isActive ? Colors.transparent : Colors.black, width: 1.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(lightSource == Alignment.bottomRight ? 25.0 : 0.0),
            topRight: Radius.circular(lightSource == Alignment.bottomLeft ? 25.0 : 0.0),
            bottomRight: Radius.circular(lightSource == Alignment.topLeft ? 25.0 : 0.0),
            bottomLeft: Radius.circular(lightSource == Alignment.topRight ? 25.0 : 0.0),
          ),
        ),
      ),
    );
  }
}

class CustomSLider extends StatelessWidget {
  final Function(double) onChanged;
  final double value;
  final double min;
  final double max;
  final Color color;
  final String title;

  const CustomSLider({
    Key key,
    this.onChanged,
    this.value,
    this.min,
    this.max,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          //

          // Margin
          SizedBox(width: 20.0),

          // Title
          Text(this.title ?? '', style: TextStyle(fontWeight: FontWeight.bold)),

          // Slider
          Expanded(
            child: Slider(
              value: this.value,
              onChanged: this.onChanged,
              min: this.min,
              max: this.max,
              activeColor: Colors.black,
            ),
          ),

          // Margin
          SizedBox(width: 20.0),

          // Info Widget
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            alignment: Alignment.center,
            child: Text(this.value.toString(), style: TextStyle(color: this.color)),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40.0),
            ),
          ),

          // Margin
          SizedBox(width: 20.0),

          //
        ],
      ),
    );
  }
}
