import 'dart:io';

import 'package:event_managemnet/dialogs/create_event.dart';
import 'package:event_managemnet/model/event_model.dart';
import 'package:event_managemnet/widgets/canavs_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

import 'constants.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


class AddEventPage extends StatefulWidget {
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TimeOfDay selectedTime = TimeOfDay.now();
  Event event = Event();
  DateTime selectedDate = DateTime.now();
  var textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    event.date = '$selectedDate.toLocal()'.split(' ')[0];
    event.time = '${selectedTime.hour} : ${selectedTime.minute}';
    event.isCompleted = false;
    event.isScheduled = true;
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        event.date = '$selectedDate.toLocal()'.split(' ')[0];
        textController.text = '${event.date}  ${event.time}';
        print('date');
      });
    }

    if (picked_s != null && picked_s != selectedTime) {
      print(textController.text);
      setState(() {
        selectedTime = picked_s;
        event.time = '${picked_s.hour} : ${picked_s.minute}';
        textController.text = '${event.date}  ${event.time}';
      });
    }
  }

  void validate() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (event.name == '' || event.name == null) {
      Toast.show('Event name is required', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else if (event.location == '' || event.location == null) {
      Toast.show('Event address is required', context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      //TODO uploadeData()
      createStartDialog(context, event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kToolBarColor,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          'Add Event',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Montserrat',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 2.0),
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'Select Canvas',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SelectCanvasWidget(
                  onChange: (val) {
                    print(val);
                  },
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 8.0, left: 2.0),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.075),
                  child: Text(
                    'Event Information',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            event.name = val.toString();
                          },
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'OpenSans'),
                          decoration: InputDecoration(
                            hintText: "Event Name",
                            hintStyle: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                            prefixIcon: Icon(
                              Icons.event_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          onChanged: (val) {
                            event.location = val.toString();
                          },
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'OpenSans'),
                          decoration: InputDecoration(
                            hintText: "Address",
                            hintStyle: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                            prefixIcon: Icon(
                              Icons.pin_drop_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: TextField(
                          controller: textController,
                          showCursor: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _selectDate(context);
                          },
                          readOnly: true,
                          onChanged: (val) {},
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'OpenSans'),
                          decoration: InputDecoration(
                            hintText: 'Date',
                            hintStyle: TextStyle(
                                color: Colors.black, fontFamily: 'OpenSans'),
                            prefixIcon: Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.063,
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      color: Colors.black,
                      onPressed: () => validate(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "CREATE EVENT",
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
      ),
    );
  }
}

class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getImage,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 4, //
                  color: Colors.black //                <--- border width here
                  ),
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: _image != null
                      ? FileImage(_image)
                      : AssetImage('images/wall.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Image.asset('images/icons_camera.png'),
        ],
      ),
    );
  }
}

// class RowTile extends StatelessWidget {
//   final String image;
//
//   RowTile({@required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Card(
//         elevation: 0,
//         color: Colors.transparent,
//         child: Container(
//           width: MediaQuery.of(context).size.width / 3,
//           height: MediaQuery.of(context).size.height * 0.15,
//           decoration: BoxDecoration(
//             border: Border.all(
//                 width: 8, //
//                 color: Colors.black),
//             borderRadius: BorderRadius.circular(8.0),
//             image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
//           ),
//         ),
//       ),
//     );
//   }
// }

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
        width: 8, //
        color: Colors.black //                <--- border width here
        ),
  );
}

// class MyGridView extends StatelessWidget {
//   const MyGridView({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> _listItem = [
//       'images/item_one.png',
//       'images/item_one.png',
//       'images/item_one.png',
//       'images/item_one.png',
//     ];
//     return Expanded(
//       child: Container(
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           padding: const EdgeInsets.all(24.0),
//           children: _listItem
//               .map((item) => Card(
//             elevation: 0,
//             color: Colors.transparent,
//             child: Container(
//               height: 10.0,
//               width: 10.0,
//               child: Image.asset(
//                 'images/wall.png',
//                 height: 100,
//                 width: 400,
//               ),
//             ),
//           ))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }
