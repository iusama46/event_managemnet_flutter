import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

createUserSignedDialog(BuildContext context) {
  var nameController = new TextEditingController();
  nameController.text = 'John Smith';
  var emailController = new TextEditingController();
  emailController.text = '123@email.com';

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0))),
          content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.close,
                        size: 32.0,
                        color: Colors.black,
                      ),
                      alignment: Alignment.topRight,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Image.asset(
                        'images/icon_fingerprint.png',
                        color: Colors.orange,
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 0.0),
                  child: TextField(
                    readOnly: true,
                    showCursor: false,
                    controller: nameController,
                    onChanged: (val) {},
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
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
                    readOnly: true,
                    showCursor: false,
                    controller: emailController,
                    onChanged: (val) {},
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.54,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 5, //
                          color: Colors
                              .black //                <--- border width here
                      ),
                      borderRadius: BorderRadius.circular(24.0),
                      image: DecorationImage(
                          image: AssetImage('images/wall.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

