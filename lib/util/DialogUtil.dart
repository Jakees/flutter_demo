
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/net/HttpUtil.dart';

class DialogUtil {



  static Future<Null> showBaseDialog(
      BuildContext context,
      String title,
      String content) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                HttpUtil.httpTestNoClient(HttpUtil.TEST_URL);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}