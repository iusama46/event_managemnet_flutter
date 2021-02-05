import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:event_managemnet/model/event_model.dart';
import 'package:event_managemnet/screens/add_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'event_page.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


var _image;

List colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.lime,
  Colors.teal,
  Colors.indigo,
  Colors.green,
  Colors.greenAccent,
  Colors.grey,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.pink,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.orange,
  Colors.lime,
  Colors.teal,
  Colors.indigo,
  Colors.green,
  Colors.greenAccent,
  Colors.grey,
  Colors.lightGreen,
  Colors.lightGreenAccent,
  Colors.blueAccent,
  Colors.redAccent,
  Colors.pink,
  Colors.pinkAccent,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.deepPurpleAccent,
];

List selectedColorList = [];

Color selectedColor = colors[0];
Uint8List pngBytes1;
int counter = 0;
bool isSigned = false;

List<DrawingPoints> points = List();
var mDetails;

class DrawPage extends StatefulWidget {
  final Event event;

  DrawPage({this.event});

  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
  GlobalKey globalKey = GlobalKey();

  //Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;

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
    Navigator.pop(context);
    _image = MemoryImage(pngBytes);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EventPage(
                counter: counter,
                pngBytes: pngBytes,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   margin: EdgeInsets.only(bottom: 30.0, right: 10.0),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       _save();
      //       //createPasswordDialog(context, counter, pngBytes1);
      //     },
      //     backgroundColor: Colors.black,
      //     child: Icon(Icons.stop),
      //   ),
      // ),
      body: RepaintBoundary(
        key: globalKey,
        child: GestureDetector(
          onPanUpdate: (details) {
            print('hi');
          },
          onPanStart: (details) {
            mDetails = details;
            createUserSignEventDialog(context);
            //setState(() {
            print('hi2');

            setState(() {
              RenderBox renderBox = context.findRenderObject();
              points.add(DrawingPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = StrokeCap.round
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(0.8)
                    ..strokeWidth = 40.0));
              colors.remove(selectedColor);
              selectedColor = colors[0];
            });
            //});
          },
          onPanEnd: (details) {

            setState(() {
              print('hi3');
              points.add(null);
            });
          },

          // onTapDown: (details) {
          //   print('ontap');
          //   createUserSignEventDialog(context);
          //   setState(() {
          //
          //   });
          //   // mDetails = details;
          //   // createUserSignEventDialog(context);
          //   //
          //   // setState(() {
          //   //   RenderBox renderBox = context.findRenderObject();
          //   //   points.add(DrawingPoints(
          //   //       points: renderBox.globalToLocal(mDetails.globalPosition),
          //   //       paint: Paint()
          //   //         ..strokeCap = StrokeCap.round
          //   //         ..isAntiAlias = true
          //   //         ..color = selectedColor.withOpacity(0.8)
          //   //         ..strokeWidth = 30.0));
          //   //
          //   //   points.add(null);
          //   //
          //   //   counter++;
          //   //   selectedColorList.add(selectedColor);
          //   //   colors.remove(selectedColor);
          //   //   selectedColor = colors[0];
          //   // });
          // },
          child: Container(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "images/delpaintt.png",
                      ),
                    ),
                    border: Border.all(
                        width: 12, //
                        color: Colors
                            .black //                <--- border width here
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
                  bottom: MediaQuery.of(context).size.height * 0.095,
                  child: Column(
                    children: [
                      Text(
                        widget.event.name,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontFamily: 'BrushScript',
                        ),
                      ),
                      Text(
                        '${widget.event.time},  ${widget.event.date}',
                        style: TextStyle(
                          fontSize: 18.0,
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
          /*child: Image.memory(
            "pngBytes1,",
          ),*/
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

// void changeColor(BuildContext context) {
//   //mColors.add(selectedColor);
//   //print(mColors.toString());
//   //print(showColorsList.toString());
//   ///print('oncolor');
//   showColorsList.remove(selectedColor);
//   //print(showColorsList.toString());
//
//   Navigator.of(context, rootNavigator: true).pop('dialog');
// }

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

createUserSignEventDialog(BuildContext context) {
  String email, name;
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0))),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorSelectionContainer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 0.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      onChanged: (val) {
                        name = val;
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700),
                        hintText: 'Name',
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 24.0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: emailController,
                      onChanged: (val) {
                        email = val;
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  CameraWidget(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 24.0, bottom: 8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.063,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        color: Colors.black,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          // if (name == '' || name == null) {
                          //   Toast.show('Name is required', context,
                          //       duration: Toast.LENGTH_LONG,
                          //       gravity: Toast.BOTTOM);
                          // } else if (email == '' || email == null) {
                          //   Toast.show('eEmail address is required', context,
                          //       duration: Toast.LENGTH_LONG,
                          //       gravity: Toast.BOTTOM);
                          // } else if (!validateEmail(email)) {
                          //   Toast.show('eEmail address is not valid', context,
                          //       duration: Toast.LENGTH_LONG,
                          //       gravity: Toast.BOTTOM);
                          // } else {
                          //   //TODO
                          //   //changeColor(context);
                          // }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "SUBMIT",
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
                ],
              ),
            ),
          ),
        );
      });
}

class ColorSelectionContainer extends StatefulWidget {
  @override
  _ColorSelectionContainerState createState() =>
      _ColorSelectionContainerState();
}

class _ColorSelectionContainerState extends State<ColorSelectionContainer> {
  @override
  void initState() {
    super.initState();
    selectedColor = colors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {

              Navigator.of(context, rootNavigator: true).pop('dialog');
            },
            child: Icon(
              Icons.close,
              size: 32.0,
              color: Colors.black,
            ),
          ),
          alignment: Alignment.topRight,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          padding: EdgeInsets.only(top: 16.0),
          child: Image.asset(
            'images/icon_fingerprint.png',
            color: selectedColor,
          ),
          alignment: Alignment.center,
        ),
        Container(
          margin: EdgeInsets.only(top: 50.0),
          padding: EdgeInsets.only(right: 8.0),
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _colorSelectionItem(
                color: colors[0],
              ),
              _colorSelectionItem(
                color: colors[1],
              ),
              _colorSelectionItem(
                color: colors[2],
              ),
              _colorSelectionItem(
                color: colors[3],
              ),
            ],
          ),
          alignment: Alignment.topRight,
        ),
      ],
    );
  }

  Widget _colorSelectionItem({@required Color color}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedColor = color;
          //showColorsList.remove(selectedColor);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2, //
            color: selectedColor == color ? Colors.black : Colors.white,
          ),
        ),
        child: Image.asset(
          'images/box_icon.png',
          color: color,
        ),
      ),
    );
  }
}
