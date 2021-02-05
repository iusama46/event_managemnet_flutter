import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:event_managemnet/model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'delsreen.dart';

var _image;
Uint8List pngBytes1;
List colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.amber,
  Colors.black
];

Color selectedColor = colors[0];

class Draw extends StatefulWidget {
  Event event;

  Draw({this.event});

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  GlobalKey globalKey = GlobalKey();

  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points = List();
  bool showBottomList = false;
  double opacity = 1.0;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;

  Future<void> _save() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    pngBytes1 = byteData.buffer.asUint8List();
    //final _byteImage = Base64Decoder().convert(byteData.toString());
    //Widget image2 = Image.memory(_byteImage);
    //Request permissions if not already granted
    _image = MemoryImage(pngBytes);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ColorPickerWidget(pngBytes)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.063,
            width: double.infinity,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              color: Colors.black,
              //onPressed: () => createPasswordDialog(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "MARK COMPLETED",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // appBar: AppBar(
      //   centerTitle: true,
      //   actions: [
      //     // Icon(Icons.person),
      //   ],
      //   title: Text('Event OnGoing'),
      //   leading: InkWell(
      //       onTap: () => Navigator.pop(context),
      //       child: Icon(
      //         Icons.arrow_back_ios_outlined,
      //         color: Colors.white,
      //       )),
      //   backgroundColor: Colors.black,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: ()=>_save(),
      //   backgroundColor: Colors.black,
      //   child: Icon(Icons.add),
      // ),
      body: RepaintBoundary(
        child: GestureDetector(
          onPanUpdate: (details) {
            print('hi');
          },
          onPanStart: (details) {
            print('hi2');
            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(DrawingPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = StrokeCap.round
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = 40.0));
              colors.remove(selectedColor);
              selectedColor = colors[0];
            });
          },
          onPanEnd: (details) {
            setState(() {
              print('hi3');
              points.add(null);
            });
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        "images/delpaint_one.png"
                    ),
                  ),
                  border: Border.all(
                      width: 0, //
                      color:
                          Colors.white //                <--- border width here
                      ),
                ),
                child: CustomPaint(
                  size: Size.infinite,
                  painter: DrawingPainter(
                    pointsList: points,
                  ),
                ),
              ),
              Positioned(
                bottom: 24.0,
                child: Column(
                  children: [
                    Text(
                      'k',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontFamily: 'BrushScript',
                      ),
                    ),
                    Text(
                      '12:30 am, widget.event.date',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.pointsList});

  List<DrawingPoints> pointsList;
  List<Offset> offsetPoints = List();

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));
        // Offset center = Offset(size.width / 2, size.height / 2);
        //
        // canvas.drawCircle(loct, 10, paint);
        //canvas.drawPoints(PointMode.points, offsetPoints., pointsList[i].paint);
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint paint;
  Offset points;

  DrawingPoints({this.points, this.paint});
}

enum SelectedMode { StrokeWidth, Opacity, Color }

class ImageCon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          height: 200,
          child: Image.memory(
            pngBytes1,
          ),
          color: Colors.orange,
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: _image,
            ),
            border: Border.all(
                width: 12, //
                color: Colors.black //                <--- border width here
                ),
          ),
        )
      ],
    );
  }
}
