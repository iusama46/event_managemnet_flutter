//TODO
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_drawer.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
        child: MainDrawer(),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          // Icon(Icons.person),
        ],
        title: Text('Notifications'),
        leading: InkWell(
          onTap: () => _drawerKey.currentState.openDrawer(),
          child: Image.asset(
            'images/menu_icon.png',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'You don' + 't have any Notifications',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          trailing: Text('Sign In'),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset("images/icon_male_user.png"),
          ),
          title: Text("Test"),
          subtitle: Text('12:00 pm , 22 Oct ,2020'),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Divider(
            height: 2.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
