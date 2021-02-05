import 'dart:io';
import 'dart:ui';

import 'package:event_managemnet/dialogs/password_verification.dart';
import 'package:event_managemnet/dialogs/user_sign.dart';
import 'package:event_managemnet/model/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createEventStartedDialog(BuildContext context, Event event) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0))),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .pop('dialog'),
                      child: Icon(
                        Icons.close,
                        size: 32.0,
                        color: Colors.black,
                      ),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  //DrawPaint(event: event),
                  PaintWidget(event),
                  Padding(
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
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 4.0, left: 4.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context, rootNavigator: true)
                          .pop('dialog'),
                      child: Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      });
}

class PaintWidget extends StatefulWidget {
  final Event event;

  PaintWidget(this.event);

  @override
  _PaintWidgetState createState() => _PaintWidgetState();
}

class _PaintWidgetState extends State<PaintWidget> {
  double posx = 100.0;
  double posy = 100.0;
  Size size = Size.zero;
  Size center;
  Alignment alignment = Alignment(-1, -1);
  double paddingTop;
  List<Size> points = [];

  @override
  void initState() {
    super.initState();
  }

  void onTapDown(TapDownDetails details) {
    createUserSignEventDialog(context);
    print('${details.globalPosition} ${size.toString()}');
    final RenderBox box = context.findRenderObject();

    final Offset localOffset = box.globalToLocal(details.globalPosition);
    print(
        '${details.globalPosition} ${size.toString()} center ${(center.width / size.width).toString()}');

    posx = localOffset.dx;
    posy = localOffset.dy;
    calculate();
  }

  calculate() {
    points.add(Size(posx, posy));
    print(points);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    //paddingTop = MediaQuery.of(context).padding.top;
    center = size * 0.5;

    return GestureDetector(
      onTapDown: onTapDown,
      child: Container(
        //height: 400.0,
        //width: size.width,
        //margin: EdgeInsets.only(top: 20.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage("images/delpaintt.png"),
                // ),
                border: Border.all(
                    width: 12, //
                    color: Colors.black //                <--- border width here
                    ),
              ),
              child: Image.asset(
                'images/delpaintt.png',
                fit: BoxFit.fill,
              ),
            ),
            ...points.map(
              (e) => Positioned(
                top: e.height,
                left: e.width,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.orange),
                ),
              ),
            ),
            Positioned(
              bottom: 24.0,
              child: Column(
                children: [
                  Text(
                    '${widget.event.name}',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontFamily: 'BrushScript',
                    ),
                  ),
                  Text(
                    '12:30 am, ${widget.event.date}',
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
    );
  }
}

class DrawPaint extends StatefulWidget {
  Event event;

  DrawPaint({this.event});

  @override
  _DrawPaintState createState() => _DrawPaintState();
}

class _DrawPaintState extends State<DrawPaint> {
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints> points = List();
  bool showBottomList = false;
  double opacity = 1.0;
  StrokeCap strokeCap =
      (Platform.isAndroid) ? StrokeCap.round : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.StrokeWidth;

  void onTap(details) {
    setState(() {
      RenderBox renderBox = context.findRenderObject();
      points.add(DrawingPoints(
          points: renderBox.globalToLocal(details.globalPosition),
          paint: Paint()

            //   ..strokeWidth = 5
            //   //..style = PaintingStyle.stroke
            //   ..strokeCap = StrokeCap.round;
            //

            ..strokeCap = StrokeCap.round
            ..isAntiAlias = true
            ..color = selectedColor.withOpacity(0.8)
            ..strokeWidth = 20.0));

      points.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: onTap,
        child: Container(
          height: 100,
          width: 100,
          child: CustomPaint(
            //size: Size.infinite,
            painter: DrawingPainter(
              pointsList: points,
            ),
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
