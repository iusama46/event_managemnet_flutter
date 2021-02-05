import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createStartDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24.0))),
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About Us',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                          child: Icon(
                            Icons.close,
                            size: 32.0,
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.topRight,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Text(
                    'about msg',

                  ),
                ],
              ),
            ));
      });
}
