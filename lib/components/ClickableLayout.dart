import 'package:flutter/material.dart';
import 'package:flutter_app/util/TextUtil.dart';

/**
 * 通用 点击Item
 */
class ClickableLayout {

  /**
   * @listener: 点击 回调事件
   *
   */
  static Widget createClickableLayout(String title, {
    marginTop = 0.5,
    Widget leftIcon,
    leftIconTextMargin = 0.0,
    VoidCallback listener,
  }) {
    return new Container(
        height: 50.0,
        margin: EdgeInsets.only(top: marginTop),
        color: Colors.white,
        child: new FlatButton(
            onPressed: () => listener(),
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(margin: EdgeInsets.only(right: leftIconTextMargin),child: leftIcon),
                        new Text(title,
                            style:
                            TextUtil.createTextStyle(color: Colors.black))
                      ],
                    )
                ),
                new Expanded(
                    child: new Align(
                      alignment: Alignment.centerRight,
                      child: new Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey[300],
                      ),
                    ))
              ],
            )
        )
    );
  }
}