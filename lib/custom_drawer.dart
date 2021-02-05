import 'package:event_managemnet/main.dart';
import 'package:event_managemnet/screens/login_page.dart';
import 'package:event_managemnet/screens/view_events_page.dart';
import 'package:flutter/material.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: new AssetImage("images/user_profile.png"),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  CheckUser.name,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  height: 3.0,
                ),

// Text(
//   'email',
//   style: TextStyle(
//     fontSize: 16.0,
//     fontWeight: FontWeight.w400,
//   ),
// ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
//Now let's Add the button for the Menu
//and let's copy that and modify it
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewEventsPage()),
            );
          },
          leading: Icon(
            Icons.event,
            color: Colors.black,
          ),
          title: Text(" My Event"),
        ),

        ListTile(
          onTap: () {
//createStartDialog(context);
          },
          leading: Icon(
            Icons.info_outline_rounded,
            color: Colors.black,
          ),
          title: Text("About Us"),
        ),

        ListTile(
          onTap: () {
            Navigator.of(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          leading: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          title: Text("Logout"),
        ),
      ]),
    );
  }
}
