import 'package:event_managemnet/screens/add_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

List<Color> mColors = [];

List showColorsList = [
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
Color selectedColor;


void changeColor(BuildContext context) {
  //mColors.add(selectedColor);
  //print(mColors.toString());
  //print(showColorsList.toString());
  ///print('oncolor');
  showColorsList.remove(selectedColor);
  //print(showColorsList.toString());

  Navigator.of(context, rootNavigator: true).pop('dialog');
}

void validate() {}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

createUserSignEventDialog(BuildContext context) {
  String email, name;
  var nameController = new TextEditingController();
  //nameController.text = 'John Smith';
  var emailController = new TextEditingController();
  //emailController.text = '123@email.com';

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
                        name=val;
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
                        email=val;

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
                          if (name == '' || name == null) {
                            Toast.show('Name is required', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          } else if (email == '' || email == null) {
                            Toast.show('eEmail address is required', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          } else if(!validateEmail(email)){
                            Toast.show('eEmail address is not valid', context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          } else {
                            changeColor(context);
                          }
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
    selectedColor = showColorsList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
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
                color: showColorsList[0],
              ),
              _colorSelectionItem(
                color: showColorsList[1],
              ),
              _colorSelectionItem(
                color: showColorsList[2],
              ),
              _colorSelectionItem(
                color: showColorsList[3],
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

/*
createUserSignEventDialog(BuildContext context) {
  var nameController = new TextEditingController();
  //nameController.text = 'John Smith';
  var emailController = new TextEditingController();
  //emailController.text = '123@email.com';

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
                      onChanged: (val) {},
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
                      onChanged: (val) {},
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
                        //onPressed: () => createStartDialog(context),
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
}*/
