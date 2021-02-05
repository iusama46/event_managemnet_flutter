import 'package:event_managemnet/screens/widgets/event_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_drawer.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class ViewEventsPage extends StatefulWidget {
  @override
  _ViewEventsPageState createState() => _ViewEventsPageState();
}

class _ViewEventsPageState extends State<ViewEventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: Drawer(
          child: Container(
            child: MainDrawer(),
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Events'),
          leading: InkWell(
            onTap: () => _drawerKey.currentState.openDrawer(),
            child: Image.asset(
              'images/menu_icon.png',
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 8.0),
          child: ListView(
            children: [
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
              ListItem(image: 'images/delwall.png',),
            ],
          ),
        ),
    );
  }
}


/*
body: Center(
child: Text(
'You don' + 't have any past events',
style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
),
),*/
