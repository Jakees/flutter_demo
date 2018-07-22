import 'package:flutter/material.dart';
import 'package:flutter_app/util/TextUtil.dart';

class TopBarFactory{

  static Widget createAppBar(String title, {defaultTitle = '', List<Widget> actions = null}) {
    return new AppBar(
      title: new Text(
          '${TextUtil.checkTextNull(title, defaultText: defaultTitle)}',
          style: new TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.white,
      actions: actions,
      centerTitle: true,
    );

  }

}