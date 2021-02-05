import 'package:event_managemnet/screens/event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Created by Ussama Iftikhar on 02-Jan-2021.

/// Email iusama46@gmail.com

/// Email iusama466@gmail.com

/// Github https://github.com/iusama46

class ListItem extends StatelessWidget {
  final String image;

  ListItem({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventPage(
                      counter: 75,
                    )),
          );
        },
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
            border: Border.all(
                width: 6, //
                color: Colors.black),
            borderRadius: BorderRadius.circular(6.0),
            image: DecorationImage(
                image: image != null
                    ? AssetImage(image)
                    : AssetImage('images/delwall.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
