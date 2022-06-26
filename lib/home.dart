import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = GlobalKey();
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  double? dx = 0,
      dy = 0,
      dxCurrent = 0,
      dyCurrent = 0;
  static late Offset offset1, offset2;
  double opacity = 1.0;
  List<DrawingPoint?> drawingPoints = [];
  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.blue,
    Colors.purple,
    Colors.green,
  ];

  Future<void> _save() async {
    RenderRepaintBoundary? boundary =
    globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary? ;
    ui.Image image = await boundary!.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();

    //Request permissions if not already granted
    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(pngBytes!),
        quality: 60,
        name: "canvas_image");
    print(result);
  }

//   Future<void> shape {
//     return spape;
// }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: const <Widget>[
            //AlertDialog(settings);
          ],
        ),
        body: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(177, 219, 251, 1.0),
                          Color.fromRGBO(255, 255, 255, 1.0),
                          Color.fromRGBO(240, 177, 251, 1.0),
                        ]
                    )
                ),
              ),
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.7,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            boxShadow: [ BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                            )
                            ],
                          ),
                          child: GestureDetector(
                              onPanStart: (details) {
                                setState(() {
                                  dx = details.localPosition.dx;
                                  dy = details.localPosition.dy;
                                  offset1 = details.localPosition;
                                  drawingPoints.add(DrawingPoint(
                                    details.localPosition,
                                    Paint()
                                      ..color = Colors.teal.withOpacity(opacity)
                                      ..isAntiAlias = true
                                      ..strokeWidth = strokeWidth
                                      ..strokeCap = StrokeCap.round,
                                  ));
                                });
                              },
                              onPanUpdate: (details) {
                                setState(() {
                                  offset2 = details.localPosition;
                                  dx = details.localPosition.dx;
                                  dy = details.localPosition.dy;
                                  drawingPoints.add(DrawingPoint(
                                    details.localPosition,
                                    Paint()
                                      ..color = selectedColor.withOpacity(opacity)
                                      ..isAntiAlias = true
                                      ..strokeWidth = strokeWidth
                                      ..strokeCap = StrokeCap.round,
                                  ));
                                });
                              },
                              onPanEnd: (details) {
                                setState(() {
                                  drawingPoints.add(null);
                                });
                              },
                              child: RepaintBoundary(
                                key: globalKey,
                                child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: Image.asset("lib/img.png"),
                                      ),
                                      CustomPaint(
                                        painter: _DrawingPainter(drawingPoints),
                                        child: SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.7,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.8,
                                        ),
                                      ),
                                    ]
                                ),

                              )
                          )
                      ),
                    ]
                ),
              )
            ]
        ),
        bottomNavigationBar: Container(
            height: 80,
            color: const Color.fromRGBO(235, 150, 250, 1.0),
            padding: const EdgeInsets.all(10),
            child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.view_in_ar),
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Choose Shape'),
                              actions: <Widget>[
                                Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      children: List.generate(
                                          colors.length, (index) => _buildColorChose(colors[index])),
                                    )),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: const Text('Yes'),
                                )
                              ],
                            );
                          }
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.color_lens),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Choose Color'),
                              actions: <Widget>[
                                Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      children: List.generate(
                                          colors.length, (index) => _buildColorChose(colors[index])),
                                    )),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, child: const Text('Yes'),
                                )
                              ],
                            );
                          }
                      );
                    },
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // IconButton(
                  //     icon: const Icon(
                  //       Icons.view_in_ar ,
                  //       color: Colors.black,
                  //     ),
                  //     onPressed: () {
                  //       showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return AlertDialog(
                  //               title: Text('Shape'),
                  //               actions: <Widget>[
                  //                 Center(
                  //                   child: Column(
                  //                     mainAxisAlignment: MainAxisAlignment
                  //                         .spaceAround,
                  //                     children: <Widget>[
                  //                       TextButton(
                  //                           onPressed: (){ shape == 'dot';},
                  //                           child: Text('DOT')
                  //                       ),
                  //                       TextButton(
                  //                           onPressed: (){shape == 'line';},
                  //                           child: Text('LINE')
                  //                       ),
                  //                       TextButton(
                  //                           onPressed: (){shape == 'pencil';},
                  //                           child: Text('PENCIL')
                  //                       ),
                  //                       TextButton(
                  //                           onPressed: (){shape == 'rectangle';},
                  //                           child: const Text('RECTANGLE')
                  //                       ),
                  //                       TextButton(
                  //                           onPressed: (){shape == 'oval';},
                  //                           child: const Text('OVAL')
                  //                       ),
                  //                     ]
                  //                     )),
                  //                 FlatButton(
                  //                     onPressed: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                     child: const Text('Yes')
                  //                 )
                  //               ],
                  //             );
                  //           }
                  //       );
                  //     }
                  //     ),
                  IconButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Opacity"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Icon(
                                    Icons.opacity,
                                    size: 24,
                                  ),
                                  onPressed: () {
                                    //most transparent
                                    opacity = 0.1;
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Icon(
                                    Icons.opacity,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    opacity = 0.5;
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Icon(
                                    Icons.opacity,
                                    size: 60,
                                  ),
                                  onPressed: () {
                                    //not transparent at all.
                                    opacity = 1.0;
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    },
                    icon: Icon(Icons.opacity),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Slider(
                      min: 1.0,
                      max: 20.0,
                      label: "Stroke $strokeWidth",
                      activeColor: selectedColor,
                      value: strokeWidth,
                      onChanged: (double value) {
                        setState(() {
                          strokeWidth = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      icon: const Icon(
                        Icons.layers_clear,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState((){
                          drawingPoints.clear();
                        });
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.save_alt,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _save();
                        });;
                      }
                  ),
                ]
            )
        )
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        height: isSelected ? 55 : 40,
        width: isSelected ? 55 : 40,
        decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
              color: Colors.white,
              width: 3,
            )
                : null),
      ),
    );
  }

}
class _DrawingPainter extends CustomPainter{
  final List<DrawingPoint?> drawingPoints;

  _DrawingPainter(this.drawingPoints);
  List<Offset> offsetsList = [];

  @override
  Future<void> paint(Canvas canvas, Size size) async {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for(int i = 0; i < drawingPoints.length; i++){
      if(drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i]!.offset, drawingPoints[i + 1]!.offset, drawingPoints[i]!.paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null){
        offsetsList.clear();
        offsetsList.add(drawingPoints[i]!.offset);
        canvas.drawPoints(PointMode.points, offsetsList, drawingPoints[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}
