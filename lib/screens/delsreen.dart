import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

class ColorPickerWidget extends StatefulWidget {
  final Uint8List imagePath;

  ColorPickerWidget(this.imagePath);

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  //String imagePath = 'images/wall.png';
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  // CHANGE THIS FLAG TO TEST BASIC IMAGE, AND SNAPSHOT.
  bool useSnapshot = true;

  // based on useSnapshot=true ? paintKey : imageKey ;
  // this key is used in this example to keep the code shorter.
  GlobalKey currentKey;

  final StreamController<Color> _stateController = StreamController<Color>();
  img.Image photo;

  @override
  void initState() {
    currentKey = useSnapshot ? paintKey : imageKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String title = useSnapshot ? "snapshot" : "basic";
    return Scaffold(
      appBar: AppBar(title: Text("Color picker $title")),
      body: StreamBuilder(
          initialData: Colors.green[500],
          stream: _stateController.stream,
          builder: (buildContext, snapshot) {
            Color selectedColor = snapshot.data ?? Colors.green;
            return Container(

              child: Stack(
                children: <Widget>[
                  RepaintBoundary(
                    key: paintKey,
                    child: GestureDetector(
                      onTap: () {
                        print(selectedColor.toString());
                        print(Colors.green.toString());
                        const redColor = Color(0xfff44b3e);
                        if(redColor==selectedColor){
                          print('red');
                        } else if(selectedColor==Colors.green){
                          print('grren');
                        }
                      },
                      onPanDown: (details) {
                        searchPixel(details.globalPosition);
                        print('kkk');
                        print(details.globalPosition);
                        print(details.localPosition);
                      },
                      onPanUpdate: (details) {
                        searchPixel(details.globalPosition);
                        print('ddk');
                      },
                      child: Center(
                        child: Image.memory(
                          widget.imagePath,
                          key: imageKey,
                          //color: Colors.red,
                          //colorBlendMode: BlendMode.hue,
                          //alignment: Alignment.bottomRight,
                          fit: BoxFit.none,
                          //scale: .8,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          }),
    );
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await (loadSnapshotBytes());
      //await loadImageBundleBytes();
    }
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (!useSnapshot) {
      double widgetScale = box.size.width / photo.width;
      print(py);
      px = (px / widgetScale);
      py = (py / widgetScale);
    }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    _stateController.add(Color(hex));
  }

  // Future<void> loadImageBundleBytes() async {
  //   ByteData imageBytes = await rootBundle.load();
  //   setImageBytes(imageBytes);
  // }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
