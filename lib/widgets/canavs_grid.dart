import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectCanvasWidget extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(String) onChange;

  SelectCanvasWidget({this.defaultSelectedIndex = 0, @required this.onChange});

  @override
  _SelectCanvasWidgetState createState() => _SelectCanvasWidgetState();
}

class _SelectCanvasWidgetState extends State<SelectCanvasWidget> {
  int _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              rowTile(
                index: 0,
                context: context,
                image: 'images/item_one.png',
              ),
              SizedBox(
                width: 6.0,
              ),
              rowTile(
                index: 1,
                context: context,
                image: 'images/canvas_one.png',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              rowTile(
                index: 2,
                context: context,
                image: 'images/item_one.png',
              ),
              SizedBox(
                width: 6.0,
              ),
              rowTile(
                index: 3,
                context: context,
                image: 'images/item_two.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rowTile(
      {BuildContext context,
        String image,
        Function onTap,
        @required int index}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.onChange(image);
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            border: Border.all(
                width: 6, //
                color: index == _selectedIndex
                    ? Colors.blue.withOpacity(0.7)
                    : Colors.white),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: 8, //
                  color: Colors.black),
              borderRadius: index == _selectedIndex
                  ? BorderRadius.circular(0.0)
                  : BorderRadius.circular(8.0),
              image:
              DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            ),
          ),
        ),
      ),
    );
  }
}