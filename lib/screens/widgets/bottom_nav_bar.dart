import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../add_event_page.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46


class CustomBottomNavBar extends StatefulWidget {
  final int defaultSelectedIndex;
  final Function(int) onChange;

  CustomBottomNavBar({this.defaultSelectedIndex = 0, @required this.onChange});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.defaultSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(28), topLeft: Radius.circular(28)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomNavItem(iconData: Icons.home, isIcon: true, index: 0),
          _bottomNavItem(
              iconData: Icons.event_outlined, isIcon: true, index: 1),
          Container(
            height: 60.0,
            width: MediaQuery.of(context).size.width / 5,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEventPage()),
                );
              },
              child: Icon(
                Icons.add_box_outlined,
                color: Colors.red.withOpacity(0.9),
                size: 42,
              ),
            ),
          ),
          _bottomNavItem(
              index: 2, iconData: Icons.notifications_outlined, isIcon: true),
          _bottomNavItem(iconData: Icons.person, isIcon: true, index: 3),
          // navItem(isIcon :false,
          //     isActive: true, imageName: 'images/icons_male_user.png', ),
        ],
      ),
    );
  }

  Widget _bottomNavItem(
      {@required int index,
      IconData iconData,
      @required bool isIcon,
      String imageName}) {
    return InkWell(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width / 5,
          child: isIcon
              ? Icon(
                  iconData,
                  color: index == _selectedIndex ? Colors.black : Colors.grey,
                )
              : Image.asset(
                  imageName,
                  color: index == _selectedIndex ? Colors.black : Colors.grey,
                )),
    );
  }
}
