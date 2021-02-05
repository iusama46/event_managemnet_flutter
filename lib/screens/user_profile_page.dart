import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../custom_drawer.dart';


/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


class CustomTextWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;

  CustomTextWidget({this.controller, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        showCursor: false,
        readOnly: true,
        onChanged: (val) {},
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.020,
            color: Colors.black,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          prefixIcon: Icon(
            iconData,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  var name = new TextEditingController();
  var address = new TextEditingController();
  var email = new TextEditingController();
  var password = new TextEditingController();
  var phoneNo = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = 'Test Name';
    address.text = 'Test address';
    email.text = 'test@test@.com';
    phoneNo.text = '+9201000000';
    password.text = '**********';
    //openDir();
  }

  Box box;

  void openDir() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('user');
    address.text = 'None';
    name.text = box.get('fullName').toString();
    phoneNo.text = box.get('phoneNo').toString();
    email.text = box.get('email').toString();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          child: Container(
            child: MainDrawer(),
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white,
        //appBar:
        body: Material(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: CircleClipper(position: Position.Left),
                      child: Container(color: Color(0xff22222E)),
                    ),
                    ClipPath(
                      clipper: CircleClipper(position: Position.Right),
                      child: Container(
                        color: Color(0xff22222E),
                      ),
                    ),
                    Positioned.fill(
                      child: ClipPath(
                        clipper: ProfileClipper(),
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PreferredSize(
                                  preferredSize:
                                      Size.fromHeight(kToolbarHeight + 0.0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8.0, top: 8.0, left: 2.0),
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0,
                                                top: 8.0,
                                                bottom: 8.0),
                                            child: MaterialButton(
                                              elevation: 12.0,
                                              onPressed: () => _drawerKey
                                                  .currentState
                                                  .openDrawer(),
                                              color: Colors.white,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 24,
                                                child: Image.asset(
                                                  'images/menu_icon.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              shape: CircleBorder(),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                          ),
                                          Container(
                                            color: Colors.white,
                                            child: Text(
                                              'My Profile',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new AssetImage(
                                              "images/user_profile.png"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 14.0,
                                    ),
                                    Text(
                                      name.text,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //margin:EdgeInsets.only(top:  MediaQuery.of(context).size.height*0.1),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 0.0),
                    child: Column(
                      children: [
                        CustomTextWidget(
                          iconData: Icons.person_outline,
                          controller: name,
                        ),
                        CustomTextWidget(
                          iconData: Icons.pin_drop_outlined,
                          controller: address,
                        ),
                        CustomTextWidget(
                          iconData: Icons.email_outlined,
                          controller: email,
                        ),
                        CustomTextWidget(
                          iconData: Icons.smartphone_outlined,
                          controller: phoneNo,
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
  }
}

enum Position { Left, Right }

class CircleClipper extends CustomClipper<Path> {
  Position position;

  CircleClipper({this.position = Position.Left});

  @override
  getClip(Size size) {
    var path = Path();
    switch (position) {
      case Position.Left:
        _drawLeftCircle(size, path);
        // TODO: Handle this case.
        break;
      case Position.Right:
        _drawRightCircle(size, path);
        // TODO: Handle this case.
        break;
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

  _drawLeftCircle(Size size, Path path) {
    Paint paint = Paint()..color = Color(0x22222E);
    path.arcTo(
        Rect.fromCenter(
            center: Offset(size.width * 0.8, 0),
            width: size.width * 1.5,
            height: size.width * 1.5),
        0,
        180,
        true);
    return path;
  }

  _drawRightCircle(Size size, Path path) {
    path.arcTo(
        Rect.fromCenter(
            center: Offset(size.width * 0.35, size.width * 0.060),
            width: size.width * 1.5,
            height: size.width * 1.5),
        0,
        180,
        true);
    return path;
  }
}

class ProfileClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();

    _drawTopCircle(size, path);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

  _drawTopCircle(Size size, Path path) {
    path.arcTo(
        Rect.fromCenter(
            center: Offset(size.width / 2, 0),
            width: size.width * 1.5,
            height: size.width * 1.4),
        0,
        180,
        true);
    return path;
  }
}

/*
PreferredSize(
preferredSize: Size.fromHeight(kToolbarHeight + 16.0),
child: Padding(
padding: const EdgeInsets.only(right: 4.0, top: 8.0, left: 8.0),
child: Container(
color: Colors.white,
child: Stack(
children: [
Padding(
padding: const EdgeInsets.only(
right: 8.0, top: 8.0, bottom: 8.0),
child: MaterialButton(
elevation: 12.0,
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => ProfilePage()),
);
},
color: Colors.white,
child: CircleAvatar(
backgroundColor: Colors.white,
radius: 24,
child: Image.asset(
'images/menu_icon.png',
fit: BoxFit.fill,
),
),
shape: CircleBorder(),
),
),
Center(
child: Text(
'My Profile',
style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat'),
)),
],
),
),
),
),*/
