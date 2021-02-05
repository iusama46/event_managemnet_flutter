import 'package:event_managemnet/screens/widgets/event_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../custom_drawer.dart';
import 'constants.dart';
import 'event_page.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _drawerKey,
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: MainDrawer(),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0, top: 8.0, left: 2.0),
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
                        //Scaffold.of(context).openDrawer();
                        _drawerKey.currentState.openDrawer();
                        // Toast.show('Drawer is not included in xd file', context,
                        //     duration: Toast.LENGTH_SHORT,
                        //     gravity: Toast.BOTTOM);
                      },
                      color: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Image.asset('images/menu_icon.png'),
                      ),
                      shape: CircleBorder(),
                    ),
                  ),
                  Center(
                      child: Text(
                    kAppNameSignature,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat'),
                  )),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RowTile(
                    image: 'images/item_one.png',
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  RowTile(
                    image: 'images/item_two.png',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  RowTile(
                    image: 'images/item_three.png',
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  RowTile(
                    image: 'images/item_four.png',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 24.0, right: 24.0, left: 24.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Past Events",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 16.0),
                  ),
                  InkWell(
                    child: Text(
                      "See All",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 14.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, right: 16.0, left: 16.0, bottom: 4.0),
                child: ListView(
                  children: [
                    ListItem(
                      image: 'images/delwall.png',
                    ),
                    ListItem(
                      image: 'images/delwall.png',
                    ),
                    ListItem(
                      image: 'images/delwall.png',
                    ),
                    ListItem(
                      image: 'images/delwall.png',
                    ),
                    ListItem(
                      image: 'images/delwall.png',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowTile extends StatelessWidget {
  final String image;

  RowTile({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}





/*

body: Center(
child: Row(

mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(
Icons.add_box_outlined,
color: Colors.red.withOpacity(0.9),
size: 42,
),
Text(
'Click to add event',
style: TextStyle(
fontSize: 20.0,
),
),
],
),
),*/
