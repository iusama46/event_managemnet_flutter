import 'package:event_managemnet/dialogs/event_started.dart';
import 'package:event_managemnet/model/event_model.dart';
import 'package:event_managemnet/screens/drawing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createStartDialog(BuildContext context, Event event) {
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
                  Container(
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context, rootNavigator: true)
                        //     .pop('dialog');
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
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 12, //
                                color: Colors
                                    .black //                <--- border width here
                                ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 12, //
                                  color: Colors.blue[
                                      100] //                <--- border width here
                                  ),
                            ),
                            child: Image.asset(
                              "images/del.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 24.0,
                            child: Column(
                              children: [
                                Text(
                                  event.name,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontFamily: 'BrushScript',
                                  ),
                                ),
                                Text(
                                  '${event.time}, ${event.date}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.063,
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        color: Colors.black,
                        onPressed: () {

                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DrawPage(event: event,)),
                            );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "START EVENT",
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
            ));
      });
}
